#!/usr/bin/env bash

# e.g. ./build.sh v1.1.1 2020-04-27
# or ./build.sh latest latest to live on the edge.

code_version=${1}
data_version=${2}
lineages_version=${1}_${2}

echo "Building ${lineages_version}."

cd code
docker build --rm --build-arg VERSION=${code_version} -t registry.gitlab.com/cgps/lineages-code:${code_version} .
cd ../data
docker build --rm --build-arg VERSION=${data_version} -t registry.gitlab.com/cgps/lineages-data:${data_version} .
cd ..
docker build --rm --build-arg CODE_VERSION=${code_version} --build-arg DATA_VERSION=${data_version} -t registry.gitlab.com/cgps/lineages:${lineages_version} .
