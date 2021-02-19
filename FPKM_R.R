library(countToFPKM)

file.readcounts <- system.file("extdata", "RNA-seq.read.counts.csv", package="countToFPKM")
file.annotations <- system.file("extdata", "Biomart.annotations.hg38.txt", package="countToFPKM")
file.sample.metrics <- system.file("extdata", "RNA-seq.samples.metrics.txt", package="countToFPKM")

# Import the read count matrix data into R.
counts <- as.matrix(read.csv(file.readcounts))

# Import feature annotations. 
# Assign feature lenght into a numeric vector.
gene.annotations <- read.table(file.annotations, sep="\t", header=TRUE)
featureLength <- gene.annotations$length

# Import sample metrics. 
# Assign mean fragment length into a numeric vector.
samples.metrics <- read.table(file.sample.metrics, sep="\t", header=TRUE)
meanFragmentLength <- samples.metrics$meanFragmentLength

# Return FPKM into a numeric matrix.
fpkm_matrix <- fpkm (counts, featureLength, meanFragmentLength)

# Plot log10(FPKM+1) heatmap of top 30 highly variable features
fpkmheatmap(fpkm_matrix, topvar=30, showfeaturenames=TRUE, return_log = TRUE)





######################################################################################3

library("countToFPKM")
library("biomaRt")
library("dplyr")

## Import feature counts matrix
file.readcounts <- system.file("extdata", "RNA-seq.read.counts.csv", package="countToFPKM")
counts <- as.matrix(read.csv(file.readcounts))

## Build a biomart query 
# In the example below, I use the human gene annotation from Ensembl release 82 located on "sep2015.archive.ensembl.org"
# More about the ensembl_build can be found on "http://www.ensembl.org/info/website/archives/index.html"

ens_build = "sep2015"
dataset="hsapiens_gene_ensembl"
mart = biomaRt::useMart("ENSEMBL_MART_ENSEMBL", dataset = dataset, 
                        host = paste0(ens_build, ".archive.ensembl.org"), path = "/biomart/martservice", archive = FALSE)

gene.annotations <- biomaRt::getBM(mart = mart, attributes=c("ensembl_gene_id", "external_gene_name", "start_position", "end_position"))
gene.annotations <- dplyr::transmute(gene.annotations, external_gene_name,  ensembl_gene_id, length = end_position - start_position)

# Filter and re-order gene.annotations to match the order in feature counts matrix
gene.annotations <- gene.annotations %>% dplyr::filter(ensembl_gene_id %in% rownames(counts))
gene.annotations <- gene.annotations[order(match(gene.annotations$ensembl_gene_id, rownames(counts))),]

# Assign feature lenghts into a numeric vector.
featureLength <- gene.annotations$length