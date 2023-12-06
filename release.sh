#!/bin/bash

set -euo pipefail

version=$(grep "Version: " TwitchEmotes_Coomer.toc | cut -d ' ' -f 3)

./build.sh

gh release create \
    "$version" \
    --title "$version" \
    --notes "$version" \
    --draft \
    "dist/TwitchEmotes_Coomer-$version.zip"
