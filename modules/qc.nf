process QC {

    input:
    path reads

    output:
    path "qc_results"

    script:
    """
    fastqc $reads -o qc_results
    """
}
