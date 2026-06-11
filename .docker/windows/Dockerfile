# syntax=docker/dockerfile:1

FROM mirror.gcr.io/debian:13@sha256:2b9468c8670c5f8365b115776c3390872551d5a5c601b5429232265890f740c7

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-suggests --no-install-recommends \
      ca-certificates \
      wget \
      build-essential \
      cmake \
      pkg-config \
      # cross-building \
      gcc-mingw-w64 \
      g++-mingw-w64 \
      # libdav1d \
      meson \
      ninja-build \
      nasm
