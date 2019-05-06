# vpp-base

The vpp-base provides docker images used as base for running or building VPP.

## Quickstart

Run `make` to build image from latest master.

## Usage

To build VPP image using specific package, run:

```sh
# for master
$ make build
$ make build REPO=master

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
