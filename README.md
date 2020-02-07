<h1 align="center">vpp-base</h1>

<p align="center">
  <a href="https://github.com/ligato/vpp-base/actions?query=workflow%3A%22Build+Images%22"><img src="https://github.com/ligato/vpp-base/workflows/Build%20Images/badge.svg" alt="Workflow"></a>
  <a href="https://microbadger.com/images/ligato/vpp-base"><img src="https://images.microbadger.com/badges/version/ligato/vpp-base.svg" alt="Latest Version"></a>
  <a href="https://hub.docker.com/r/ligato/vpp-base"><img src="https://img.shields.io/docker/pulls/ligato/vpp-base.svg" alt="Docker Pulls"></a>
</p>

<p align="center">The <b>vpp-base</b> builds docker images with VPP.</p>

---

Table of contents:
- [Introduction](#introduction)
- [Quickstart](#quickstart)
- [Images](#images)
- [Building Images](#building-images)

## Introduction

The purpose of vpp-base is to provide docker images with installed VPP.
This is mainly because there are no official docker images provided by the FD.io.

#### Use Cases

* use as a base image in Dockerfiles
* build docker image for custom VPP build
* quickly test something against specific VPP version
* distribute Debian packages for VPP
* generate VPP binary API from API JSON files

## Quickstart

To get docker image with latest VPP release:

```sh
# Get image with latest VPP release
➢ docker pull ligato/vpp-base

# Print exact VPP version in the image
➢ docker run --rm ligato/vpp-base cat /vpp/version
20.01-release
```

## Images

The vpp-base images are built continuously and published on DockerHub to [ligato/vpp-base][dockerhub].

#### Image Tags

Periodically updated images have fixed tags:
- `ligato/vpp-base:latest` - latest official release
- `ligato/vpp-base:master` - latest development version
- `ligato/vpp-base:YY.MM`  - latest stable versions

All the published images are also tagged using their particular version:
- `ligato/vpp-base:YY.MM-release` - official releases
- `ligato/vpp-base:YY.MM-rc0.N-gabcdefg` - development versions
- `ligato/vpp-base:YY.MM-rcX.N-gabcdefg` - release canditate versions
- `ligato/vpp-base:YY.MM.X-N.gd28bac409` - stable versions

> Note, that the tags do not contain `~` (replaced with `.`) as it is not allowed for docker images. The last part of version number containing builder version is also omitted.

#### Available Versions

Here's list of currently availables images:

| Image Tag | VPP Source | Details |
|---|---|---|
|[![latest](https://img.shields.io/badge/ligato/vpp--base-latest-green.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![release](https://img.shields.io/badge/packagecloud-fdio/release-37327b.svg?logo=debian)](https://packagecloud.io/fdio/release) | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:latest.svg)](https://microbadger.com/images/ligato/vpp-base:latest) |
|[![master](https://img.shields.io/badge/ligato/vpp--base-master-red.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![master](https://img.shields.io/badge/packagecloud-fdio/master-37327b.svg?logo=debian)](https://packagecloud.io/fdio/master) | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:master.svg)](https://microbadger.com/images/ligato/vpp-base:master) |
|[![20.01](https://img.shields.io/badge/ligato/vpp--base-20.01-blue.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![2001](https://img.shields.io/badge/packagecloud-fdio/2001-37327b.svg?logo=debian)](https://packagecloud.io/fdio/2001) | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:20.01.svg)](https://microbadger.com/images/ligato/vpp-base:20.01) |
|[![19.08](https://img.shields.io/badge/ligato/vpp--base-19.08-blue.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![1908](https://img.shields.io/badge/packagecloud-fdio/1908-37327b.svg?logo=debian)](https://packagecloud.io/fdio/1908) | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:19.08.svg)](https://microbadger.com/images/ligato/vpp-base:19.08) |
|[![19.04](https://img.shields.io/badge/ligato/vpp--base-19.04-blue.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![1904](https://img.shields.io/badge/packagecloud-fdio/1904-37327b.svg?logo=debian)](https://packagecloud.io/fdio/1904) | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:19.04.svg)](https://microbadger.com/images/ligato/vpp-base:19.04) |

The complete list of available image tags can be found on [DockerHub][dockerhub-tags].

#### Image Contents

The vpp-base image contains the following pieces:

- **Installed VPP** ready for use with default config - `/etc/vpp/startup.conf`
- **Download script** for getting VPP packages - `/get-vpp.sh`
- **Debian packages** that come with VPP - `/vpp/*.deb`
- **Version file** that contains VPP version - `/vpp/version`

```sh
# List files in /vpp/ directory
➤ docker run --rm ligato/vpp-base:latest ls -Sgh
total 11M
-rw-r--r-- 1 root 3.4M Jan 29 23:02 vpp_20.01-release_amd64.deb
-rw-r--r-- 1 root 3.1M Jan 29 23:02 vpp-plugin-dpdk_20.01-release_amd64.deb
-rw-r--r-- 1 root 3.0M Jan 29 23:02 vpp-plugin-core_20.01-release_amd64.deb
-rw-r--r-- 1 root 941K Jan 29 23:02 vpp-dev_20.01-release_amd64.deb
-rw-r--r-- 1 root 166K Jan 29 23:02 libvppinfra_20.01-release_amd64.deb
-rw-r--r-- 1 root 132K Jan 29 23:02 libvppinfra-dev_20.01-release_amd64.deb
-rw-r--r-- 1 root  24K Jan 29 23:02 python3-vpp-api_20.01-release_amd64.deb
-rw-r--r-- 1 root  24K Jan 29 23:02 vpp-api-python_20.01-release_amd64.deb
-rw-r--r-- 1 root   14 Feb  7 10:14 version

# Print installed VPP packages
➤ docker run --rm -i ligato/vpp-base dpkg-query -W '*vpp*'
libvppinfra	20.01-release
libvppinfra-dev	20.01-release
python3-vpp-api	20.01-release
vpp	20.01-release
vpp-api-python	20.01-release
vpp-dbg	20.01-release
vpp-dev	20.01-release
vpp-plugin-core	20.01-release
vpp-plugin-dpdk	20.01-release
```

## Building Images

### With specific VPP version from packagecloud

To build vpp-base image you can simply use docker build command with without cloning this git repository:

```sh
# latest VPP release
➢ docker build github.com/ligato/vpp-base

# stable VPP 20.01
➢ docker build --build-arg REPO='2001' github.com/ligato/vpp-base

# with specific VPP version
➢ docker build --build-arg REPO='master' --build-arg VPP_VERSION='19.08-rc0~196-g7fe470a54' github.com/ligato/vpp-base

# with specific VPP commit
➢ docker build --build-arg REPO='master' --build-arg VPP_VERSION='19.08[^ ]*-g7fe470a54' github.com/ligato/vpp-base
```

### With custom VPP from local build

To build vpp-base with custom VPP which installs from local debian packages you can use the [custom](custom/Dockerfile) which adds .deb packages from custom directory and installs them.

NOTE: The VPP repository can be cloned into `vpp` directory at the root of this repo (will be ignored by git).

```sh
# build VPP
(
  cd vpp
  make install-dep install-ext-deps
  make pkg-deb
)

# copy debian packages from build-root
cp ./vpp/build-root/*.deb ./custom/

# build custom vpp-base image
docker build --tag vpp-base:custom ./custom
```

[dockerhub]: https://hub.docker.com/r/ligato/vpp-base
[dockerhub-tags]: https://hub.docker.com/r/ligato/vpp-base/tags
[dockercloud-builds]: https://hub.docker.com/r/ligato/vpp-base/builds
[packagecloud-fdio]: https://packagecloud.io/fdio
