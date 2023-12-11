#!/bin/bash

. .env

set -euo pipefail

rm -rf import && mkdir import
image_orig="import/$2.webp"
image_resized="import/$2-resized.webp"
image_appended="import/$2-appended.webp"
image_final="emotes/$2.webp"

curl "$1" -o "$image_orig"

magick "$image_orig" -resize '32x32' "$image_resized"

anim_dump -folder import "$image_resized"

magick import/dump_* -append "$image_appended"

h=$(magick identify -ping -format '%h' "$image_appended")

frames=$((h/32))

# Round h up to the next power of 2
h=$(($h-1))
h=$((h|($h>>1)))
h=$((h|($h>>2)))
h=$((h|($h>>4)))
h=$((h|($h>>8)))
h=$((h|($h>>16)))
h=$((h|($h>>32)))
h=$(($h+1))

magick "$image_appended" -background none -gravity North -extent "32x${h}" "$image_final"

emotes_newline='["'$2'"] = basePath .. "'$2'.tga:28:28",'
sed -i -e '$i\'"    $emotes_newline" emotes.lua

animation_newline="TwitchEmotes_animation_metadata[basePath .. \"$2.tga\"] = {[\"nFrames\"] = $frames, [\"frameWidth\"] = 32, [\"frameHeight\"] = 32, [\"imageWidth\"] = 32, [\"imageHeight\"] = $h, [\"framerate\"] = 18}";
echo "$animation_newline" >> animation.lua
