# Killer Daemon

Launch daemon to kill du processes run by root on MacOS robustly, every second.

If the daemon dies it will restart.

This is useful if du is causing your system to overheat.


## WARNING

As a side effect, no one seems to be able to run du while this daemon is active.


## Installation

Run `sudo ./install.zsh`. This will install files to `/opt/local/bin` and  `/Library/LaunchDaemons`
then load the launch daemon.


## Why not ...?

Did not use flock because MacOS doesn't come with it, and don't want to have to compile it.


## TODO

- [x] *Handle clashes.*
  If there are two daemons running, they should see each other and one of them should quit. 
  This can be done by adding a PIDFILE containing the PID for the latest run.
  If the latest run was in the last 10s, and the PID is not the current PID, then quit.

- [ ] *Allow certain users to run du.*

- [ ] *Limit number of running instances*
      Presently, the number of running kill-du instances could become infinite if
      many instances are stuck. Suppose, e.g., one instance is stuck on killing
      a process indefinitely, and another instance spins up and gets stuck,
      etc.
