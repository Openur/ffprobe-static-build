# syntax=docker/dockerfile:1

FROM mirror.gcr.io/debian:13@sha256:fac46bff2e02f51425b6e33b0e1169f55dfb053d83511ca28aa50c09fd5ed7a4

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
