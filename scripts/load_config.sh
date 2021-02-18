#!/bin/bash

# Require ENVs
: "${SERVER_PASSWORD?Need to set SERVER_PASSWORD}";
: "${SERVER_NAME?Need to set SERVER_NAME}";
: "${SERVER_PUBLIC?Need to set SERVER_PUBLIC}";
: "${SERVER_WORLD_NAME?Need to set SERVER_WORLD_NAME}";
: "${HEALTH_CHECK_PORT?Need to set HEALTH_CHECK_PORT}";

# Output settings (but not password obviously)
echo "Servername is set to: $SERVER_NAME";
echo "Public is set to: $SERVER_PUBLIC";
echo "Worldname is set to: $SERVER_WORLD_NAME";
echo "Health checks can be performed on port $HEALTH_CHECK_PORT";
echo "Password will not be displayed";

# Set values with sed
sed -i "s/servername=.*/servername=\"$SERVER_NAME\"/" /home/linuxgsm/gsm/vhserver.cfg;
sed -i "s/public=.*/public=\"$SERVER_PUBLIC\"/" /home/linuxgsm/gsm/vhserver.cfg;
sed -i "s/serverpassword=.*/serverpassword=\"$SERVER_PASSWORD\"/" /home/linuxgsm/gsm/vhserver.cfg;
sed -i "s/gameworld=.*/gameworld=\"$SERVER_WORLD_NAME\"/" /home/linuxgsm/gsm/vhserver.cfg;

# Replace config
cp /home/linuxgsm/gsm/vhserver.cfg /home/linuxgsm/gsm/lgsm/config-lgsm/vhserver/vhserver.cfg;

# Start server
/home/linuxgsm/gsm/vhserver start;

# Start simple health check service
python3 -m http.server -d /home/linuxgsm/healthcheck/ $HEALTH_CHECK_PORT > /dev/null 2>&1 &

# Load crontab
crontab /home/linuxgsm/linuxgsm-crontabs

# Add a blank log so we can tail the initial setup
touch /home/linuxgsm/gsm/log/console/vhserver-console.log

# Keep the execution context open
tail -f /home/linuxgsm/gsm/log/console/vhserver-console.log;
