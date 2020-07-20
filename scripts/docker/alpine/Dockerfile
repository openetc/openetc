FROM alpine:edge AS builder

# show backtraces
ENV RUST_BACKTRACE 1

RUN apk add --no-cache \
  build-base \
  cargo \
  cmake \
  eudev-dev \
  linux-headers \
  perl \
  rust \
  git \
  clang-dev \
  llvm-dev

WORKDIR /openetc
COPY . /openetc
ENV C=clang CXX=clang++
RUN cargo build --release --features final --target x86_64-alpine-linux-musl --verbose
RUN strip target/x86_64-alpine-linux-musl/release/openetc

FROM alpine:edge

# show backtraces
ENV RUST_BACKTRACE 1

# curl is installed to help create health and readiness checks on Kubernetes
RUN apk add --no-cache \
  libstdc++ \
  eudev-libs \
  libgcc \
  curl

RUN addgroup -g 1000 openetc \
  && adduser -u 1000 -G openetc -s /bin/sh -D openetc

USER openetc

EXPOSE 8080 8545 8180

WORKDIR /home/openetc

RUN mkdir -p /home/openetc/.local/share/io.parity.ethereum/
COPY --chown=openetc:openetc --from=builder /openetc/target/x86_64-alpine-linux-musl/release/openetc ./

ENTRYPOINT ["./openetc"]
