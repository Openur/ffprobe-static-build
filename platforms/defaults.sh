#!/usr/bin/env bash

export MAKEFLAGS=-j6

export FFMPEG_CONFIGURE_ARGS=(
  --extra-version=Openur

  --prefix=/opt/ffmpeg

  --enable-version3

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
  --enable-protocol=bluray
  --enable-demuxers
  --enable-parsers
  --enable-decoders
  --enable-bsf=av1_frame_split
  --enable-bsf=av1_frame_merge
  --enable-bsf=av1_metadata

  --enable-static
  --disable-shared

  # AV1
  --enable-libdav1d

  --enable-libbluray
)

export DAV1D_MESON_ARGS=(
  --buildtype release
  --default-library=static
  -Denable_tools=false
  -Denable_examples=false
  -Denable_tests=false
  -Denable_docs=false
  -Dxxhash_muxer=disabled
)

export LIBBLURAY_MESON_ARGS=(
  --buildtype release
  --default-library=static
  -Db_lto=true
  -Denable_tools=false
  -Dbdj_jar=disabled
  -Djava9=false
  -Dembed_udfread=false
  -Dfontconfig=disabled
  -Dfreetype=disabled
  -Dlibxml2=disabled
)

# renovate: datasource=gitlab-releases depName=videolan/dav1d versioning=semver registryUrl=https://code.videolan.org
export DAV1D_VERSION=1.5.3

# renovate: datasource=gitlab-releases depName=videolan/libbluray versioning=semver registryUrl=https://code.videolan.org
export LIBBLURAY_VERSION=1.4.0
