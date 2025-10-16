#!/usr/bin/env bash

set -ex

build_dav1d() {
  rm -rf "${BUILD_DIRECTORY}"/dav1d
  mkdir -p "${BUILD_DIRECTORY}"/dav1d
  fetch -qo- https://download.videolan.org/videolan/dav1d/${DAV1D_VERSION}/dav1d-${DAV1D_VERSION}.tar.xz | tar xJ -C "${BUILD_DIRECTORY}/dav1d" --strip-components=1
  pushd "${BUILD_DIRECTORY}"/dav1d
  meson setup build . "${DAV1D_MESON_ARGS[@]}"
  meson compile -C build --verbose
  meson install -C build
  rm -rf "${BUILD_DIRECTORY}"/dav1d
  popd
}

build_libbluray() {
  rm -rf "${BUILD_DIRECTORY}"/libbluray
  mkdir -p "${BUILD_DIRECTORY}"/libbluray
  fetch -qo- https://download.videolan.org/videolan/libbluray/${LIBBLURAY_VERSION}/libbluray-${LIBBLURAY_VERSION}.tar.xz | tar xJ -C "${BUILD_DIRECTORY}/libbluray" --strip-components=1
  pushd "${BUILD_DIRECTORY}"/libbluray
  meson setup build . "${LIBBLURAY_MESON_ARGS[@]}"
  meson compile -C build --verbose
  meson install -C build
  rm -rf "${BUILD_DIRECTORY}"/libbluray
  popd
}
