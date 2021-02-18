#!/bin/bash

wall "hit";

# Simple reboot to ensure the world gets written to EFS
if [ "$ENABLE_DAILY_REBOOT" = "true" ]
then
  /home/linuxgsm/gsm/vhserver restart;
fi
