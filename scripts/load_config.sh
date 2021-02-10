#!/bin/bash

# Require ENVs
: "${SERVER_PASSWORD?Need to set SERVER_PASSWORD}";
: "${SERVER_NAME?Need to set SERVER_NAME}";
: "${SERVER_PUBLIC?Need to set SERVER_PUBLIC}";
: "${SERVER_WORLD_NAME?Need to set SERVER_WORLD_NAME}";

# Output settings (but not password obviously)
echo "Servername is set to: $SERVER_NAME";
echo "Public is set to: $SERVER_PUBLIC";
echo "Worldname is set to: $SERVER_WORLD_NAME";
echo "Password will not be displayed";

# Set values with sed
sed -i "s/servername=.*/servername=\"$SERVER_NAME\"/" /home/linuxgsm/vhserver.cfg;
sed -i "s/public=.*/public=\"$SERVER_PUBLIC\"/" /home/linuxgsm/vhserver.cfg;
sed -i "s/serverpassword=.*/serverpassword=\"$SERVER_PASSWORD\"/" /home/linuxgsm/vhserver.cfg;
sed -i "s/gameworld=.*/gameworld=\"$SERVER_WORLD_NAME\"/" /home/linuxgsm/vhserver.cfg;

# Replace config
cp /home/linuxgsm/vhserver.cfg /home/linuxgsm/gsm/lgsm/config-lgsm/vhserver/vhserver.cfg;

# Start server
/home/linuxgsm/gsm/vhserver start;

# Keep the execution context open
tail -f /home/linuxgsm/gsm/log/console/vhserver-console.log;
