FROM fedora:31

COPY prepare.sh cleanup.sh /root/

RUN /usr/bin/sh /root/prepare.sh && \
    /usr/bin/sh /root/cleanup.sh
