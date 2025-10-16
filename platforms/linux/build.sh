#!/usr/bin/env bash

set -ex

ARCHITECTURE=$1

cd "$(dirname "$0")"

SCRIPT_DIRECTORY=$PWD
BUILD_DIRECTORY="$SCRIPT_DIRECTORY/build"

pushd "$SCRIPT_DIRECTORY"

source ../defaults.sh
source ./build-deps.sh

FFMPEG_CONFIGURE_ARGS+=(
  --pkg-config=pkg-config
  --pkg-config-flags="--static"
  --extra-ldexeflags="-static"
  --extra-libs="-lpthread -lm"
  --target-os=linux
)

case "$ARCHITECTURE" in
  arm)
    FFMPEG_CONFIGURE_ARGS+=(
      --ld="arm-linux-gnueabihf-g++-12"
      --arch=armhf
      --enable-cross-compile
      --cross-prefix=arm-linux-gnueabihf-
    )
    ;;
  arm64)
    FFMPEG_CONFIGURE_ARGS+=(
      --ld="aarch64-linux-gnu-g++-12"
      --arch=aarch64
      --enable-cross-compile
      --cross-prefix=aarch64-linux-gnu-
    )
    ;;
  x64)
    FFMPEG_CONFIGURE_ARGS+=(
      --ld="g++-12"
      --arch=x86_64
    )
    ;;
  *)
    echo "Unsupported architecture $ARCHITECTURE"
    exit 1
    ;;
esac

build_libbluray "$ARCHITECTURE"
build_dav1d "$ARCHITECTURE"

cd ../../ffmpeg-src

PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/lib/pkgconfig:/usr/lib/aarch64-linux-gnu/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig \
  ./configure "${FFMPEG_CONFIGURE_ARGS[@]}"

make
make DESTDIR="$BUILD_DIRECTORY" install

popd
