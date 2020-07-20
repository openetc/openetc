FROM centos:latest

RUN mkdir -p /opt/openetc/data && \
    chmod g+rwX /opt/openetc/data && \
    mkdir -p /opt/openetc/release

COPY openetc/openetc /opt/openetc/release

WORKDIR /opt/openetc/data

# exposing default ports
#
#      secret
#      store     ui   rpc  ws   listener  discovery
#      ↓         ↓    ↓    ↓    ↓         ↓
EXPOSE 8082 8083 8180 8545 8546 30303/tcp 30303/udp

# switch to non-root user
USER 1001

#if no base path provided, assume it's current workdir
CMD ["--base-path","."]
ENTRYPOINT ["/opt/openetc/release/openetc"]
