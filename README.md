# My-DS
My data science Docker image.

[![Python 3.7](https://img.shields.io/badge/Python-3.7-gree.svg)](https://www.python.org/downloads/release/python-370/)
[![Python 3.8](https://img.shields.io/badge/Python-3.8-gree.svg)](https://www.python.org/downloads/release/python-380/)
[![Python 3.9](https://img.shields.io/badge/Python-3.9-gree.svg)](https://www.python.org/downloads/release/python-390/)
[![Python 3.10](https://img.shields.io/badge/Python-3.10-gree.svg)](https://www.python.org/downloads/release/python-3100/)

[![Docker 20.10](https://img.shields.io/badge/Docker%20Engine-20.10-blue.svg)](https://docs.docker.com/engine/release-notes/)
![](https://img.shields.io/badge/Work%20on-Linux%20%26%20macOS-blue)


Base Docker image: `python`

## Run with *Docker Compose*:

in Linux:

```bash
$ docker-compose -f docker-compose.yml up
```
in Windows with `docker-compose.windows.yml` and check mount point in `settings.yml` beafore use.

```bash
C:\Users\UserLogin> mkdir work
C:\Users\UserLogin> cd work
 - Download docker-compose.windows.yml to C:\Users\UserLogin\work -
C:\Users\UserLogin\work> docker-compose -f docker-compose.windows.yml up
```

Alter pulled the image, it will return the link for JupyterLab with a token, like this:

```bash
workstation_1 | or http://127.0.0.1:8888/lab?token=2ee0f77e160ce90db827324b66a516c3b26e04e5c7a5e511
```

## Settings:
Check `settings.yml` first!

## Building:
To build the image:

```bash
$ ./scripts/build.sh
```

## Start:
To start the image and set up the servers:

```bash
$ ./scripts/start.sh
```

Wait for get the JupterLab URL access.

## JupterLab URL:
To get the JupterLab URL access:

```bash
$ ./scripts/list_jupyter.sh
```

## Stopping:
To stop the container:

```bash
$ ./scripts/stop.sh
```

## Run a shell in the running container:
To enter into container:

```bash
$ ./scripts/bash.sh
```

or

```bash
$ ./scripts/zsh.sh
```

## Run Stremalit apps:

```bash
$ ./scripts/bash.sh
$ python3 -m launchpad.main --port 8000 ./folder_with_pys
```

- Or check script `servers.sh` and uncomment the respective line.

### To create symbolic links to scripts:

```bash
$ for a in `ls  scripts/*.sh`;
    do
        ln -s $a `echo $a |cut -d '/' -f 2 |cut -d '.' -f 1`
    done
```

### TODO:

- Use Poetry insted self management based on `settings.yml`.
    - Dev. script for add a package python in running container directly from host's shell.

`ψυχήδηλειν`
