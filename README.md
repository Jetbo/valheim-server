# valheim-server

Simple docker setup for a valheim server running on LinuxGSM.

Build the app with `docker-compose up --build`.

You can change the ENVs in the docker-compose. ENVs control the basic server config.

```
SERVER_PASSWORD       # Sets the server password (string)
SERVER_NAME           # Sets the server name (string)
SERVER_PUBLIC         # Sets if the server is public or not (0, 1)
SERVER_WORLD_NAME     # Sets the world name (string)
HEALTH_CHECK_PORT     # Sets the health check port (int)
ENABLE_CLEAN_SHUTDOWN # Enables the clean shutdown script. This script runs the vhserver stop command on SIGTERM trap. (0, 1)
UPDATE_ON_RUN         # Updates LinuxGSM and the Valheim server on run (0, 1)
```

If you want to make sure the world saves before the container exists, enable `ENABLE_CLEAN_SHUTDOWN` in the ENV. Valheim saves to the world files when players leave and in time intervals. Killing the container suddenly could lead to corruption or world progress loss.

If you want to the server to update itself, say on something like a nightly reboot, enable `UPDATE_ON_RUN` in the ENV. This will run both the LinuxGSM and Valheim server update commands before the server boots up. Keep in mind the server will start faster with this disabled. If disabled, remember to update the server manually or re-build the container to install new versions.

## Useful file locations

```
# Holds the Valheim world files and server user lists (admins, bans, etc)
# This directory is setup as a volume to remain persistent
/home/linuxgsm/.config/unity3d/IronGate/Valheim/

# GSM and game logs
# This directory is setup as a volume to remain persistent
/home/linuxgsm/gsm/log/
```
