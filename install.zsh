#!/usr/bin/env zsh

mkdir -v -p '/opt/local/bin'
cp -iv killer-daemon.zsh '/opt/local/bin'

cp -iv init-killer-daemon.plist /Library/LaunchDaemons

echo 'loading /Library/LaunchDaemons/init-killer-daemon.plist'
launchctl load -w /Library/LaunchDaemons/init-killer-daemon.plist
