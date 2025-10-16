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
  --target-os=mingw32
)

case "$ARCHITECTURE" in
  x64)
    FFMPEG_CONFIGURE_ARGS+=(
      --ld="x86_64-w64-mingw32-g++"
      --arch=x86_64
      --enable-cross-compile
      --cross-prefix=x86_64-w64-mingw32-
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

build_libbluray "$ARCHITECTURE"
build_dav1d "$ARCHITECTURE"

cd ../../ffmpeg-src

PKG_CONFIG_PATH=/usr/lib/x86_64-w64-mingw32/lib/pkgconfig:/usr/lib/i686-w64-mingw32/lib/pkgconfig ./configure "${FFMPEG_CONFIGURE_ARGS[@]}"

make
make DESTDIR="$BUILD_DIRECTORY" install

popd
