# syntax=docker/dockerfile:1

FROM mirror.gcr.io/debian:13@sha256:34cd9e9fd437c0a095ec39cb2e73422c9f30821b0d0848ed74fd0d43bae4d958

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
