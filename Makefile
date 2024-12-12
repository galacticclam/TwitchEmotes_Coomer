emotes_dir := ./emotes
dist_dir := ./dist/TwitchEmotes_Coomer
dist_emotes_dir := $(dist_dir)/emotes

emotes_in := $(wildcard $(emotes_dir)/*.webp)
emotes_out := $(patsubst $(emotes_dir)/%.webp,$(dist_emotes_dir)/%.tga,$(emotes_in))

lua_in := $(wildcard ./*.lua)
lua_out := $(patsubst ./%.lua,$(dist_dir)/%.lua,$(lua_in))

toc_in := $(wildcard ./*.toc)
toc_out := $(patsubst ./%.toc,$(dist_dir)/%.toc,$(toc_in))

version_mainline := $(shell grep "Version: " TwitchEmotes_Coomer-Mainline.toc | cut -d ' ' -f 3)
version_classic := $(shell grep "Version: " TwitchEmotes_Coomer-Classic.toc | cut -d ' ' -f 3)

$(shell mkdir -p $(dist_emotes_dir))

.PHONY : build emotes lua build

emotes : $(emotes_out)
$(dist_emotes_dir)/%.tga : $(emotes_dir)/%.webp
	magick "$<" "$@"

lua : $(lua_out)
$(dist_dir)/%.lua : ./%.lua
	cp "$<" "$@"

toc : $(toc_out)
$(dist_dir)/%.toc : ./%.toc
	cp "$<" "$@"

build : emotes lua toc
ifneq  ($(version_mainline), $(version_classic))
    $(error TwitchEmotes_Coomer-Mainline.toc is version $(version_mainline), but TwitchEmotes_Coomer-Classic.toc is version $(version_classic))
endif
