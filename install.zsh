#!/usr/bin/env zsh

prog_name=killer-daemon
config_file=/etc/${prog_name}_config

mkdir -v -p '/opt/local/bin'
cp -iv killer-daemon.zsh '/opt/local/bin'

cp -iv init-killer-daemon.plist /Library/LaunchDaemons

if [[ ! -e $config_file ]]; then
    echo "# list of process names to kill" > ${config_file}
fi

echo "loading /Library/LaunchDaemons/init-${prog_name}.plist"
launchctl load -w /Library/LaunchDaemons/init-${prog_name}.plist
