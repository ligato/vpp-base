<h1 align="center">vpp-base</h1>

<p align="center">
  <a href="https://github.com/ligato/vpp-base/actions?query=workflow%3A%22Build+Images%22"><img src="https://github.com/ligato/vpp-base/workflows/Build%20Images/badge.svg" alt="Workflow"></a>
  <img src="https://img.shields.io/docker/v/ligato/vpp-base/latest.svg" alt="Latest Version">
  <a href="https://hub.docker.com/r/ligato/vpp-base"><img src="https://img.shields.io/docker/pulls/ligato/vpp-base.svg" alt="Docker Pulls"></a>
</p>

<p align="center">The <b>vpp-base</b> builds docker images for VPP.</p>

---

Table of contents:
- [Available Versions](#available-versions)
- [Intro](#intro)
- [Quickstart](#quickstart)
  - [Use latest release of VPP](#use-latest-release-of-vpp)
  - [Use development version of VPP](#use-development-version-of-vpp)
- [Build Image](#build-image)
  - [Build with official VPP version](#build-with-official-vpp-version)
  - [Build with custom VPP version](#build-with-custom-vpp-version)
- [Images](#images)
  - [Image Contents](#image-contents)
  - [Tag Format](#tag-format)

## Available Versions

List of currently availables versions that are being maintained:

| Image Tag | Packagecloud Repo | Version | Details |
|---|---|---|---|
|[![master](https://img.shields.io/badge/ligato/vpp--base-master-salmon.svg?logo=docker&logoColor=white&style=popout)](https://hub.docker.com/r/ligato/vpp-base/tags?name=master) | [![master](https://img.shields.io/badge/fdio-master-salmon.svg?logo=debian)](https://packagecloud.io/fdio/master) | [![version](https://img.shields.io/docker/v/ligato/vpp-base/master.svg?color=salmon)](https://img.shields.io/docker/v/ligato/vpp-base/master.svg) | ![size](https://img.shields.io/docker/image-size/ligato/vpp-base/master) |
|[![latest](https://img.shields.io/badge/ligato/vpp--base-latest-brightgreen.svg?logo=docker&logoColor=white&style=popout)](https://hub.docker.com/r/ligato/vpp-base/tags?name=latest) | [![release](https://img.shields.io/badge/fdio-release-brightgreen.svg?logo=debian)](https://packagecloud.io/fdio/release) | [![version](https://img.shields.io/docker/v/ligato/vpp-base/latest.svg?color=brightgreen)](https://img.shields.io/docker/v/ligato/vpp-base/latest.svg) | ![size](https://img.shields.io/docker/image-size/ligato/vpp-base/latest) |
|[![23.10](https://img.shields.io/badge/ligato/vpp--base-23.10-blue.svg?logo=docker&logoColor=white&style=popout)](https://hub.docker.com/r/ligato/vpp-base/tags?name=23.10) | [![2310](https://img.shields.io/badge/fdio-2310-37327b.svg?logo=debian)](https://packagecloud.io/fdio/2310) | [![version](https://img.shields.io/docker/v/ligato/vpp-base/23.10.svg)](https://img.shields.io/docker/v/ligato/vpp-base/23.10.svg) | ![size](https://img.shields.io/docker/image-size/ligato/vpp-base/23.10) |
|[![23.06](https://img.shields.io/badge/ligato/vpp--base-23.06-blue.svg?logo=docker&logoColor=white&style=popout)](https://hub.docker.com/r/ligato/vpp-base/tags?name=23.06) | [![2306](https://img.shields.io/badge/fdio-2306-37327b.svg?logo=debian)](https://packagecloud.io/fdio/2306) | [![version](https://img.shields.io/docker/v/ligato/vpp-base/23.06.svg)](https://img.shields.io/docker/v/ligato/vpp-base/23.06.svg) | ![size](https://img.shields.io/docker/image-size/ligato/vpp-base/23.06) |
|[![23.02](https://img.shields.io/badge/ligato/vpp--base-23.02-blue.svg?logo=docker&logoColor=white&style=popout)](https://hub.docker.com/r/ligato/vpp-base/tags?name=23.02) | [![2302](https://img.shields.io/badge/fdio-2302-37327b.svg?logo=debian)](https://packagecloud.io/fdio/2302) | [![version](https://img.shields.io/docker/v/ligato/vpp-base/23.02.svg)](https://img.shields.io/docker/v/ligato/vpp-base/23.02.svg) | ![size](https://img.shields.io/docker/image-size/ligato/vpp-base/23.02) |
|[![22.10](https://img.shields.io/badge/ligato/vpp--base-22.10-blue.svg?logo=docker&logoColor=white&style=popout)](https://hub.docker.com/r/ligato/vpp-base/tags?name=22.10) | [![2210](https://img.shields.io/badge/fdio-2210-37327b.svg?logo=debian)](https://packagecloud.io/fdio/2210) | [![version](https://img.shields.io/docker/v/ligato/vpp-base/22.10.svg)](https://img.shields.io/docker/v/ligato/vpp-base/22.10.svg) | ![size](https://img.shields.io/docker/image-size/ligato/vpp-base/22.10) |



The complete list of available image tags can be found on [DockerHub][dockerhub-tags].

## Intro

The purpose of vpp-base is to provide tools for building docker images with any version of VPP.

Use cases:
* Use as a base image in your Dockerfiles
* Quickly test something specific VPP version
* Build docker image for custom VPP builds
* Generate VPP binary API bindings
* Distribute Debian packages for VPP

The project was created because there are no official docker images provided by the FD.io community.

## Quickstart

### Use latest release of VPP

```sh
# Pull the image
➢ docker pull ligato/vpp-base

# Print the VPP version
➢ docker run --rm ligato/vpp-base cat /vpp/version
20.05-release
```

### Use development version of VPP

```sh
# Pull the image
➢ docker pull ligato/vpp-base:master

# Print the VPP version
➢ docker run --rm ligato/vpp-base:master cat /vpp/version
20.09-rc0~157-g8eca60df7~b1410
```

## Build Image

### Build with official VPP version

To build vpp-base image you can simply use `docker build` command (no need to clone this repository at all):

```sh
# Build with latest VPP release
➢ docker build github.com/ligato/vpp-base

# Build with stable VPP 20.05
➢ docker build --build-arg REPO='2005' github.com/ligato/vpp-base

# Build with exact VPP version
➢ docker build --build-arg REPO='master' --build-arg VPP_VERSION='20.09-rc0~174-gbfeae8c57' github.com/ligato/vpp-base

# Build with specific VPP commit
➢ docker build --build-arg REPO='master' --build-arg VPP_VERSION='20.09-rc0~[^ ]*-g<commit>' github.com/ligato/vpp-base
```

### Build with custom VPP version

To build vpp-base with custom VPP you can use the [custom](custom/Dockerfile) which installs from local debian packages by adding .deb packages from custom directory and installing them.

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

NOTE: You can put VPP repo into `vpp` directory at the root of this repo and it will be ignored by git.

## Images

The vpp-base images are built continuously by GitHub [workflow](.github/workflows/build-images.yml) and published to DockerHub repository [ligato/vpp-base][dockerhub].

### Image Contents

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

### Tag Format

Tags are derived from particular VPP version installed in the image. However they are some differences between image tag and particular VPP version:
- character `~` is replaced  with _dot_ `.` (not allowed in docker image tags)
- build number suffix (`~bXXXX`) is omitted in tags

Periodically updated images have fixed tags:
- `ligato/vpp-base:latest` - latest official release
- `ligato/vpp-base:master` - latest development version
- `ligato/vpp-base:YY.MM`  - latest stable versions

All the published images are also tagged using their particular version:
- `ligato/vpp-base:YY.MM-release` - official releases
- `ligato/vpp-base:YY.MM-rc0.N-gabcdefg` - development versions
- `ligato/vpp-base:YY.MM-rcX.N-gabcdefg` - release canditate versions
- `ligato/vpp-base:YY.MM.X-N.gd28bac409` - stable versions


<!-- LINKS -->
[dockerhub]: https://hub.docker.com/r/ligato/vpp-base
[dockerhub-tags]: https://hub.docker.com/r/ligato/vpp-base/tags
[dockercloud-builds]: https://hub.docker.com/r/ligato/vpp-base/builds
[packagecloud-fdio]: https://packagecloud.io/fdio
