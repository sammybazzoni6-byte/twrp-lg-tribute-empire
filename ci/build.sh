#!/bin/bash
# Runs INSIDE an ubuntu:18.04 container. /twrp = work dir, /tree = device tree.
set -ex
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y git curl python python3 openjdk-8-jdk-headless bc bison build-essential flex \
  gcc-multilib g++-multilib gperf libncurses5-dev libssl-dev lib32z1-dev libxml2-utils zip unzip \
  zlib1g-dev rsync lzop lz4 xz-utils ca-certificates cpio libtinfo5
curl -sSL https://storage.googleapis.com/git-repo-downloads/repo -o /usr/local/bin/repo
chmod +x /usr/local/bin/repo
git config --global user.name ci
git config --global user.email ci@example.com
git config --global color.ui false
cd /twrp
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b "${BRANCH:-twrp-8.1}"
repo sync -c -j4 --force-sync --no-clone-bundle --no-tags
mkdir -p device/lge
cp -r /tree device/lge/mcv1s
export ALLOW_MISSING_DEPENDENCIES=true LC_ALL=C
. build/envsetup.sh
lunch omni_mcv1s-eng
mka recoveryimage -j4
ls -l out/target/product/mcv1s/recovery.img
