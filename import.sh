#!/bin/bash

set -euo pipefail

image="emotes/$2.webp"

size=${3:-32}

url=$(echo "$1" | sed "s/size=[[:digit:]]\+/size=$size/")
curl "$url" -o "emotes/$2.webp"

magick "$image" -background none -gravity center -extent "${size}x${size}" "$image"

newline='judhead_emotes["'$2'"] = "Interface\\AddOns\\TwitchEmotes_Coomer\\emotes\\'$2'.tga:28:28";'

echo "$newline" >> emotes.lua
