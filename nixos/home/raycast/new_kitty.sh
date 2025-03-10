#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title new kitty
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 😸
# @raycast.packageName Script

# Documentation:
# @raycast.description Open New Kitty Window
# @raycast.author zdonik


open -a @kitty_path@/Applications/kitty.app --new
