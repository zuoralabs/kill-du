# Killer Daemon

Launch daemon to kill selected processes run by root on MacOS robustly, every second.

If the daemon dies it will restart.

This is useful if some processes are causing your system to overheat.


## WARNING

As a side effect, no one seems to be able to run processes on the kill list while this daemon is active.


## Installation

Run `sudo ./install.zsh`. This will install files to `/opt/local/bin` and  `/Library/LaunchDaemons`, create `/etc/killer-daemon_config` if it doesn't exist,
then load the launch daemon.

Put the process names you want to kill in `/etc/killer-daemon_config`, one name per line.


## Why not ...?

Did not use flock because MacOS doesn't come with it, and don't want to have to compile it.


## TODO

- [x] *Handle clashes.*
  If there are two daemons running, they should see each other and one of them should quit. 
  This can be done by adding a PIDFILE containing the PID for the latest run.
  If the latest run was in the last 10s, and the PID is not the current PID, then quit.

- [ ] *Allow certain users to run processes on the config list.*

- [ ] *Limit number of running instances*
      Presently, the number of running killer-daemon instances could become infinite if
      many instances are stuck. Suppose, e.g., one instance is stuck on killing
      a process indefinitely, and another instance spins up and gets stuck,
      etc.
