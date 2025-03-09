# Trim Galore

## Changes to this fork
The original Trim Galore perl script used open3 to parse the cutadapt results line by line and compare them to the original to see which reads had been trimmed. open3 returns 3 fh, one to stdin, stdout and stdin and then runs in the background. The stdin one is closed, and the stderr one is used after processing to write to the final trim report. The management of the 3 threads can result in blocking behavior - it looks like it happens at the end of a file when one of the buffers does not flush and hangs. This is more pronounced when there is latency, such as in Docker mounts or when there are multiple buffers using a slow disk in parallel with many threads. The solution was to replace open3 with a simple open to process the cutadapt output and redirect stderr to a temp_file to be read later. This is a much simpler and robust buffer setup and solves the problem of hangs even with multi-threaded pigz. Note that trying to use buffer utilities such as mbuffer to reduce latency of the compression writes makes things worse and causes things to hang again, even when single threaded.


_Trim Galore_ is a wrapper around [Cutadapt](https://github.com/marcelm/cutadapt) and [FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to consistently apply adapter and quality trimming to FastQ files, with extra functionality for RRBS data.

[![DOI](https://zenodo.org/badge/62039322.svg)](https://zenodo.org/badge/latestdoi/62039322)
[![Build Status](https://travis-ci.org/FelixKrueger/TrimGalore.svg?branch=master)](https://travis-ci.org/FelixKrueger/TrimGalore)
[![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](https://bioconda.github.io/recipes/trim-galore/README.html)
[![container ready](https://quay.io/repository/biocontainers/trim-galore/status)](https://quay.io/repository/biocontainers/trim-galore)


## Installation
_Trim Galore_ is a a Perl wrapper around two tools: [Cutadapt](https://github.com/marcelm/cutadapt) and [FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/). To use, ensure that these two pieces of software are available and copy the `trim_galore` script to a location available on the `PATH`.

For example:
```bash
# Check that cutadapt is installed
cutadapt --version
# Check that FastQC is installed
fastqc -v
# Install Trim Galore
curl -fsSL https://github.com/FelixKrueger/TrimGalore/archive/0.6.10.tar.gz -o trim_galore.tar.gz
tar xvzf trim_galore.tar.gz
# Run Trim Galore
~/TrimGalore-0.6.10/trim_galore
```

If you are using Bioconda:
```
conda install trim-galore
```

## Documentation
For instructions on how to use _Trim Galore_, please see the [User Guide](Docs/Trim_Galore_User_Guide.md).

## Credits
_Trim Galore_ was developed at The Babraham Institute by [@FelixKrueger](https://github.com/FelixKrueger/), now part of [Altos Labs](https://altoslabs.com/).
