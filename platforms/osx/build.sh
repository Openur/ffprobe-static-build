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
  --cc=clang
  --target-os=darwin
  --enable-runtime-cpudetect
)

case "$ARCHITECTURE" in
  arm64)
    FFMPEG_CONFIGURE_ARGS+=(
      --arch=arm64
      --extra-cflags="-arch arm64 -mmacosx-version-min=13"
      --extra-ldflags="-arch arm64 -mmacosx-version-min=13"
    )
    ;;
  x64)
    FFMPEG_CONFIGURE_ARGS+=(
      --arch=x86_64
      --extra-cflags="-arch x86_64 -mmacosx-version-min=10.13"
      --extra-ldflags="-arch x86_64 -mmacosx-version-min=10.13"
      --enable-cross-compile
      --disable-x86asm
    )
    ;;
  *)
    echo "Unsupported architecture $ARCHITECTURE"
    exit 1
    ;;
esac

build_dav1d "$ARCHITECTURE"

cd ../../ffmpeg-src

PKG_CONFIG_PATH="$BUILD_DIRECTORY/x86_64-apple-darwin/lib/pkgconfig:/usr/local/lib/pkgconfig" \
  ./configure "${FFMPEG_CONFIGURE_ARGS[@]}"

make V=1
make DESTDIR="$BUILD_DIRECTORY" install

popd
