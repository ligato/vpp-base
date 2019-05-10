# vpp-base

🚧 **This repository is currently in experimental stage!**

The vpp-base provides docker images used as base for running or building VPP.

The images are built daily and published to [ligato/vpp-base](https://hub.docker.com/r/ligato/vpp-base) on DockerHub.

## Quick start

Following command will get you vpp-base image that comes with _relatively_ recent version of VPP (from master branch):

```sh
$ docker pull ligato/vpp-base:latest
```

## Image versions available

Beside the `vpp-base:latest` image, there are images with stable VPP version. These images are tagged with the respective VPP version they contain: `ligato/vpp-base:YYMM`. 

These images are currently available on DockerHub:

| Image tag | VPP version |
|---|---|
| `ligato/vpp-base:latest` | master |
| `ligato/vpp-base:1904` |  stable/1904 |
| `ligato/vpp-base:1901` |  stable/1901 |

The complete list of available tags can be found on [DockerHub](https://hub.docker.com/r/ligato/vpp-base/tags).

## Building custom image

You can easily build your own vpp-base image locally without even cloning this repo! Following command will build image with specific VPP version:

```sh
$ docker build -t my-vpp-base --build-arg VPP_VERSION=19.08-rc0~196-g7fe470a54~b2759 github.com/ligato/vpp-base
```

## Local usage

To build VPP image using specific package, run:

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

To run some image in container, run:

```sh
# starts container
$ make start

# opens VPP CLI (vppctl) in container
$ make vppctl

# stops container
$ make stop
```

For quick access to CLI run `make run`, it will start container and open VPP CLI.
