# syntax=docker/dockerfile:1

FROM mirror.gcr.io/debian:13.7@sha256:8c4733a92aacd0bcff3779eadc35a4a5147f36cb20a5fcb56504cbc740212259

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
      gcc-aarch64-linux-gnu \
      g++-aarch64-linux-gnu \
      libc6-dev-arm64-cross \
      gcc-arm-linux-gnueabihf \
      g++-arm-linux-gnueabihf \
      libc6-dev-armhf-cross \
      qemu-user \
      # libdav1d \
      meson \
      ninja-build \
      nasm; \
    rm -rf /var/lib/apt/lists/*;
