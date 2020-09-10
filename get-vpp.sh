#!/bin/bash

[ -z "$REPO_URL" ] && REPO_URL="https://packagecloud.io/install/repositories/fdio/${REPO:=release}"

# the code below comes from FDio's CSIT project.
function get_vpp () {
   	# Get and/or install Ubuntu VPP artifacts from packagecloud.io.
    #
    # Variables read:
    # - REPO_URL - FD.io Packagecloud repository.
    # - VPP_VERSION - VPP version.
    # - INSTALL - If install packages or download only. Default: download

	ls "*.deb" 2>/dev/null && { die "remove existing *.deb files"; }

	set -exuo pipefail
	trap '' PIPE

	curl -sS "${REPO_URL}"/script.deb.sh | bash || {
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
		allVersions=$(apt-cache -o Dir::Etc::SourceList=${apt_fdio_repo_file} \
					  -o Dir::Etc::SourceParts=${apt_fdio_repo_file} \
					  show vpp | grep Version: | cut -d " " -f 2) || {
						  die "Retrieval of available VPP versions failed."
					  }
		if [ "${REPO}" != "master" ]; then
			nonRcVersions=$(echo "$allVersions" | grep -v "\-rc[0-9]") || true
			[ -n "${nonRcVersions}" ] && allVersions=$nonRcVersions
		fi
		VPP_VERSION=$(echo "$allVersions" | head -n1) || true
	fi

	set +x
	echo "Finding packages with version: ${VPP_VERSION-}"
	for package in ${packages}; do
		# Filter packages with given version
		pkg_info=$(apt-cache show -- ${package}) || {
			die "apt-cache show on ${package} failed."
		}
		ver=$(echo ${pkg_info} | grep -o "Version: ${VPP_VERSION-}[^ ]*" | head -1) || true
		if [ -n "${ver-}" ]; then
			if [ "${package}" == "vom" ]; then
				echo " x '${package}' skipped"
			else
				echo "+++'${package}' found"
				ver=$(echo "$ver" | cut -d " " -f 2)
				artifacts+=(${package[@]/%/=${ver-}})
			fi
		else
			echo " - '${package}'"
		fi
	done
	set -x

	if [ "${INSTALL:-false}" = true ]; then
		apt-get -y install "${artifacts[@]}" || {
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

get_vpp
