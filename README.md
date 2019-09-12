<h1 align="center">vpp-base</h1>

<p align="center">
  <a href="https://hub.docker.com/r/ligato/vpp-base/builds"><img src="https://img.shields.io/docker/cloud/build/ligato/vpp-base.svg" alt="Docker Cloud Build Status"></a>
  <a href="https://hub.docker.com/r/ligato/vpp-base"><img src="https://img.shields.io/docker/pulls/ligato/vpp-base.svg" alt="Docker Pulls"></a>
</p>

<p align="center">The <b>vpp-base</b> provides tools for building docker images with VPP.</p>

---

## Introduction

The goal of vpp-base is to provide images with VPP that can be used as base image in projects working with VPP. This is mainly because there are no official images provided by the FD.io/VPP.

#### Use Cases

* use as base image in docker images that work with VPP
* quickly test some feature in specific VPP version
* distribute _.deb_ packages for VPP where needed
* generate VPP binary API using installed _.api.json_ files

## Quickstart

To get vpp-base image with latest VPP release, run:

```sh
# pull image with latest VPP release
➢ docker pull ligato/vpp-base

# print the VPP version
➢ docker run --rm ligato/vpp-base cat /vpp/version
19.04.1-release
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
- **All _.deb_ packages** that come with VPP - `/vpp/*.deb`
- **Version file** that contains VPP version - `/vpp/version`

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
