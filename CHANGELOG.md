# release_2.3 CHANGELOG

## [Unreleased]

### New Features

- replace aioredis by redis.asyncio (#276)
- upgrade pydantic to 1.10.14 and other packages (#277)
- upgrade fastapi, starlette, Jinja2 and python-multipart (for security reasons) (#281)
- upgrade redis from 4.2.2 to 4.4.4 (security) (#288)
- bump idna from 3.3 to 3.7 to fix CVE-2024-3651 (#292)
- add initscripts, make and crontab as dependencies (#296)
- bump Jinja2 to 3.1.4 (CVE-2024-34064) (#299)
- upgrade python-ldap from 3.4.0 to 3.4.3 (#301)
- bump certifi to 2024.7.4 (to fix CVE-2024-39689) (#306)
- bump zipp from 3.16.2 to 3.19.2 (fix CVE-2024-5569) (#308)
- upgrade typing-extensions to 3.10.0 (same as in python3_core) (#310)
- upgrade asgiref to 3.5.2 (compat shiny 1.0.0) (#311)
- feat: bump starlette from 0.36.3 to 0.40.0 to fix CVE-2024-47874
- bump typing-extensions to 4.12.2 (Python 3.13 compatibility) (#317)
- bump python-multipart from 0.0.9 to 0.0.19 (fix CVE-2024-53981)
- bump Jinja2 to 3.1.5 (CVE-2024-56201 and CVE-2024-56326)  (#321)
- bump Jinja2 to 3.1.6 (CVE-2025-27516) (#325)
- bump python-ldap from 3.4.3 to 3.4.4 (#328)
- bump h11 from 0.13.0 to 0.16.0 (fix critical CVE-2025-43859) (#331)
- add openjdk 11 for mfadmin (mfext now provides openjdk 21) (#333)

### Bug Fixes

- bump pydantic to 1.10.17 for Python 3.12.4 compatibility (#303)
- replace deprecated utcnow() by now(datetime.UTC)
- replace deprecated utcnow() by now(datetime.UTC) (#312)
- fix timedelta call (#323)


