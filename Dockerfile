FROM jetbo/linux-gsm-docker:latest

USER linuxgsm

WORKDIR /home/linuxgsm

RUN bash ~/linuxgsm.sh vhserver
RUN ~/vhserver auto-install

EXPOSE 2456
EXPOSE 2457
EXPOSE 27015/tcp
EXPOSE 27015/udp

ENTRYPOINT [ "/home/linuxgsm/vhserver" ]
