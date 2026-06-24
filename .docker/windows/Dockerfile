# syntax=docker/dockerfile:1

FROM mirror.gcr.io/debian:13@sha256:1de1fcf32a035452eb3a2c99926a9988509f177b3c99efab609700297d2076bf

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
