FROM jetbo/linux-gsm-docker:latest

# Fix some issues with root...
USER root

# Fixes SDL error
RUN apt-get install -y libsdl2-2.0-0

# Fixes locale errors
ENV LANG=en_US.utf8
ENV LC_ALL=en_US.utf8
ENV LANGUAGE=en_US.utf8
RUN apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

# Install cron
RUN apt-get install -y cron

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
EXPOSE 2456/udp 2457/udp 2458/udp
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
COPY --chown=linuxgsm:linuxgsm healthcheck/ping.html /home/linuxgsm/healthcheck/ping.html

# Copy crontab (optional daily restart)
COPY --chown=linuxgsm:linuxgsm scripts/linuxgsm-crontabs /home/linuxgsm/linuxgsm-crontabs
RUN chmod 0644 /home/linuxgsm/linuxgsm-crontabs

# Copy daily restart script
COPY --chown=linuxgsm:linuxgsm scripts/daily-reboot.sh /home/linuxgsm/gsm/daily-reboot.sh
RUN chmod +x /home/linuxgsm/gsm/daily-reboot.sh

# Create simple volume folders
RUN mkdir -p /home/linuxgsm/gsm/log \
  /home/linuxgsm/.local/share/Steam/logs \
  /home/linuxgsm/.config/unity3d/IronGate/Valheim

# Config must be loaded AFTER any volumes
ENTRYPOINT []
CMD [ "/home/linuxgsm/gsm/load_config.sh" ]
