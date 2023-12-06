## Installing

Requires [Twitch Emotes v2](https://www.curseforge.com/wow/addons/twitch-emotes-v2)

Manual instructions:

1. Go to https://github.com/galacticclam/TwitchEmotes_Coomer/releases/latest
1. Extract `TwitchEmotes_Coomer`` to your Addons directory.
    * If you're playing retail, it's likely in `C:\Program Files (x86)\World of Warcraft\_retail_\Interface\Addons`
1. Reload/restart WoW

WowUp:

1. Install https://wowup.io/
1. In WowUp, install from URL with the URL `https://github.com/galacticclam/TwitchEmotes_Coomer`

## Development

### Testing your changes

1. Run `./build.sh`. A zip file will be created in `/dist`
1. Unzip this file in your Addons directory

### Publishing a new version of this addon

This requires the [GitHub CLI](https://cli.github.com/). Log in with `gh auth login`.

1. Update the version number in `TwitchEmotes_Coomer.toc`
1. Push the updated `TwitchEmotes_Coomer.toc` file
1. Run `./release.sh`
1. Review and publish the draft

### Importing Discord emotes

This requires [ImageMagick](https://imagemagick.org/script/download.php) on your `$path`

1. Send an emote in a Discord channel with nothing else, so you get a big version of the emote.
1. Right click the emote and hit "Copy link"
1. Run `./import.sh url emote_name [size]`
    * For example, `./import.sh 'https://cdn.discordapp.com/emojis/1174855519731716208.webp?size=96&quality=lossless' abigail`
    * Size must be a power of 2, otherwise you'll see green squares for your emote
    * The default size is 32. Only go higher for real-life pictures
