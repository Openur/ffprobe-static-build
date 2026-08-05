#!/usr/bin/env bash

set -ex

build_dav1d() {
  case "$ARCHITECTURE" in
    arm)
      DAV1D_MESON_ARGS+=(
        --cross-file="$SCRIPT_DIRECTORY/arm-linux-gnueabihf.meson"
        --prefix=/usr/arm-linux-gnueabihf
        --libdir=/usr/arm-linux-gnueabihf/lib
      )
      ;;
    arm64)
      DAV1D_MESON_ARGS+=(
        --cross-file=./package/crossfiles/aarch64-linux.meson
        --prefix=/usr/aarch64-linux-gnu
        --libdir=/usr/aarch64-linux-gnu/lib
      )
      ;;
    x64) ;;
    *)
      echo "Unsupported architecture $ARCHITECTURE"
      exit 1
      ;;
  esac

  rm -rf "${BUILD_DIRECTORY}"/dav1d
  mkdir -p "${BUILD_DIRECTORY}"/dav1d
  wget -qO- https://download.videolan.org/videolan/dav1d/${DAV1D_VERSION}/dav1d-${DAV1D_VERSION}.tar.xz | tar xJ -C "${BUILD_DIRECTORY}/dav1d" --strip-components=1
  pushd "${BUILD_DIRECTORY}"/dav1d
  meson setup build . "${DAV1D_MESON_ARGS[@]}"
  meson compile -C build --verbose
  meson install -C build
  rm -rf "${BUILD_DIRECTORY}"/dav1d
  popd
}
