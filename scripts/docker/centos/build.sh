#!/usr/bin/env sh

# The image name
OPENETC_IMAGE_REPO=${OPENETC_IMAGE_REPO:-openetc/openetc}
# The tag to be used for builder image
OPENETC_BUILDER_IMAGE_TAG=${OPENETC_BUILDER_IMAGE_TAG:-build}
# The tag to be used for runner image
OPENETC_RUNNER_IMAGE_TAG=${OPENETC_RUNNER_IMAGE_TAG:-latest}

echo Building $OPENETC_IMAGE_REPO:$OPENETC_BUILDER_IMAGE_TAG-$(git log -1 --format="%H")
docker build --no-cache -t $OPENETC_IMAGE_REPO:$OPENETC_BUILDER_IMAGE_TAG-$(git log -1 --format="%H") . -f scripts/docker/centos/Dockerfile.build

echo Creating $OPENETC_BUILDER_IMAGE_TAG-$(git log -1 --format="%H"), extracting binary
docker create --name extract $OPENETC_IMAGE_REPO:$OPENETC_BUILDER_IMAGE_TAG-$(git log -1 --format="%H")
mkdir scripts/docker/centos/openetc
docker cp extract:/build/openetc/target/release/openetc scripts/docker/centos/openetc

echo Building $OPENETC_IMAGE_REPO:$OPENETC_RUNNER_IMAGE_TAG
docker build --no-cache -t $OPENETC_IMAGE_REPO:$OPENETC_RUNNER_IMAGE_TAG scripts/docker/centos/ -f scripts/docker/centos/Dockerfile

echo Cleaning up ...
rm -rf scripts/docker/centos/openetc
docker rm -f extract
docker rmi -f $OPENETC_IMAGE_REPO:$OPENETC_BUILDER_IMAGE_TAG-$(git log -1 --format="%H")

echo Echoing OpenETC version:
docker run $OPENETC_IMAGE_REPO:$OPENETC_RUNNER_IMAGE_TAG --version

echo Done.
