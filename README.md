# Build instructions
Single stage build
## Command line test
#### Build Docker image
```
single_stage_build/build.sh v2.2.1
```
#### Test
```
cat test_files/good_sequence.fasta | docker run --rm -i registry.gitlab.com/cgps/cog-uk/pangolin:v2.2.1
{"taxon": "hCoV-19/Scotland/CVR07/2020|EPI_ISL_415630", "lineage": "B.40", "probability": "1.0", "pangoLEARN_version": "2021-02-06", "status": "passed_qc", "note": "", "Most common countries": "UK, USA, Australia", "Date range": "February-09, August-31", "Number of taxa": "2459", "Days since last sampling": "162"}
```
## Build container in registry
Tag and push
```
git tag v2.2.1
git push --tags
```

## Previous build was 2 stage
The original .gitlab-ci.yml for this 2 stage build can be found [here](https://gitlab.com/cgps/cog-uk/pangolin/-/blob/3cde9bc32a3995e523b2fb71b6d3c074efde4913/.gitlab-ci.yml)
The `.gitlab-ci.yml` has been updated to work with either build process by looking at the tag format: either `<PANGOLIN VERSION>` or `<PANGOLIN VERSION>_<PANGOLEARN VERSION>`

#### Command line build
1. build container. For example
  ```
  ./build.sh v2.0.7 2020-08-29
  ```
2. Test outputs
  ```
  cat test_files/bad_sequence.fasta | docker run  --rm -i registry.gitlab.com/cgps/cog-uk/pangolin:v2.0.7_2020-08-29
  {"taxon": "BC09.nanopolish-noindel/ARTIC/nanopolish_MN908947.3", "lineage": "None", "probability": "0", "pangoLEARN_version": "2020-08-29", "status": "fail", "note": "N_content:1.0"}
  cat test_files/good_sequence.fasta | docker run  --rm -i registry.gitlab.com/cgps/cog-uk/pangolin:v2.0.7_2020-08-29
  {"taxon": "hCoV-19/Scotland/CVR07/2020|EPI_ISL_415630", "lineage": "B.2.1", "probability": "1.0", "pangoLEARN_version": "2020-08-29", "status": "passed_qc", "note": "", "Most common countries": "UK, Australia, USA", "Date range": "February-09, July-20", "Number of taxa": "2157", "Days since last sampling": "57"}
  ```
3. Tag and push
  ```
  git tag v2.0.7_2020-08-29
  git push
  git push --tags
  ```