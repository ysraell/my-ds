# my-ds
My data science Docker image.


Donations in Monero (XMR):
```console
44EUwyLJFj7XS1eiZDAzdfHWkwfm2SWHghMaDoVS7k9kDpma41ZMiJk9jf1DmAX2oa4RAu5ShRMdxMosFc7Pdvn6UM83EhM
```

[![Python 3.7](https://img.shields.io/badge/Python-3.7-gree.svg)](https://www.python.org/downloads/release/python-370/)
[![Docker 20.10](https://img.shields.io/badge/Docker%20Engine-20.10-blue.svg)](https://docs.docker.com/engine/release-notes/)


Base image: `python:3.7-buster`

## Image name:
Set image name:

```bash
./set_image_name.sh my-ds-image-name
```

## Building:
To build the image:

```bash
./build.sh
```

## Running:
To run the image and set up the servers:

```bash
./run.sh
```

Wait for get the JupterLab URL access.

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
