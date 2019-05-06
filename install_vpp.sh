#!/bin/bash

set -exuo pipefail

VPP_REPO=${VPP_REPO:-master}
REPO_URL=https://packagecloud.io/install/repositories/fdio/${VPP_REPO}

# the code below comes from FDio's CSIT project.
function download_ubuntu_artifacts () {
   	# Get and/or install Ubuntu VPP artifacts from packagecloud.io.
    #
    # Variables read:
    # - REPO_URL - FD.io Packagecloud repository.
    # - VPP_VERSION - VPP version.
    # - INSTALL - If install packages or download only. Default: download

	set -exuo pipefail

	curl -s "${REPO_URL}"/script.deb.sh | sudo -E bash || {
		die "Packagecloud FD.io repo fetch failed."
	}

	# If version is set we will add suffix.
	artifacts=()
	both_quotes='"'"'"
	match="[^${both_quotes}]*"
	qmatch="[${both_quotes}]\?"
	sed_command="s#.*apt_source_path=${qmatch}\(${match}\)${qmatch}#\1#p"
	apt_fdio_repo_file=$(curl -s "${REPO_URL}"/script.deb.sh | \
						 sed -n ${sed_command}) || {
							 die "Local fdio repo file path fetch failed."
						 }

	if [ ! -f ${apt_fdio_repo_file} ]; then
		die "${apt_fdio_repo_file} not found, \
			repository installation was not successful."
	fi

	packages=$(apt-cache -o Dir::Etc::SourceList=${apt_fdio_repo_file} \
			   -o Dir::Etc::SourceParts=${apt_fdio_repo_file} dumpavail \
			   | grep Package: | cut -d " " -f 2) || {
				   die "Retrieval of available VPP packages failed."
			   }
	if [ -z "${VPP_VERSION-}" ]; then
		# If version is not specified, find out the most recent version
		VPP_VERSION=$(apt-cache -o Dir::Etc::SourceList=${apt_fdio_repo_file} \
					  -o Dir::Etc::SourceParts=${apt_fdio_repo_file} \
					  --no-all-versions show vpp | grep Version: | \
					  cut -d " " -f 2) || {
						  die "Retrieval of most recent VPP version failed."
					  }
	fi

	set +x
	for package in ${packages}; do
		# Filter packages with given version
		pkg_info=$(apt-cache show ${package}) || {
			die "apt-cache show on ${package} failed."
		}
		ver=$(echo ${pkg_info} | grep -o "Version: ${VPP_VERSION-}[^ ]*" | \
			  head -1) || true
		if [ -n "${ver-}" ]; then
			echo "Found '${VPP_VERSION-}' among '${package}' versions."
			ver=$(echo "$ver" | cut -d " " -f 2)
			artifacts+=(${package[@]/%/=${ver-}})
		else
			echo "Didn't find '${VPP_VERSION-}' among '${package}' versions."
		fi
	done
	set -x

	if [ "${INSTALL:-true}" = true ]; then
		sudo -E apt-get -y install "${artifacts[@]}" || {
			die "Install VPP artifacts failed."
		}
	else
		apt-get -y download "${artifacts[@]}" || {
			die "Download VPP artifacts failed."
		}
	fi
}

function die () {
    # Print the message to standard error end exit with error code specified
    # by the second argument.
    #
    # Hardcoded values:
    # - The default error message.
    # Arguments:
    # - ${1} - The whole error message, be sure to quote. Optional
    # - ${2} - the code to exit with, default: 1.

    set -x
    set +eu
    echo "${1:-Unspecified run-time error occurred!}"
    exit "${2:-1}"
}

download_ubuntu_artifacts
