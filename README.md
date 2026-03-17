![Nextflow](https://img.shields.io/badge/Nextflow-DL2-brightgreen)
![Pipeline](https://img.shields.io/badge/WGS-Pipeline-blue)
![Status](https://img.shields.io/badge/status-active-success)



# 🧬 Nextflow WGS Demo Pipeline

## 📌 Overview

This repository contains a modular and reproducible bioinformatics pipeline for analyzing Whole Genome Sequencing (WGS) data using Nextflow.

The pipeline demonstrates an end-to-end genomic workflow including quality control, alignment, variant calling, structural variant detection, copy number analysis, and variant annotation.

This project is designed as a portfolio-ready implementation inspired by real-world bioinformatics pipelines used in research and clinical genomics.

---

## ⚙️ Pipeline Workflow

```
FASTQ
 ↓
Quality Control (FastQC, Fastp, MultiQC)
 ↓
Alignment (BWA-MEM)
 ↓
Sorting & Processing (SAMtools)
 ↓
Variant Calling (GATK HaplotypeCaller)
 ↓
Variant Filtering
 ↓
Structural Variant Calling (Manta, Delly)
 ↓
SV Merging
 ↓
Copy Number Variation (CNV) Analysis
 ↓
Coverage Analysis
 ↓
Variant Annotation (VEP, ClinVar)
```

---

## 🧩 Pipeline Architecture

The pipeline is implemented using Nextflow DSL2 and follows a modular design:

```
NEXTFLOW-WGS-DEMO-PIPELINE
│
├── main.nf
├── nextflow.config
│
├── modules
│   ├── qc.nf
│   ├── alignment.nf
│   ├── variant_calling.nf
│   ├── sv.nf
│   ├── cnv.nf
│   └── annotation.nf
```

Each module represents a distinct step in the WGS workflow, enabling scalability and reproducibility.

---

## 🛠️ Tools & Technologies

* Nextflow (DSL2)
* FastQC
* fastp
* MultiQC
* BWA-MEM
* SAMtools
* GATK
* Manta
* Delly
* mosdepth
* VEP
* bcftools
* Bash / Linux

---

## ▶️ Running the Pipeline

```bash
nextflow run main.nf \
    --input "data/*.fastq" \
    --reference reference.fa \
    --outdir results/
```

---

## 📊 Outputs

The pipeline generates:

* QC reports (FastQC, MultiQC)
* Aligned BAM files
* Variant files (VCF)
* Structural variant outputs
* CNV results
* Annotated variants (VEP, ClinVar)
* Coverage summaries

---

## 🎯 Skills Demonstrated

* Workflow management using Nextflow DSL2
* Development of modular bioinformatics pipelines
* Handling and processing NGS datasets
* Integration of multiple genomic analysis tools
* Reproducible and scalable pipeline design
* Understanding of WGS analysis workflows

---

## ⚠️ Disclaimer

This pipeline is a simplified educational implementation inspired by real-world bioinformatics workflows.
It is intended for demonstration and learning purposes only and is not designed for clinical use.

---

## 👨‍💻 Author

**Panav Rustagi**
Bioinformatics Graduate – University of Bristol
Experience in genomic data analysis and NGS pipelines
