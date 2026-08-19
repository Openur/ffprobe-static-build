#!/usr/bin/env bash

set -ex

ARCHITECTURE=$1

cd "$(dirname "$0")"

SCRIPT_DIRECTORY=$PWD
BUILD_DIRECTORY="$SCRIPT_DIRECTORY/build"

pushd "$SCRIPT_DIRECTORY"

source ../common.sh
source ./build-deps.sh

: ${FFMPEG_VERSION?}

FFMPEG_CONFIGURE_ARGS+=(
  --pkg-config-flags="--static"
  --extra-cflags="--static"
  --extra-ldexeflags="-static"
  --extra-libs="-lpthread -lm -static -L/usr/lib"
  --cc=/usr/bin/clang
  --cxx=/usr/bin/clang-cpp
  --target-os=freebsd
)

case "$ARCHITECTURE" in
  arm64)
    FFMPEG_CONFIGURE_ARGS+=(
      --arch=aarch64
    )
    ;;
  x64)
    FFMPEG_CONFIGURE_ARGS+=(
      --arch=x86_64
    )
    ;;
  *)
    echo "Unsupported architecture $ARCHITECTURE"
    exit 1
    ;;
esac

build_dav1d

cd ../../ffmpeg-src

./configure "${FFMPEG_CONFIGURE_ARGS[@]}"

gmake V=1
gmake DESTDIR="$BUILD_DIRECTORY" install

popd
