#!/bin/bash

set -euo pipefail

image="emotes/$2.webp"

size=${3:-64}

url=$(echo "$1" | sed "s/size=[[:digit:]]\+/size=$size/")
curl "$url" -o "emotes/$2.webp"

# magick "$image" -background none -gravity center -resize "${size}x${size}" "$image"

magick "$image" -background none -gravity center -extent "128x64" "$image"

newline='["'$2'"] = basePath .. "'$2'.tga:28:28",'

# Insert before the last line (before the closing bracket)
sed -i -e '$i\'"    $newline" emotes.lua
