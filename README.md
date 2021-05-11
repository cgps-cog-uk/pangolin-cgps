# Build instructions

## Command line test

#### Specify pangolin and pangoLEARN versions in .env file

For example
```
PANGOLIN_VERSION=v.2.4.2
PANGOLEARN_VERSION=2021-04-28
```

#### Update CHANGELOG.md 

Update the [`CHANGELOG.md`](CHANGELOG.md) file with the changes according to the instructions in the file

#### Build Docker image

```
./build.sh v3.0.0
```

#### Test

```
cat test_files/good_sequence.fasta | docker run --rm -i registry.gitlab.com/cgps/cog-uk/pangolin:v3.0.0
{"taxon": "hCoV-19/Scotland/CVR07/2020|EPI_ISL_415630", "lineage": "B.40", "conflict": "0.0", "pangolin_version": "v.2.4.2", "pangoLEARN_version": "2021-04-28", "pango_version": "1.1.23", "status": "passed_qc", "note": "", "Most common countries": "UK, USA, Australia", "Date range": "February-21, August-31", "Number of taxa": "1565", "Days since last sampling": "252"}
```
## Build container in registry
Tag and push
```
git commit -am 'Updating to version v3.0.0'
git tag v3.0.0
git push
git push --tags
```