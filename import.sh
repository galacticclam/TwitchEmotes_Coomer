#!/bin/bash

set -euo pipefail

image_in="emotes/$2.webp"
image_out="emotes/$2.tga"

size=${3:-32}

url=$(echo "$1" | sed "s/size=[[:digit:]]\+/size=$size/")
curl "$url" -o "emotes/$2.webp"

magick "$image_in" -background none -gravity center -extent "${size}x${size}" "$image_out"

rm "$image_in"

newline='judhead_emotes["'$2'"] = "Interface\\AddOns\\TwitchEmotes_Coomer\\emotes\\'$2'.tga:28:28";'

echo "$newline" >> emotes.lua
