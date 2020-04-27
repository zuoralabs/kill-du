#!/usr/bin/env zsh

mkdir -v -p '/opt/local/bin'
cp -iv kill-du.zsh '/opt/local/bin'

cp -iv init-kill-du.plist /Library/LaunchDaemons

echo 'loading /Library/LaunchDaemons/init-kill-du.plist'
launchctl load -w /Library/LaunchDaemons/init-kill-du.plist
