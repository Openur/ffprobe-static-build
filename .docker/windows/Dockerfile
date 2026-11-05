# syntax=docker/dockerfile:1

FROM mirror.gcr.io/debian:13.7@sha256:9c6e381421d0f48d1b8133e573f33c185ee16cbf505eda9c4a8a4791b25ea8a6

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
