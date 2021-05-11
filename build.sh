# e.g. ./build.sh v1.1.1 2020-04-27
# or ./build.sh latest latest to live on the edge.
IMAGE_TAG=${1}

# get ${pangolin_version} and ${pangoLEARN_version} from .env file
set -o allexport
source .env
set +o allexport

echo "Building pangolin ${PANGOLIN_VERSION}"
cd code
docker build --rm --build-arg VERSION=${PANGOLIN_VERSION} -t registry.gitlab.com/cgps/cog-uk/lineages-code:${PANGOLIN_VERSION} .

echo "Building pangoLEARN ${PANGOLEARN_VERSION}"
cd ../data
docker build --rm --build-arg VERSION=${PANGOLEARN_VERSION} -t registry.gitlab.com/cgps/cog-uk/lineages-data:${PANGOLEARN_VERSION} .

echo "Combining code and data repositories"
cd ..
docker build --rm --build-arg PANGOLIN_VERSION=${PANGOLIN_VERSION} --build-arg PANGOLEARN_VERSION=${PANGOLEARN_VERSION} -t registry.gitlab.com/cgps/cog-uk/pangolin:${IMAGE_TAG} .
