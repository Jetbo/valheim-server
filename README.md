# valheim-server

Simple docker setup for a valheim server running on LinuxGSM.

Build the app with `docker-compose up --build`.

You can change the ENVs in the docker-compose. ENVs control the basic server config.

```
SERVER_PASSWORD    # Sets the server password (string)
SERVER_NAME        # Sets the server name (string)
SERVER_PUBLIC      # Sets if the server is public or not (0, 1)
SERVER_WORLD_NAME  # Sets the world name (string)
```
