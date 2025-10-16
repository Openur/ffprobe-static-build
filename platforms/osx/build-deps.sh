#!/usr/bin/env bash

set -ex

build_dav1d() {
  case "$ARCHITECTURE" in
    arm64) ;;
    x64)
      DAV1D_MESON_ARGS+=(
        --cross-file="$SCRIPT_DIRECTORY/x86_64-apple-darwin.meson"
        --prefix="$BUILD_DIRECTORY/x86_64-apple-darwin"
        --libdir="$BUILD_DIRECTORY/x86_64-apple-darwin/lib"
      )
      ;;
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

build_libbluray() {
  case "$ARCHITECTURE" in
    arm64) ;;
    x64)
      LIBBLURAY_MESON_ARGS+=(
        --cross-file="$SCRIPT_DIRECTORY/x86_64-apple-darwin.meson"
        --prefix="$BUILD_DIRECTORY/x86_64-apple-darwin"
        --libdir="$BUILD_DIRECTORY/x86_64-apple-darwin/lib"
      )
      ;;
    *)
      echo "Unsupported architecture $ARCHITECTURE"
      exit 1
      ;;
  esac

  rm -rf "${BUILD_DIRECTORY}"/libbluray
  mkdir -p "${BUILD_DIRECTORY}"/libbluray
  wget -qO- https://download.videolan.org/videolan/libbluray/${LIBBLURAY_VERSION}/libbluray-${LIBBLURAY_VERSION}.tar.xz | tar xJ -C "${BUILD_DIRECTORY}/libbluray" --strip-components=1
  pushd "${BUILD_DIRECTORY}"/libbluray
  meson setup build . "${LIBBLURAY_MESON_ARGS[@]}"
  meson compile -C build --verbose
  meson install -C build
  rm -rf "${BUILD_DIRECTORY}"/libbluray
  popd
}
