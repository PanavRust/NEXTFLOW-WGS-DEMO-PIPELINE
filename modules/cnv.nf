process CNV_CALLING {

```
tag "cnv"

input:
path bam
val reference

output:
path "cnv.bed", emit: cnv
path "cnv_summary.txt", emit: summary

script:
"""
# Calculate coverage using mosdepth
mosdepth sample $bam

# Simple CNV detection (toy example)
zcat sample.regions.bed.gz | \
awk '{
    if ($4 < 10) print $1"\t"$2"\t"$3"\tDEL";
    else if ($4 > 60) print $1"\t"$2"\t"$3"\tDUP";
}' > cnv.bed

# Summary
echo "CNV calling completed" > cnv_summary.txt
"""
```

}

process COVERAGE {

```
tag "coverage"

input:
path bam

output:
path "coverage_summary.txt", emit: coverage

script:
"""
mosdepth coverage $bam

grep total coverage.mosdepth.summary.txt > coverage_summary.txt || echo "Coverage done" > coverage_summary.txt
"""
```

}
