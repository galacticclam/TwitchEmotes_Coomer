#!/bin/bash

set -euo pipefail

version_mainline=$(grep "Version: " TwitchEmotes_Coomer-Mainline.toc | cut -d ' ' -f 3)
version_classic=$(grep "Version: " TwitchEmotes_Coomer-Classic.toc | cut -d ' ' -f 3)

[ "$version_mainline" == "$version_classic" ] || {
    echo "Error: TwitchEmotes_Coomer-Mainline.toc is version $version_mainline, but TwitchEmotes_Coomer-Classic.toc is version $version_classic"
    exit 1
}

version=$version_mainline

dist_root="dist"
dist_dir="$dist_root/TwitchEmotes_Coomer"
zip_name="$dist_root/TwitchEmotes_Coomer-$version-release.zip"

rm -rf "$dist_root"
mkdir -p "$dist_dir"
cp -r emotes "$dist_dir"
cp emotes.lua "$dist_dir"
cp main.lua "$dist_dir"
cp TwitchEmotes_Coomer-Mainline.toc "$dist_dir"
cp TwitchEmotes_Coomer-Classic.toc "$dist_dir"

powershell Compress-Archive "$dist_dir" "$zip_name"
