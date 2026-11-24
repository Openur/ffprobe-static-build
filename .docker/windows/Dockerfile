# syntax=docker/dockerfile:1

FROM mirror.gcr.io/debian:13.8@sha256:3cda3ca472ce45507a5109c6a3907093e24d9ae67d55954c9a07a45665dafba2

RUN export DEBIAN_FRONTEND="noninteractive"; \
    set -eux; \
    apt-get update; \
    apt-get upgrade --yes; \
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
      nasm; \
    rm -rf /var/lib/apt/lists/*;
