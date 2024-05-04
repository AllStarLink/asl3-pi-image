#!/bin/bash


## System Checks
function check_deps(){
	if [ ! -x "$1" ]; then
		echo "ERROR: Missing dependency ${1}" 1>&2
		exit 1 
	fi
}

check_deps /usr/bin/git
check_deps /usr/bin/gh
check_deps /usr/bin/qemu-arm-static

## Options
function usage() { echo "Usage: $0 -v VERSION" 1>&2; exit 1; }

while getopts "v:" opt; do
	case $opt in
		v) VER="$OPTARG" ;;
		*) usage ;;
	esac
done
shift $((OPTIND-1))

if [ "x${VER}" == "x" ]; then
	usage
fi

## Error out immediately on any problem
set -e

## Clone the CustomPiOS Builder
git clone --depth 1 https://github.com/guysoft/CustomPiOS

## Generate the image build system
pushd CustomPiOS

if [ -d asl3 ]; then
	echo "ERROR: Image structure asl3 already exists" 1>&2
	exit 1
fi
 
./src/make_custom_pi_os -v raspios_lite_arm64 -g ./asl3
cp -r ../modules/* asl3/src/modules/
perl -pe "s/\@\@VER\@\@/${VER}/g" ../config > asl3/src/config
pushd asl3/src

popd; popd;

