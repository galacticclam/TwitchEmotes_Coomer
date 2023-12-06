#!/bin/bash

set -euo pipefail

version=$(grep "Version: " TwitchEmotes_Coomer.toc | cut -d ' ' -f 3)

[[ -z $(git status -s) ]] || {
    echo "Error: Not all changes committed"
    exit 1
}

git merge-base --is-ancestor HEAD @{u} || { 
    echo "Error: Not all commits merged"
    exit 1
}

./build.sh

gh release create \
    "$version" \
    --title "$version" \
    --notes "$version" \
    "dist/TwitchEmotes_Coomer-$version.zip"

echo "Published version $version"
