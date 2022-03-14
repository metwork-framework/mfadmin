local hmac = require("resty.hmac")
local mfutil = require("mfutil")
local b64 = require("ngx.base64")
local cjson = require("cjson.safe")
local ck = require("resty.cookie")

local _M = {}

local function startswith(strg, start)
    return string.sub(strg, 1, string.len(start)) == start
end

local function assert_not_truncated(err)
    if err == "truncated" then
        mfutil.exit_with_ngx_error(400, "too complex query string or too many headers", "too complex query string or too many headers")
    end
end

local function escape_pattern(text)
    return text:gsub("([^%w])", "%%%1")
end


-- gsplit: iterate over substrings in a string separated by a pattern
--
-- Parameters:
-- text (string)    - the string to iterate over
-- pattern (string) - the separator pattern
-- plain (boolean)  - if true (or truthy), pattern is interpreted as a plain
--                    string, not a Lua pattern
--
-- Returns: iterator
--
-- Usage:
-- for substr in gsplit(text, pattern, plain) do
--   doSomething(substr)
-- end
local function gsplit(text, pattern, plain)
  local splitStart, length = 1, #text
  return function ()
    if splitStart then
      local sepStart, sepEnd = string.find(text, pattern, splitStart, plain)
      local ret
      if not sepStart then
        ret = string.sub(text, splitStart)
        splitStart = nil
      elseif sepEnd < sepStart then
        -- Empty separator!
        ret = string.sub(text, splitStart, sepStart)
        if sepStart < length then
          splitStart = sepStart + 1
        else
          splitStart = nil
        end
      else
        ret = sepStart > splitStart and string.sub(text, splitStart, sepStart - 1) or ''
        splitStart = sepEnd + 1
      end
      return ret
    end
  end
end

-- split: split a string into substrings separated by a pattern.
--
-- Parameters:
-- text (string)    - the string to iterate over
-- pattern (string) - the separator pattern
-- plain (boolean)  - if true (or truthy), pattern is interpreted as a plain
--                    string, not a Lua pattern
--
-- Returns: table (a sequence table containing the substrings)
local function split(text, pattern, plain)
  local ret = {}
  for match in gsplit(text, pattern, plain) do
    table.insert(ret, match)
  end
  return ret
end

local function not_nil_and_null(val)
    if val ~= nil and val ~= "null"  and val ~= ngx.null then
        return true
    end
    return false
end

function _M.get_token()
    local token = nil
    if not_nil_and_null(ngx.var.jwt_cookie) then
        -- Let's try in cookie
        local cookie, err = ck:new()
        if not cookie then
            mfutil.exit_with_ngx_error(500, "server problem", "can't create ck object")
        end
        local token, err = cookie:get(ngx.var.jwt_cookie)
        if token then
            if string.len(token) >= 8 then
                return token, "cookie"
            end
        end
    end
    -- JWT not found
    return nil
end

local function check_token_and_get_payload(token)
    local ok, t, tt
    local encoded_header, encoded_payload, encoded_signature = string.match(token, "^([a-zA-Z0-9%-_=]+).([a-zA-Z0-9%-_=]+).([a-zA-Z0-9%-_=]+)$")
    if encoded_header == nil or encoded_payload == nil or encoded_signature == nil then
        return nil
    end
    tt = b64.decode_base64url(encoded_header)
    if not tt then
        return nil
    end
    t = cjson.decode(tt)
    if t == nil then
        return nil
    end
    if t['alg'] ~= "HS256" then
        return nil
    end
    if t['typ'] ~= "JWT" then
        return nil
    end
    local hmac256 = hmac:new(ngx.var.jwt_secret_key, hmac.ALGOS.SHA256)
    if not hmac256 then
        mfutil.exit_with_ngx_error(500, "server problem", "can't create hmac object")
    end
    ok = hmac256:update(encoded_header)
    if not ok then
        mfutil.exit_with_ngx_error(500, "server problem", "can't update hmac object")
    end
    ok = hmac256:update(".")
    if not ok then
        mfutil.exit_with_ngx_error(500, "server problem", "can't update hmac object")
    end
    ok = hmac256:update(encoded_payload)
    if not ok then
        mfutil.exit_with_ngx_error(500, "server problem", "can't update hmac object")
    end
    local computed_signature = b64.encode_base64url(hmac256:final())
    ok = hmac256:reset()
    if not ok then
        mfutil.exit_with_ngx_error(500, "server problem", "can't final hmac object")
    end
    if computed_signature == encoded_signature then
        tt = b64.decode_base64url(encoded_payload)
        if not tt then
            return nil
        end
        return cjson.decode(tt)
    end
    return nil
end

local function modify_incoming_request(payload, source)
end

function _M.process()
    if not_nil_and_null(ngx.var.jwt_secret_key) == false then
        return
    end
    local tkn = nil
    local source = nil
    -- Read token
    if tkn == nil then
        tkn, source = _M.get_token()
    end
    if tkn == nil then
        return 401, "you must provide a token", nil
    end
    -- Check token and payload validity
    local payload = check_token_and_get_payload(tkn, ngx.var.jwt_secret_key)
    if payload == nil then
        return 403, "invalid token", nil
    end
    -- Check "iat" inside JWT
    local iat = payload['iat']
    if iat == nil then
        return 403, "invalid payload in token (missing iat)", "SAME"
    end
    -- Check "exp" inside JWT
    local exp = payload['exp']
    if exp ~= nil then
        if exp < tonumber(os.date('%s')) then
            return 403, "expired token", nil
        end
    else
        local age = tonumber(os.date('%s')) - iat
        if ngx.var.jwt_max_lifetime ~= "null" then
            if age > tonumber(ngx.var.jwt_max_lifetime) then
                return 403, "expired token (" .. age .. ")", nil
            end
            if age < -7200 then
                return 403, "expired token (" .. age .. ")", nil
            end
        end
    end
    -- Check "username" inside JWT
    local username = payload['username']
    if username == nil then
        return 403, "invalid payload in token (missing username)", "SAME"
    end
    -- Let's modify the incoming request
    modify_incoming_request(payload, source)
    return 200, nil, nil

end

return _M
