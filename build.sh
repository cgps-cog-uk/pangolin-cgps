#!/usr/bin/env bash

# e.g. ./build.sh v1.1.1 2020-04-27
# or ./build.sh latest latest to live on the edge.

IMAGE_TAG=${1}

# get ${pangolin_version} and ${pangoLEARN_version} from .env file
set -o allexport
source .env
set +o allexport

echo "Building pangolin ${PANGOLIN_VERSION}"
if docker pull registry.gitlab.com/cgps/cog-uk/pangolin/code:"${PANGOLIN_VERSION}"; then
  echo "code:${PANGOLIN_VERSION} already exists."
else
  cd code
  docker build --rm --build-arg VERSION="${PANGOLIN_VERSION}" -t registry.gitlab.com/cgps/cog-uk/pangolin/code:"${PANGOLIN_VERSION}" .
  docker push registry.gitlab.com/cgps/cog-uk/pangolin/code:"${PANGOLIN_VERSION}"
  cd ..
fi

echo "Building pangolin-data ${PANGOLIN_DATA_VERSION}"
if docker pull registry.gitlab.com/cgps/cog-uk/pangolin/models:"${PANGOLIN_DATA_VERSION}"; then
  echo "data:${PANGOLIN_DATA_VERSION} already exists."
else
  cd data
  docker build --rm --build-arg VERSION="${PANGOLIN_DATA_VERSION}" -t registry.gitlab.com/cgps/cog-uk/pangolin/models:"${PANGOLIN_DATA_VERSION}" .
  docker push registry.gitlab.com/cgps/cog-uk/pangolin/models:"${PANGOLIN_DATA_VERSION}"
  cd ..
fi

echo "Combining code and data repositories"
if docker pull registry.gitlab.com/cgps/cog-uk/pangolin:"${IMAGE_TAG}"; then
  echo "pangolin:${IMAGE_TAG} already exists."
else
  docker build --rm --build-arg PANGOLIN_VERSION="${PANGOLIN_VERSION}" --build-arg PANGOLIN_DATA_VERSION="${PANGOLIN_DATA_VERSION}" -t registry.gitlab.com/cgps/cog-uk/pangolin:"${IMAGE_TAG}" .
  docker push registry.gitlab.com/cgps/cog-uk/pangolin:"${IMAGE_TAG}"
fi
