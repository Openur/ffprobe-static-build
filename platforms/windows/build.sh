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
  --pkg-config=pkg-config
  --pkg-config-flags="--static"
  --extra-ldexeflags="-static"
  --extra-libs="-lpthread -lm"
  --target-os=mingw32
)

case "$ARCHITECTURE" in
  arm64)
    export CMAKE_POLICY_VERSION_MINIMUM="3.5"

    FFMPEG_CONFIGURE_ARGS+=(
      --cc=clang
      --cxx=clang++
      --arch=arm64
    )
    ;;
  x64)
    export CMAKE_POLICY_VERSION_MINIMUM="3.5"

    FFMPEG_CONFIGURE_ARGS+=(
      --cc=clang
      --cxx=clang++
      --arch=x86_64
    )
    ;;
  x86)
    FFMPEG_CONFIGURE_ARGS+=(
      --ld="i686-w64-mingw32-g++-win32"
      --arch=x86
      --enable-cross-compile
      --cross-prefix=i686-w64-mingw32-
    )
    ;;
  *)
    echo "Unsupported architecture $ARCHITECTURE"
    exit 1
    ;;
esac

build_dav1d "$ARCHITECTURE"

cd ../../ffmpeg-src

PKG_CONFIG_PATH=/usr/x86_64-w64-mingw32/lib/pkgconfig:/usr/i686-w64-mingw32/lib/pkgconfig:${MINGW_PREFIX:-/clang64}/lib64/pkgconfig ./configure "${FFMPEG_CONFIGURE_ARGS[@]}"

make -j$(nproc) V=1
make DESTDIR="$BUILD_DIRECTORY" install

popd
