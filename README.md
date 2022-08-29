# custom-kali-docker
Custom Kali docker image utilizing Kasm for browser streaming

![image](https://user-images.githubusercontent.com/96201375/186751944-90257f15-b853-4588-baec-3b4f357c9edc.png)

### Installation
- pull in docker image from github
```bash
$ docker pull ghcr.io/gr4ysku11/custom-kali-docker:latest
$ docker run --rm  -it --shm-size=512m -p 6901:6901 -e VNC_PW=password ghcr.io/gr4ysku11/custom-kali-docker:latest
```
- browse to https://localhost:6901
- login using "kasm_user:password"

```bash
# NOTE: if you need to mount local assets within the docker container, add --privileged to the 'docker run' command
$ docker run --privileged ...
```

### Features
- Stream Kali Linux through a browser
- Proper dynamic resizing and scaling, thanks to kasmvnc
- Stateless image, giving a clean slate to work in upon every launch (similar to a vm snapshot)
- pre installed packages that I most commonly use (autorecon, vscode + plugins, etc...)
- python 2 and 3 virtual environments

### Installed packages
```bash
# my commonly used packages
code-oss    # requires additional setup for installing extensions
git
keepassxc
chromium
firefox-esr
virtualenv
bloodhound

# autorecon packages
seclists
curl
enum4linux
feroxbuster
impacket-scripts
nbtscan
nikto
nmap
onesixtyone
oscanner
redis-tools
smbclient
smbmap
snmp
sslscan
sipvicious
tnscmd10g
whatweb
wkhtmltopdf
```

### Custom Hooks For
- python virtualenv's for both python 2 and 3
  - autorecon (python3)
  - sshuttle (python3)
  - impacket (python2/3)

virtual python environments are located in /pyenv/python\* directories
