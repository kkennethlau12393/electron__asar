#!/usr/bin/env bash
# Written by abloh init. This file is how your project builds.
# It is the single source of truth for the steps abloh runs before it measures your suite,
# and abloh never guesses around it.
# Edit it freely. Plain shell, one step per block. Your coding agent can edit it too.
set -euo pipefail

# step 1: OS packages your suite needs, pinned. From test.yml::test installs them unpinned; abloh read each version from your proof image's archive
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends libasound2=1.2.8-1+b1 libgbm-dev=22.3.6-1+deb12u2 libgtk-3-0=3.24.38-2~deb12u3 libnss3=2:3.87.1-1+deb12u4 libxss1=1:1.2.3-1 libxtst6=2:1.2.3-1.1 xvfb=2:21.1.7-3+deb12u13
rm -rf /var/lib/apt/lists/*

# step 2: put the package manager on PATH, for your own lifecycle scripts. From yarn.lock, yarn@4.10.3
corepack enable

# step 3: dependencies, from your lockfile. From yarn.lock, yarn@4.10.3
corepack yarn install --immutable

# step 4: your build. From test.yml::test
yarn build

# After this script finishes, your suite runs sealed: no network, no secrets.
