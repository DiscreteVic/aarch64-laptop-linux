# aarch64-laptop-linux

## Getting the sources

This repository uses git submodules. First of all, initialize and update them:

```sh
git submodule update --init --recursive
```

## Prerequisites

### GRUB

GRUB (`grub/` submodule) is cross-compiled on an x86_64 host for the
`arm64-efi` target. Building it from a git checkout requires:

- **Build tools:** gcc, make, git, autoconf (>= 2.64), automake (>= 1.14),
  gettext/autopoint, bison (>= 2.3), flex (>= 2.5.35), pkg-config, patch,
  gawk, python3, wget
- **aarch64 cross toolchain:** `aarch64-linux-gnu-gcc` and binutils
  (or another one, e.g. Arm's `aarch64-none-linux-gnu-gcc`, passed as `TARGET_CC`)
- **Libraries / fonts:** libdevmapper, FreeType 2 (for `grub-mkfont`),
  GNU Unifont, liblzma, libfuse3 (for `grub-mount`), libtasn1 (for `grub-protect`)
- **Optional:** texinfo and help2man (docs), xorriso and mtools (`grub-mkrescue`)

#### Debian / Ubuntu

```sh
sudo apt install build-essential git autoconf automake autopoint gettext \
    bison flex pkg-config patch gawk python3 wget \
    gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu \
    libdevmapper-dev libfreetype-dev xfonts-unifont liblzma-dev \
    libfuse3-dev libtasn1-6-dev \
    texinfo help2man xorriso mtools
```

#### Fedora

```sh
sudo dnf install gcc make git autoconf automake gettext-devel \
    bison flex pkgconf-pkg-config patch gawk python3 wget \
    gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu \
    device-mapper-devel freetype-devel unifont-fonts xz-devel \
    fuse3-devel libtasn1-devel \
    texinfo help2man xorriso mtools
```
