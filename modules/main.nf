#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// -----------------------------
// Pipeline Info
// -----------------------------
version = "1.0.0"

params.input     = params.input ?: "data/*.fastq"
params.outdir    = params.outdir ?: "./results"
params.reference = params.reference ?: "reference.fa"

// -----------------------------
// Pretty Banner
// -----------------------------
log.info """
╔══════════════════════════════════════════════════════╗
║        Nextflow WGS Demo Pipeline                   ║
║                 Version ${version}                     ║
╠══════════════════════════════════════════════════════╣
║  Input:      ${params.input}
║  Output:     ${params.outdir}
║  Reference:  ${params.reference}
╚══════════════════════════════════════════════════════╝
"""

// -----------------------------
// Include Modules
// -----------------------------

include { DATA_INGESTION }     from './modules/data_ingestion'
include { FASTQC; FASTP; MULTIQC; QC_SUMMARY } from './modules/qc'
include { BWA_MEM; SAMTOOLS_SORT } from './modules/alignment'
include { GATK_HAPLOTYPECALLER; VARIANT_FILTER } from './modules/variant_calling'
include { MANTA_SV; DELLY_SV; SV_MERGE } from './modules/sv'
include { CNV_CALLING } from './modules/cnv'
include { VEP_ANNOTATION; CLINVAR_ANNOTATION } from './modules/annotation'
include { COVERAGE } from './modules/report'

// -----------------------------
// Workflow
// -----------------------------

workflow {

```
// INPUT
reads = Channel.fromPath(params.input)

// -------------------------
// 1. Data Ingestion
// -------------------------
DATA_INGESTION(reads)

// -------------------------
// 2. QC
// -------------------------
FASTQC(DATA_INGESTION.out)
FASTP(DATA_INGESTION.out)
MULTIQC(FASTQC.out)
QC_SUMMARY(FASTQC.out)

// -------------------------
// 3. Alignment
// -------------------------
BWA_MEM(FASTP.out, params.reference)
SAMTOOLS_SORT(BWA_MEM.out)

// -------------------------
// 4. Variant Calling
// -------------------------
GATK_HAPLOTYPECALLER(SAMTOOLS_SORT.out, params.reference)
VARIANT_FILTER(GATK_HAPLOTYPECALLER.out, params.reference)

// -------------------------
// 5. Structural Variants
// -------------------------
MANTA_SV(SAMTOOLS_SORT.out, params.reference)
DELLY_SV(SAMTOOLS_SORT.out, params.reference)
SV_MERGE(MANTA_SV.out, DELLY_SV.out)

// -------------------------
// 6. CNV
// -------------------------
CNV_CALLING(SAMTOOLS_SORT.out, params.reference)

// -------------------------
// 7. Annotation
// -------------------------
VEP_ANNOTATION(VARIANT_FILTER.out)
CLINVAR_ANNOTATION(VEP_ANNOTATION.out)

// -------------------------
// 8. Coverage / Report
// -------------------------
COVERAGE(SAMTOOLS_SORT.out)
```

}

// -----------------------------
// Completion Message
// -----------------------------
workflow.onComplete {
log.info """
╔══════════════════════════════════════════════════════╗
║            Pipeline Execution Complete              ║
╠══════════════════════════════════════════════════════╣
║  Status:    ${workflow.success ? 'SUCCESS' : 'FAILED'}
║  Duration:  ${workflow.duration}
║  Output:    ${params.outdir}
╚══════════════════════════════════════════════════════╝
"""
}

workflow.onError {
log.error "Pipeline failed: ${workflow.errorMessage}"
}

