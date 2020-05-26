#!/usr/bin/env zsh

LAST_RUN_FILE=/var/tmp/personal.andrew-lee.killer-daemon.last-run
PIDFILE=/var/tmp/personal.andrew-lee.killer-daemon.pid

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
    date $fmt > $LAST_RUN_FILE
done
