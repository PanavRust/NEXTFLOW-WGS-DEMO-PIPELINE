process GATK_HAPLOTYPECALLER {

```
tag "haplotypecaller"

input:
path bam
val reference

output:
path "raw_variants.vcf.gz", emit: vcf

script:
"""
gatk HaplotypeCaller \
    -R $reference \
    -I $bam \
    -O raw_variants.vcf.gz
"""
```

}

process VARIANT_FILTER {

```
tag "variant_filter"

input:
path vcf
val reference

output:
path "filtered_variants.vcf.gz", emit: vcf

script:
"""
gatk VariantFiltration \
    -R $reference \
    -V $vcf \
    --filter-expression "QD < 2.0" \
    --filter-name "LowQD" \
    -O filtered_variants.vcf.gz
"""
```

}
