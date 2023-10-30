# Build instructions

## Command line test

#### Specify pangolin and pangoLEARN versions in .env file

For example
```
PANGOLIN_VERSION=v4.0.6
PANGOLIN_DATA_VERSION=v1.9
```

#### Update CHANGELOG.md 

Update the [`CHANGELOG.md`](CHANGELOG.md) file with the changes according to the instructions in the file

#### Build Docker image
Note that this will always build the most up-to-date version. The supplied environment variables are ignored.
```
bash build.sh v3.0.0
```

#### Test

```
cat test_files/good_sequence.fasta | docker run --rm -i registry.gitlab.com/cgps/cog-uk/pangolin:v3.0.0
{"taxon": "hCoV-19/Scotland/CVR07/2020|EPI_ISL_415630", "lineage": "B.40", "conflict": "0.0", "pangolin_version": "v.2.4.2", "pangoLEARN_version": "2021-04-28", "pango_version": "1.1.23", "status": "passed_qc", "note": "", "Most common countries": "UK, USA, Australia", "Date range": "February-21, August-31", "Number of taxa": "1565", "Days since last sampling": "252"}
```
NB: Check that the output versions for pangolin and pangolin_data are correct.

## Build container in registry
Tag and push
```
git tag -a v17.0.0 -m 'Updating to version v17.0.0'
git push --follow-tags
```