process BWA_MEM {

```
tag "bwa_mem"

input:
path reads
val reference

output:
path "aligned.sam", emit: sam

script:
"""
bwa mem $reference ${reads[0]} ${reads[1]} > aligned.sam
"""
```

}

process SAMTOOLS_SORT {

```
tag "samtools_sort"

input:
path sam

output:
path "sorted.bam", emit: bam

script:
"""
samtools view -Sb $sam | samtools sort -o sorted.bam
"""
```

}
