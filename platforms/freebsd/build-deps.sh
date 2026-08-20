#!/usr/bin/env bash

set -ex

build_dav1d() {
  : ${DAV1D_VERSION?}

  rm -rf "${BUILD_DIRECTORY}"/dav1d
  mkdir -p "${BUILD_DIRECTORY}"/dav1d
  fetch -qo- https://download.videolan.org/videolan/dav1d/${DAV1D_VERSION}/dav1d-${DAV1D_VERSION}.tar.xz | tar xJ -C "${BUILD_DIRECTORY}/dav1d" --strip-components=1
  pushd "${BUILD_DIRECTORY}"/dav1d
  meson setup build . "${DAV1D_MESON_ARGS[@]}"
  meson compile -C build -j$(nproc)
  meson install -C build
  rm -rf "${BUILD_DIRECTORY}"/dav1d
  popd
}
