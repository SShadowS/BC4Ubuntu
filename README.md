
# BC4Ubuntu
![htop](https://user-images.githubusercontent.com/3491765/219025165-7099dc7e-fac7-4f83-a6d4-f83e67472161.png)
Repo for my project of getting Microsoft Business Central running on Ubuntu.

## Current tasklist: 
- [x] Run NST on Ubuntu via Wine
- [x] Connect NST to SQL
- [x] Run code on NST
- [ ] Management endpoint
- [X] Dev endpoint
- [X] SOAP and Odata endpoints
- [X] Client Services endpoint
- [ ] Use IIS on Windows machine for Webclient
- [ ] When done with above, give a beer to all contributors at BCTechDays

## Status:
- Management endpoint
	* Crashes the Wine server, do not enable.
- SOAP endpoint
	* Not fully tested, replies to simple requests
- ODATA endpoint
	* Not fully tested, replies to simple requests
- Client Services endpoint
	* Not fully tested, replies to simple requests
- Developer Endpoint
	* Can publish Apps
	* Currently a bug with downloading symbols, think I got a fix
- Taskscheduler
	* Works

## Known bugs/limitations
- The NST is bad at dropping Http connections on errors. Need to work a bit more on HttpCancelHttpRequest() in HttpApi
- Downloading of symbols fails.
- No SSL (HTTPS), skipping CertStore until I relly need it.

## Requirements:
The versions are what I have tested with. Other versions might work as well.
Dev machine with:
- Ubuntu Server 22.04 LTS VM
- Custom Wine64 build from my repo https://github.com/SShadowS/wine64-bc4ubuntu
- Docker container with Business Central BC22 or never
- Local SQL Server
- Time to spare
- High tolerance for frustration

## How to install
Note: This is a work in progress. The following steps are not complete and will change. The following steps are for testing purposes only. Do not use this in production.

<font size="10">[Guide here](../main/HOW%20TO.md)</font>
