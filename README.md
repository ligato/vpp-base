# vpp-base

🚧 **This repository is currently in experimental stage!**

The vpp-base provides docker images used as base for running or building VPP.

The images are built continuously and published to DockerHub: [ligato/vpp-base](https://hub.docker.com/r/ligato/vpp-base).

## Quick start

Following command will get you vpp-base image that comes with _relatively_ recent version of VPP (from master branch):

```sh
$ docker pull ligato/vpp-base
```

## Image versions available

Beside the `vpp-base:latest` image, there are images with stable VPP version. These images are tagged with the respective VPP version they contain: `ligato/vpp-base:YYMM`. 

These images are currently available on DockerHub:

| Image | VPP |
|---|---|
| `ligato/vpp-base:latest` | **master** branch |
| `ligato/vpp-base:1904` |  **stable/1904** branch |
| `ligato/vpp-base:1901` |  **stable/1901** branch |

The complete list of available tags can be found on [DockerHub](https://hub.docker.com/r/ligato/vpp-base/tags).

## Building custom image

To quickly build your own vpp-base image locally  without even cloning this repo, use:

```sh
# Latest VPP
$ docker build github.com/ligato/vpp-base

# Stable VPP 19.04
$ docker build --build-arg REPO='1904' github.com/ligato/vpp-base

# With specific VPP version
$ docker build --build-arg VPP_VERSION='19.08-rc0~196-g7fe470a54' github.com/ligato/vpp-base

# With specific VPP commit
$ docker build --build-arg VPP_VERSION='19.04[^ ]*-g7fe470a54' github.com/ligato/vpp-base
```

## Makefile usage

To build VPP image using specific packagecloud repository, use:

```sh
# for master
$ make build REPO=master
# this works as well REPO=master is default value
$ make build 

# stable/1901
$ make build REPO=1901

# stable/1904
$ make build REPO=1904

# etc..
```
