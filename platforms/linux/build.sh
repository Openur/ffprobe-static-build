#!/usr/bin/env bash

set -ex

readonly ARCHITECTURE=$1
readonly LINUX_COMPILER_SUFFIX=${LINUX_COMPILER_SUFFIX:--14}

cd "$(dirname "$0")"

SCRIPT_DIRECTORY=$PWD
BUILD_DIRECTORY="$SCRIPT_DIRECTORY/build"

pushd "$SCRIPT_DIRECTORY"

source ../common.sh
source ./build-deps.sh

: ${FFMPEG_VERSION?}

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
      --ld="arm-linux-gnueabihf-g++${LINUX_COMPILER_SUFFIX}"
      --arch=armhf
      --enable-cross-compile
      --cross-prefix=arm-linux-gnueabihf-
    )
    ;;
  arm64)
    FFMPEG_CONFIGURE_ARGS+=(
      --ld="aarch64-linux-gnu-g++${LINUX_COMPILER_SUFFIX}"
      --arch=aarch64
      --enable-cross-compile
      --cross-prefix=aarch64-linux-gnu-
    )
    ;;
  x64)
    FFMPEG_CONFIGURE_ARGS+=(
      --ld="g++${LINUX_COMPILER_SUFFIX}"
      --arch=x86_64
    )
    ;;
  *)
    echo "Unsupported architecture $ARCHITECTURE"
    exit 1
    ;;
esac

build_dav1d "$ARCHITECTURE"

cd ../../ffmpeg-src

PKG_CONFIG_PATH=/usr/arm-linux-gnueabihf/lib/pkgconfig:/usr/aarch64-linux-gnu/lib/pkgconfig:/usr/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig \
  ./configure "${FFMPEG_CONFIGURE_ARGS[@]}"

make -j$(nproc) V=1
make DESTDIR="$BUILD_DIRECTORY" install

popd
