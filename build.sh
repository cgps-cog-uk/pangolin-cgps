# e.g. ./build.sh v1.1.1 2020-04-27
# or ./build.sh latest latest to live on the edge.

code_version=${1}
data_version=${2}
combined_version=${1}_${2}

echo "Building pangolin ${code_version}."
cd code
docker build --rm --build-arg VERSION=${code_version} -t registry.gitlab.com/cgps/cog-uk/pangolin-code:${code_version} .

echo "Building pangoLEARN ${combined_version}."
cd ../data
docker build --rm --build-arg VERSION=${data_version} -t registry.gitlab.com/cgps/cog-uk/pangolin-data:${data_version} .

echo "Combining code and data repositories"
cd ..
docker build --rm --build-arg CODE_VERSION=${code_version} --build-arg DATA_VERSION=${data_version} -t registry.gitlab.com/cgps/cog-uk/pangolin:${combined_version} .
