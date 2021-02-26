FROM jetbo/linux-gsm-docker:latest

# fixes SDL error
USER root
RUN apt-get install -y libsdl2-2.0-0

# Run server on linuxgsm user
USER linuxgsm

# Move linuxgsm files to help with volume setup
RUN mkdir -p /home/linuxgsm/gsm
RUN cp /home/linuxgsm/linuxgsm.sh /home/linuxgsm/gsm/linuxgsm.sh
WORKDIR /home/linuxgsm/gsm

# Install vhserver
RUN bash linuxgsm.sh vhserver
RUN ./vhserver auto-install

# Game ports
EXPOSE 2456/udp 2457/udp 2458/udp 2459/udp
# Steam ports
EXPOSE 27015/tcp 27015/udp
# Health check
EXPOSE 8080

# Copy custom config
COPY --chown=linuxgsm:linuxgsm scripts/vhserver.cfg /home/linuxgsm/gsm/vhserver.cfg

# Copy script
COPY --chown=linuxgsm:linuxgsm scripts/load_config.sh /home/linuxgsm/gsm/load_config.sh
RUN chmod +x /home/linuxgsm/gsm/load_config.sh

# Copy simple server health checks
RUN mkdir -p /home/linuxgsm/healthcheck
COPY healthcheck/ping.html /home/linuxgsm/healthcheck/ping.html

# Create simple volume folders
RUN mkdir -p /home/linuxgsm/gsm/log \
  /home/linuxgsm/.local/share/Steam/logs \
  /home/linuxgsm/.config/unity3d/IronGate/Valheim

# Config must be loaded AFTER any volumes
ENTRYPOINT []
CMD [ "/home/linuxgsm/gsm/load_config.sh" ]
