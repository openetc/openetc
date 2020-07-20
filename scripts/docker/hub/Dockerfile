FROM ubuntu:xenial

# metadata
ARG VCS_REF
ARG BUILD_DATE

LABEL openetc.image.authors="devops-team@parity.io" \
	openetc.image.vendor="OpenETC project" \
	openetc.image.title="openetc/openetc" \
	openetc.image.description="Fast and feature-rich multi-network Ethereum client." \
	openetc.image.source="https://github.com/openetc/openetc/blob/${VCS_REF}/\
	scripts/docker/hub/Dockerfile" \
	openetc.image.documentation="https://wiki.parity.io/Parity-Ethereum" \
	openetc.image.revision="${VCS_REF}" \
	openetc.image.created="${BUILD_DATE}"

# show backtraces
ENV RUST_BACKTRACE 1

# install tools and dependencies
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
	file curl jq ca-certificates; \
	# apt cleanup
	apt-get autoremove -y; \
	apt-get clean; \
	update-ca-certificates; \
	rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*; \
	# add user
	groupadd -g 1000 openetc; \
	useradd -m -u 1000 -g openetc -s /bin/sh openetc

WORKDIR /home/openetc

# add openetc binary to docker image
COPY artifacts/x86_64-unknown-linux-gnu/openetc /bin/openetc
COPY tools/check_sync.sh /check_sync.sh

# switch to user openetc here
USER openetc

# check if executable works in this container
RUN openetc --version

EXPOSE 5001 8080 8082 8083 8545 8546 8180 30303/tcp 30303/udp

ENTRYPOINT ["/bin/openetc"]
