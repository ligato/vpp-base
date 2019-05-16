# vpp-base

The vpp-base repository provides tools for building docker images for VPP.

🚧 This repository is currently in experimental stage and breaking changes might happen!

---

## Image Contents

The vpp-base image consists of:
 
- installed VPP ready to be started (uses default config: `/etc/vpp/startup.conf`)
- script for installing/downloading VPP from [PackageCloud](https://packagecloud.io/fdio) (script is located at `/vpp/get-vpp.sh`)
- downloaded VPP packages ready to be installed (stored in `/vpp/*.deb`)
- file containing full VPP version, e.g. _19.04.1-rc0~8-gad62a0e91~b49_ (located at `/vpp/version`) 

## Quickstart

Following command will get you vpp-base image that comes with recent version of VPP:

```sh
➢ docker pull ligato/vpp-base
```

To show the actual VPP version contained in the image, run:

```sh
➢ docker run --rm ligato/vpp-base cat /vpp/version
```

## Published Images

The vpp-base images are built continuously and published to DockerHub: [ligato/vpp-base](https://hub.docker.com/r/ligato/vpp-base).

Beside the `vpp-base:latest` image built from master, there are images with stable VPP version. These images are tagged with the respective VPP version they contain: `ligato/vpp-base:YYMM`. 

Following images are currently published and available on DockerHub:

| Image | Details | VPP source |
|---|---|---|
|[![ligato/vpp-base:latest](https://img.shields.io/badge/ligato/vpp--base-latest-099cec.svg?logo=docker&logoColor=white&style=popout)](https://cloud.docker.com/u/ligato/repository/docker/ligato/vpp-base)|![MicroBadger Size](https://img.shields.io/microbadger/image-size/ligato/vpp-base/latest.svg) ![MicroBadger Layers](https://img.shields.io/microbadger/layers/ligato/vpp-base/latest.svg) | [![master](https://img.shields.io/badge/packagecloud_repo-master-37327b.svg?logo=debian)](https://packagecloud.io/fdio/master) |
|[![ligato/vpp-base:1904](https://img.shields.io/badge/ligato/vpp--base-1904-blue.svg?logo=docker&logoColor=white&style=popout)](https://cloud.docker.com/u/ligato/repository/docker/ligato/vpp-base)|![MicroBadger Size](https://img.shields.io/microbadger/image-size/ligato/vpp-base/1904.svg) ![MicroBadger Layers](https://img.shields.io/microbadger/layers/ligato/vpp-base/1904.svg) | [![1904](https://img.shields.io/badge/packagecloud_repo-1904-37327b.svg?logo=debian)](https://packagecloud.io/fdio/1904) |
|[![ligato/vpp-base:1901](https://img.shields.io/badge/ligato/vpp--base-1901-blue.svg?logo=docker&logoColor=white&style=popout)](https://cloud.docker.com/u/ligato/repository/docker/ligato/vpp-base)|![MicroBadger Size](https://img.shields.io/microbadger/image-size/ligato/vpp-base/1901.svg) ![MicroBadger Layers](https://img.shields.io/microbadger/layers/ligato/vpp-base/1901.svg )| [![1901](https://img.shields.io/badge/packagecloud_repo-1901-37327b.svg?logo=debian)](https://packagecloud.io/fdio/1901) |

The complete list of available image tags can be found on [DockerHub](https://hub.docker.com/r/ligato/vpp-base/tags).

## Building Images

To build custom vpp-base image you can simply use docker build command with without cloning this git repository, you can use:

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

## Makefile Usage

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
