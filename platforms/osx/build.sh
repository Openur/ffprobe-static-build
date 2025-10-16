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
  --pkg-config-flags="--static"
  --cc=clang
  --target-os=darwin
)

case "$ARCHITECTURE" in
  arm64)
    export MACOSX_DEPLOYMENT_TARGET=13.0

    FFMPEG_CONFIGURE_ARGS+=(
      --arch=arm64
      --extra-cflags="-arch arm64"
      --extra-ldflags="-arch arm64"
    )
    ;;
  x64)
    export MACOSX_DEPLOYMENT_TARGET=10.13

    FFMPEG_CONFIGURE_ARGS+=(
      --arch=x86_64
      --extra-cflags="-arch x86_64"
      --extra-ldflags="-arch x86_64"
      --enable-cross-compile
      --disable-x86asm
    )

    ;;
  *)
    echo "Unsupported architecture $ARCHITECTURE"
    exit 1
    ;;
esac

brew install meson nasm

build_libbluray "$ARCHITECTURE"
build_dav1d "$ARCHITECTURE"

cd ../../ffmpeg-src

PKG_CONFIG_PATH="$BUILD_DIRECTORY/x86_64-apple-darwin/lib/pkgconfig:/opt/homebrew/lib/pkgconfig" \
  ./configure "${FFMPEG_CONFIGURE_ARGS[@]}"

make
make DESTDIR="$BUILD_DIRECTORY" install

popd
