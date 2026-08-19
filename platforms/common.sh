#!/usr/bin/env bash

# renovate: datasource=gitlab-releases depName=videolan/dav1d versioning=semver registryUrl=https://code.videolan.org
export DAV1D_VERSION=1.5.4

FFMPEG_CONFIGURE_ARGS=(
  --extra-version=Openur

  --prefix=/opt/ffmpeg

  --enable-version3

  --enable-static
  --disable-shared
  --enable-pic

  --disable-programs
  --disable-everything
  --disable-autodetect
  --disable-iconv
  --disable-network
  --disable-avdevice
  --disable-avfilter
  --disable-swresample
  --disable-swscale
  --disable-doc
  --disable-debug

  --enable-ffprobe
  --enable-protocol=file
  --enable-demuxers
  --enable-parsers
  --enable-decoders
  --enable-bsf=av1_frame_split
  --enable-bsf=av1_frame_merge
  --enable-bsf=av1_metadata

  # AV1
  --enable-libdav1d
)

if [[ -z "${FFMPEG_VERSION:-}" || ! "${FFMPEG_VERSION:-}" =~ ^n5\. ]]; then
  FFMPEG_CONFIGURE_ARGS+=(
    --disable-unstable
  )
fi

DAV1D_MESON_ARGS=(
  --buildtype release
  --default-library=static
  -Denable_tools=false
  -Denable_examples=false
  -Denable_tests=false
  -Denable_docs=false
  -Dxxhash_muxer=disabled
)

export MAKEFLAGS=-j6
