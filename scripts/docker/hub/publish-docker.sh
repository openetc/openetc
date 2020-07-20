#!/bin/sh

set -e # fail on any error

VERSION=$(cat ./tools/VERSION)
TRACK=$(cat ./tools/TRACK)
echo "OpenETC version = ${VERSION}"
echo "OpenETC track = ${TRACK}"

test "$Docker_Hub_User_OpenETC" -a "$Docker_Hub_Pass_OpenETC" \
    || ( echo "no docker credentials provided"; exit 1 )
docker login -u "$Docker_Hub_User_OpenETC" -p "$Docker_Hub_Pass_OpenETC"
echo "__________Docker info__________"
docker info

# we stopped pushing nightlies to dockerhub, will push to own registry prb.
case "${SCHEDULE_TAG:-${CI_COMMIT_REF_NAME}}" in
    "$SCHEDULE_TAG")
        echo "Docker TAG - 'openetc/openetc:${SCHEDULE_TAG}'";
        docker build --no-cache \
            --build-arg VCS_REF="${CI_COMMIT_SHA}" \
            --build-arg BUILD_DATE="$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
            --tag "openetc/openetc:${SCHEDULE_TAG}" \
            --file tools/Dockerfile .;
        docker push "openetc/openetc:${SCHEDULE_TAG}";;
    "stable")
        echo "Docker TAGs - 'openetc/openetc:${VERSION}-${CI_COMMIT_REF_NAME}', 'openetc/openetc:stable'";
        docker build --no-cache \
            --build-arg VCS_REF="${CI_COMMIT_SHA}" \
            --build-arg BUILD_DATE="$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
            --tag "openetc/openetc:${VERSION}-${CI_COMMIT_REF_NAME}" \
            --tag "openetc/openetc:latest" \
            --tag "openetc/openetc:stable" \
            --file tools/Dockerfile .;
        docker push "openetc/openetc:${VERSION}-${CI_COMMIT_REF_NAME}";
        docker push "openetc/openetc:stable";
        docker push "openetc/openetc:latest";;
    v[0-9]*.[0-9]*)
        echo "Docker TAG - 'openetc/openetc:${VERSION}-${TRACK}'"
        docker build --no-cache \
            --build-arg VCS_REF="${CI_COMMIT_SHA}" \
            --build-arg BUILD_DATE="$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
            --tag "openetc/openetc:${VERSION}-${TRACK}" \
            --file tools/Dockerfile .;
        docker push "openetc/openetc:${VERSION}-${TRACK}";;
    *)
        echo "Docker TAG - 'openetc/openetc:${VERSION}-${CI_COMMIT_REF_NAME}'"
        docker build --no-cache \
            --build-arg VCS_REF="${CI_COMMIT_SHA}" \
            --build-arg BUILD_DATE="$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
            --tag "openetc/openetc:${VERSION}-${CI_COMMIT_REF_NAME}" \
            --file tools/Dockerfile .;
        docker push "openetc/openetc:${VERSION}-${CI_COMMIT_REF_NAME}";;
esac

docker logout
