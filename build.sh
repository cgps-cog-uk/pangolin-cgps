#!/usr/bin/env bash

# e.g. ./build.sh v20.0.0

IMAGE_TAG=${1}

# get ${pangolin_version} and ${pangoLEARN_version} from .env file
set -o allexport
source .env
set +o allexport

#echo "Building pangolin ${PANGOLIN_VERSION} & ${PANGOLIN_DATA_VERSION}"
#if docker pull registry.gitlab.com/cgps/cog-uk/pangolin:"${IMAGE_TAG}"; then
#  echo "pangolin:${IMAGE_TAG} already exists."
#else
docker build --pull --rm -t registry.gitlab.com/cgps/cog-uk/pangolin:"${IMAGE_TAG}" . || exit 1
docker push registry.gitlab.com/cgps/cog-uk/pangolin:"${IMAGE_TAG}"
#fi
