#!/usr/bin/env zsh

LAST_RUN_FILE=/var/tmp/personal.andrew-lee.kill-du.last-run
PIDFILE=/var/tmp/personal.andrew-lee.kill-du.pid

fmt=+'%Y-%m-%d-%H-%M-%S'


function exit_if_last_run_recent {
    local current_date_minus_10S=$(date -v -10S $fmt)
    if [[ -e $LAST_RUN_FILE ]]; then
        last_run=$(<$LAST_RUN_FILE)
        echo last run: $last_run
        # WARNING: -le only works on ints according to https://unix.stackexchange.com/a/84472
        if [[ $current_date_minus_10S < $last_run ]]; then
            exit
        fi
    fi
}

function pcpu {
    pgrep -x $1 | xargs -J % ps -o pcpu | tail +2
}

function pkill_if_high_pcpu {
    local _pcpu
    _pcpu=$(pcpu $1)
    if [[ -z $_pcpu ]]; then
        return
    fi

    if (( 99.0 <= $_pcpu )); then
        pkill -x $1 -U 0
    fi
}

exit_if_last_run_recent

echo 'does not appear to already be running; entering loop'
echo $$ > $PIDFILE

while true; do
    if [[ $$ != $(<$PIDFILE) ]]; then
        echo "clash detected with $(<$PIDFILE); exiting"
        exit
    fi
    sleep 1
    pkill -x du -U 0
    pkill_if_high_pcpu dns-updater
    pkill_if_high_pcpu configd
    date $fmt > $LAST_RUN_FILE
done
