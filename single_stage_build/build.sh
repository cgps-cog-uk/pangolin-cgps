pangolin_version=${1}

docker build --rm --build-arg VERSION=${pangolin_version} -t registry.gitlab.com/cgps/cog-uk/lineages:${pangolin_version} single_stage_build
docker push registry.gitlab.com/cgps/cog-uk/lineages:${pangolin_version}