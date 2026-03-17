process VEP_ANNOTATION {

```
tag "vep"

input:
path vcf

output:
path "vep_annotated.vcf.gz", emit: vcf

script:
"""
vep \
    --input_file $vcf \
    --output_file vep_annotated.vcf \
    --vcf \
    --force_overwrite

bgzip vep_annotated.vcf
tabix -p vcf vep_annotated.vcf.gz
"""
```

}

process CLINVAR_ANNOTATION {

```
tag "clinvar"

input:
path vcf

output:
path "clinvar_annotated.vcf.gz", emit: vcf

script:
"""
# Example ClinVar annotation (requires clinvar.vcf.gz locally)

bcftools annotate \
    -a clinvar.vcf.gz \
    -c INFO/CLNSIG,INFO/CLNDN \
    -O z \
    -o clinvar_annotated.vcf.gz \
    $vcf

tabix -p vcf clinvar_annotated.vcf.gz
"""
```

}
