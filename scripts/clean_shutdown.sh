#!/bin/bash

# Server shutdown logic
shutdown() {
  echo "Saving World..."
  /home/linuxgsm/gsm/vhserver stop;
}

# Trap SIGTERM
trap 'shutdown' SIGTERM

# Execute a command
"${@}" &

# Wait
wait $!
