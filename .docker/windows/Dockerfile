# syntax=docker/dockerfile:1

FROM mirror.gcr.io/debian:13@sha256:f324c7ff54321e8d9c588493a20244965938ce0aa50bbd1022d38010e9ffc4b1

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
