# vpp-base

The vpp-base provides docker images used as base for running or building VPP.

## Quickstart

Run `make` to build image from latest master.

## Usage

To build VPP using latest package from master branch, run:

```sh
# master
$ make build
```

To build VPP using package from specific release, run:

```sh
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
