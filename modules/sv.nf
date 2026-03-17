process MANTA_SV {

```
tag "manta"

input:
path bam
val reference

output:
path "manta.vcf.gz", emit: vcf

script:
"""
configManta.py \
    --bam $bam \
    --referenceFasta $reference \
    --runDir manta_run

manta_run/runWorkflow.py -j 2

cp manta_run/results/variants/diploidSV.vcf.gz manta.vcf.gz
"""
```

}

process DELLY_SV {

```
tag "delly"

input:
path bam
val reference

output:
path "delly.vcf.gz", emit: vcf

script:
"""
delly call \
    -g $reference \
    -o delly.bcf \
    $bam

bcftools view delly.bcf -Oz -o delly.vcf.gz
"""
```

}

process SV_MERGE {

```
tag "sv_merge"

input:
path manta_vcf
path delly_vcf

output:
path "merged_sv.vcf.gz", emit: vcf

script:
"""
bcftools concat -a \
    -O z \
    -o merged_sv.vcf.gz \
    $manta_vcf $delly_vcf
"""
```

}
