include { QC } from './modules/qc'
include { ALIGNMENT } from './modules/alignment'

workflow {

    reads = Channel.fromPath("data/*.fastq")

    QC(reads)
    ALIGNMENT(reads)

}
