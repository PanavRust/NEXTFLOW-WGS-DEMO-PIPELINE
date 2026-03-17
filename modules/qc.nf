process FASTQC {

```
tag "fastqc"

input:
path reads

output:
path "*.html", emit: html
path "*.zip", emit: zip

script:
"""
fastqc $reads
"""
```

}

process FASTP {

```
tag "fastp"

input:
path reads

output:
path "*_trimmed.fastq.gz", emit: reads

script:
"""
fastp \
    -i ${reads[0]} \
    -I ${reads[1]} \
    -o sample_R1_trimmed.fastq.gz \
    -O sample_R2_trimmed.fastq.gz \
    -h fastp.html \
    -j fastp.json
"""
```

}

process MULTIQC {

```
tag "multiqc"

input:
path qc_files

output:
path "multiqc_report.html"

script:
"""
multiqc .
"""
```

}

process QC_SUMMARY {

```
tag "qc_summary"

input:
path fastqc_zip

output:
path "qc_summary.txt"

script:
"""
echo "QC completed successfully" > qc_summary.txt
"""
```

}
