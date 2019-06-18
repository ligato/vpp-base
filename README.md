<h1 align="center">vpp-base</h1>

<p align="center">
  <a href="https://hub.docker.com/r/ligato/vpp-base/builds"><img src="https://img.shields.io/docker/cloud/build/ligato/vpp-base.svg" alt="Docker Cloud Build Status"></a>
  <a href="https://hub.docker.com/r/ligato/vpp-base"><img src="https://img.shields.io/docker/pulls/ligato/vpp-base.svg" alt="Docker Pulls"></a>
</p>

<p align="center">The <b>vpp-base</b> provides code used for building docker images with VPP.</p>
<p align="center">🚧 <b>This repository is currently in experimental stage!</b></p>

---

## Introduction

The goal of vpp-base is to provide images with VPP that can be used as base image in projects working with VPP. This is mainly because there are no official images provided by the FD.io/VPP.

### Use Cases

* Use as base image in docker images that work with VPP.
* Quickly test some feature in specific VPP version.
* Distribute _.deb_ packages for VPP where needed.
* Generate VPP binary API using installed _.api.json_ files.

The vpp-base is already being used by the [vpp-agent](https://github.com/ligato/vpp-agent) project.

### Quickstart

To get vpp-base image which contains latest VPP release version from the [release repository][packagecloud-fdio] on packagecloud.io, run:

```sh
# get image with latest VPP release
➢ docker pull ligato/vpp-base

# print the VPP version
➢ docker run --rm ligato/vpp-base cat /vpp/version
19.04.1-release
```

## Images

The vpp-base images are [built continuously][dockercloud-builds] and published on DockerHub to [ligato/vpp-base][dockerhub].

### Available Versions

In addition to the latest image tag built from release repo, there are other versions available. 

Images that contain:
- unstable VPP version (master) is tagged with: `ligato/vpp-base:master`
- stable VPP version are tagged using the particular release number: `ligato/vpp-base:YY.MM`
- specific VPP versions are tagged using the complete version number: `ligato/vpp-base:YY.MM-rcX.N-gabcdefg` (e.g. `ligato/vpp-base:19.08-rc0.324-g2ecf18a55`)

Here's list of currently published images available:

| Image | Details | VPP source |
|---|---|---|
|[![master](https://img.shields.io/badge/ligato/vpp--base-master-red.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:master.svg)](https://microbadger.com/images/ligato/vpp-base:master) | [![master](https://img.shields.io/badge/packagecloud_repo-master-37327b.svg?logo=debian)](https://packagecloud.io/fdio/master) |
|[![latest](https://img.shields.io/badge/ligato/vpp--base-latest-lime.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:latest.svg)](https://microbadger.com/images/ligato/vpp-base:latest) | [![release](https://img.shields.io/badge/packagecloud_repo-release-37327b.svg?logo=debian)](https://packagecloud.io/fdio/release) |
|[![19.04](https://img.shields.io/badge/ligato/vpp--base-19.04-blue.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:19.04.svg)](https://microbadger.com/images/ligato/vpp-base:19.04) | [![1904](https://img.shields.io/badge/packagecloud_repo-1904-37327b.svg?logo=debian)](https://packagecloud.io/fdio/1904) |
|[![19.01](https://img.shields.io/badge/ligato/vpp--base-19.01-blue.svg?logo=docker&logoColor=white&style=popout)][dockerhub] | [![](https://images.microbadger.com/badges/image/ligato/vpp-base:19.01.svg)](https://microbadger.com/images/ligato/vpp-base:19.01) | [![1901](https://img.shields.io/badge/packagecloud_repo-1901-37327b.svg?logo=debian)](https://packagecloud.io/fdio/1901) |

The complete list of available image tags can be found on [DockerHub][dockerhub-tags].

### Image Contents

The vpp-base image contains the following pieces:

- **Installed VPP** ready for use with default config - `/etc/vpp/startup.conf`
- **Download script** for getting VPP packages - `/get-vpp.sh`
- **All _.deb_ packages** that come with VPP - `/vpp/*.deb`
- **Version file** that contains VPP version - `/vpp/version`

## Building Images

To build custom vpp-base image you can simply use docker build command with without cloning this git repository:

```sh
# Latest VPP release
➢ docker build github.com/ligato/vpp-base

# Stable VPP 19.04
➢ docker build --build-arg REPO='1904' github.com/ligato/vpp-base

# With specific VPP version
➢ docker build --build-arg REPO='master' --build-arg VPP_VERSION='19.08-rc0~196-g7fe470a54' github.com/ligato/vpp-base

# With specific VPP commit
➢ docker build --build-arg REPO='master' --build-arg VPP_VERSION='19.08[^ ]*-g7fe470a54' github.com/ligato/vpp-base
```

[dockerhub]: https://hub.docker.com/r/ligato/vpp-base
[dockerhub-tags]: https://hub.docker.com/r/ligato/vpp-base/tags
[dockercloud-builds]: https://hub.docker.com/r/ligato/vpp-base/builds
[packagecloud-fdio]: https://packagecloud.io/fdio
