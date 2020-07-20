## Usage

```docker build -f docker/ubuntu/Dockerfile --tag ethcore/openetc:branch_or_tag_name .```

## Usage - CentOS

Builds a lightweight non-root OpenETC docker image:
```
git clone https://github.com/openetc/openetc.git
cd openetc
./scripts/docker/centos/build.sh
```

Fully customised build:
```
OPENETC_IMAGE_REPO=my-personal/openetc \
OPENETC_BUILDER_IMAGE_TAG=build-latest \
OPENETC_RUNNER_IMAGE_TAG=centos-openetc-experimental \
./scripts/docker/centos/build.sh
```

Default values:
```
# The image name
OPENETC_IMAGE_REPO - openetc/openetc

# The tag to be used for builder image, git commit sha will be appended
OPENETC_BUILDER_IMAGE_TAG - build

# The tag to be used for runner image
OPENETC_RUNNER_IMAGE_TAG - latest
```

All default ports you might use will be exposed:
```
#      secret
#      store     ui   rpc  ws   listener  discovery
#      ↓    ↓         ↓    ↓    ↓    ↓         ↓
EXPOSE 8082 8083 8180 8545 8546 30303/tcp 30303/udp
```
