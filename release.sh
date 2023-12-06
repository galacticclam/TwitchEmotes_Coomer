#!/bin/bash

set -euo pipefail

version_mainline=$(grep "Version: " TwitchEmotes_Coomer-Mainline.toc | cut -d ' ' -f 3)
version_classic=$(grep "Version: " TwitchEmotes_Coomer-Classic.toc | cut -d ' ' -f 3)

[ "$version_mainline" == "$version_classic" ] || {
    echo "Error: TwitchEmotes_Coomer-Mainline.toc is version $version_mainline, but TwitchEmotes_Coomer-Classic.toc is version $version_classic"
    exit 1
}

version="$version_mainline-release"

[[ -z $(git status -s) ]] || {
    echo "Error: Not all changes committed"
    exit 1
}

git merge-base --is-ancestor HEAD @{u} || {
    echo "Error: Not all commits merged"
    exit 1
}

./build.sh

git tag -f -a "$version" -m "$version"
git push origin --tags "$version"

gh release create \
    "$version" \
    --verify-tag \
    --title "$version" \
    --notes "$version" \
    "dist/TwitchEmotes_Coomer-$version.zip"

echo "Published version $version"
