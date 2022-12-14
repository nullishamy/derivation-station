#! /usr/bin/env nix-shell
#! nix-shell -i bash -p jq

settings_content=$(cat $settings_path)
patch_content='
{
   "DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,
   "SKIP_HOST_UPDATE": true,
   "MIN_WIDTH": 0,
   "MIN_HEIGHT": 0
}
'

base_dir="$HOME/.config/discord"
settings_file="settings.json"
settings_path="$base_dir/$settings_file"


echo "$settings_content" "$patch_content" | jq -s add > "$settings_path"
