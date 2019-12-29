<h1 align="center">vpp-base</h1>

<p align="center">
  <a href="https://github.com/ligato/vpp-base/actions?query=workflow%3A%22Build+Images%22"><img src="https://github.com/ligato/vpp-base/workflows/Build%20Images/badge.svg" alt="Workflow"></a>
  <a href="https://microbadger.com/images/ligato/vpp-base"><img src="https://images.microbadger.com/badges/version/ligato/vpp-base.svg" alt="Latest Version"></a>
  <a href="https://hub.docker.com/r/ligato/vpp-base"><img src="https://img.shields.io/docker/pulls/ligato/vpp-base.svg" alt="Docker Pulls"></a>
</p>

<p align="center">The <b>vpp-base</b> builds docker images with VPP.</p>

---

## Introduction

The purpose of vpp-base is to provide docker images with installed VPP.
This is mainly because there are no official docker images provided by the FD.io.

#### Use Cases

* use as a base image in other projects
* quickly test something against specific VPP version
* distribute Debian (_*.deb_) packages for VPP
* generate VPP binary API from VPP API (_*.api.json_) files

## Quickstart

To get docker image with latest VPP release:

```sh
# get image with latest VPP release
➢ docker pull ligato/vpp-base:latest

# print VPP version
➢ docker run --rm ligato/vpp-base cat /vpp/version
19.08.1-release
```

## Images

The vpp-base images are built continuously and published on DockerHub to [ligato/vpp-base][dockerhub].

#### Available Versions

Here's list of currently availables images:

| Image Tag | VPP Source | Details |
|---|---|---|
|[![latest](https://img.shields.io/badge/ligato/vpp--base-latest-green.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![release](https://img.shields.io/badge/packagecloud-fdio/release-37327b.svg?logo=debian)](https://packagecloud.io/fdio/release) | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:latest.svg)](https://microbadger.com/images/ligato/vpp-base:latest) |
|[![master](https://img.shields.io/badge/ligato/vpp--base-master-red.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![master](https://img.shields.io/badge/packagecloud-fdio/master-37327b.svg?logo=debian)](https://packagecloud.io/fdio/master) | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:master.svg)](https://microbadger.com/images/ligato/vpp-base:master) |
|[![19.08](https://img.shields.io/badge/ligato/vpp--base-19.08-blue.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![1908](https://img.shields.io/badge/packagecloud-fdio/1908-37327b.svg?logo=debian)](https://packagecloud.io/fdio/1908) | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:19.08.svg)](https://microbadger.com/images/ligato/vpp-base:19.08) |
|[![19.04](https://img.shields.io/badge/ligato/vpp--base-19.04-blue.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![1904](https://img.shields.io/badge/packagecloud-fdio/1904-37327b.svg?logo=debian)](https://packagecloud.io/fdio/1904) | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:19.04.svg)](https://microbadger.com/images/ligato/vpp-base:19.04) |

The complete list of available image tags can be found on [DockerHub][dockerhub-tags].

Images that contain:
- unstable VPP version (master) is tagged with: `ligato/vpp-base:master`
- stable VPP version are tagged using the particular release number: `ligato/vpp-base:YY.MM`
- specific VPP versions are tagged using the complete version number: `ligato/vpp-base:YY.MM-rcX.N-gabcdefg` (e.g. `ligato/vpp-base:19.08-rc0.324-g2ecf18a55`)

#### Image Contents

The vpp-base image contains the following pieces:

- **Installed VPP** ready for use with default config - `/etc/vpp/startup.conf`
- **Download script** for getting VPP packages - `/get-vpp.sh`
- **Debian packages** that come with VPP - `/vpp/*.deb`
- **Version file** that contains VPP version - `/vpp/version`

```sh
# list files in /vpp/
➤ docker run --rm -i ligato/vpp-base ls -gh
total 93M
-rw-r--r-- 1 root 142K Sep 18 19:52 libvppinfra-dev_19.08.1-release_amd64.deb
-rw-r--r-- 1 root 166K Sep 18 19:52 libvppinfra_19.08.1-release_amd64.deb
-rw-r--r-- 1 root  22K Sep 18 19:52 python3-vpp-api_19.08.1-release_amd64.deb
-rw-r--r-- 1 root   16 Sep 19 00:05 version
-rw-r--r-- 1 root  22K Sep 18 19:52 vpp-api-python_19.08.1-release_amd64.deb
-rw-r--r-- 1 root  84M Sep 18 19:52 vpp-dbg_19.08.1-release_amd64.deb
-rw-r--r-- 1 root 896K Sep 18 19:52 vpp-dev_19.08.1-release_amd64.deb
-rw-r--r-- 1 root 2.7M Sep 18 19:52 vpp-plugin-core_19.08.1-release_amd64.deb
-rw-r--r-- 1 root 2.5M Sep 18 19:52 vpp-plugin-dpdk_19.08.1-release_amd64.deb
-rw-r--r-- 1 root 3.3M Sep 18 19:52 vpp_19.08.1-release_amd64.deb

# print installed VPP packages
➤ docker run --rm -i ligato/vpp-base dpkg-query -W '*vpp*'
libvppinfra	19.08.1-release
libvppinfra-dev	19.08.1-release
python3-vpp-api	19.08.1-release
vpp	19.08.1-release
vpp-api-python	19.08.1-release
vpp-dbg	19.08.1-release
vpp-dev	19.08.1-release
vpp-plugin-core	19.08.1-release
vpp-plugin-dpdk	19.08.1-release
```

## Building Images

### With specific VPP version from packagecloud

To build vpp-base image you can simply use docker build command with without cloning this git repository:

```sh
# latest VPP release
➢ docker build github.com/ligato/vpp-base

# stable VPP 19.04
➢ docker build --build-arg REPO='1904' github.com/ligato/vpp-base

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
