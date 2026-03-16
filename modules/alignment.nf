process ALIGNMENT {

    input:
    path reads

    output:
    path "aligned.bam"

    script:
    """
    bwa mem reference.fa $reads | samtools view -Sb - > aligned.bam
    """
}
