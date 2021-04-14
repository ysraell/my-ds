# my-ds
My data science Docker image.

[![Python 3.8](https://img.shields.io/badge/Python-3.8-gree.svg)](https://www.python.org/downloads/release/python-370/)
[![Docker 20.10](https://img.shields.io/badge/Docker%20Engine-20.10-blue.svg)](https://docs.docker.com/engine/release-notes/)


Base image: `python:3.8-buster`

## Settings:
Check `settings.yml` first!

## Building:
To build the image:

```bash
./build.sh
```

## Start:
To start the image and set up the servers:

```bash
./start.sh
```

Wait for get the JupterLab URL access.

## JupterLab URL:
To get the JupterLab URL access:

```bash
./list_jupyter.sh
```

## Stopping:
To stop the container:

```bash
./stop.sh
```

## Run a shell in the running container:
To enter into container:

```bash
./bash.sh
```

or

```bash
./zsh.sh
```

## Run Stremalit apps:

```bash
python3 -m launchpad.main --port 8000 ./folder_with_pys
```

- Or check script `servers.sh` and uncomment the respective line.
