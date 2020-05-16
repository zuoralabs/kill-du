#!/usr/bin/env zsh

# Restart dns-updater when it is acting up

sudo pkill -x dns-updater
sudo /Library/Application\ Support/OpenDNS\ Roaming\ Client/dns-updater
