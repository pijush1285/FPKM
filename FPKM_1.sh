

#!/bin/bash

#Reference genome and the gtf files were downloaded from the link given below.
#https://hgdownload.soe.ucsc.edu/downloads.html#human

# Build index for the reference file
conda activate /data/sata_data/workshop/wsu28/anaconda3/envs/pdas
hisat2-build -f -p 25 /data/sata_data/workshop/wsu28/IICB/references/hg38/refHg38/hg38.fa hg38

ref=/data/sata_data/workshop/wsu28/IICB/references/hg38/hisat2_index
r1=/data/sata_data/workshop/wsu28/IICB/RawData/G240/G240_TruseqStranded_HFGYGDSXY_L3_R1.fastq.gz
r2=/data/sata_data/workshop/wsu28/IICB/RawData/G240/G240_TruseqStranded_HFGYGDSXY_L3_R2.fastq.gz

hisat2 -q -p 25 -x $ref/hg38 -1 $r1 -2 $r2 -S G240_TruseqStranded_HFGYGDSXY_L3.sam

r3=/data/sata_data/workshop/wsu28/IICB/RawData/G240/G240_TruseqStranded_HFGYGDSXY_L4_R1.fastq.gz
r4=/data/sata_data/workshop/wsu28/IICB/RawData/G240/G240_TruseqStranded_HFGYGDSXY_L4_R2.fastq.gz

hisat2 -q -p 25 -x $ref/hg38 -1 $r3 -2 $r4 -S G240_TruseqStranded_HFGYGDSXY_L4.sam



samtools view -@ 25 -bS G240_TruseqStranded_HFGYGDSXY_L3.sam | samtools sort -@ 25 -o G240_TruseqStranded_HFGYGDSXY_L3.sorted.bam
samtools view -@ 25 -bS G240_TruseqStranded_HFGYGDSXY_L4.sam | samtools sort -@ 25 -o G240_TruseqStranded_HFGYGDSXY_L4.sorted.bam


samtools merge -@ 25 G240_TruseqStranded_merged.sorted.bam G240_TruseqStranded_HFGYGDSXY_L3.sorted.bam G240_TruseqStranded_HFGYGDSXY_L4.sorted.bam -O BAM


#For installing the cufflink package please follow the code given below.
#conda install -c conda-forge python-cufflinks

gtf=/data/sata_data/workshop/wsu28/IICB/references/hg38/gtfs/hg38.knownGene.gtf
cufflinks G240_TruseqStranded_merged.sorted.bam -G $gtf -o result
#Cuffloink is taking Huge time.

#Using multiple core to make the preocess fasster.
cufflinks G240_TruseqStranded_merged.sorted.bam -p 50 -G $gtf -o result1

###########################################################################################################
#
#Other pipeline is given below.
#First it is required to calculate the reads and after that R package is used to calculate the
#FPKM values.
#
###########################################################################################################

# I do not know why the gtf file is not wworking here ..
gtfip=/data/sata_data/workshop/wsu28/IICB/references/hg38/gtfs/hg38.knownGene.gtf
featureCounts -T 10 -p -a $gtfip -t gene -g gene_id -o G240_count.txt G240_TruseqStranded_merged.sorted.bam


gtfip=/data/sata_data/workshop/wsu28/Hg38gtf
featureCounts -T 10 -p -a $gtfip/Homo_sapiens.GRCh38.102.gtf -t gene -g gene_id -o G240_count.txt G240_TruseqStranded_merged.sorted.bam




gtfip=/data/sata_data/workshop/wsu28/IICB/references/hg38/gtfs_ensembl2020
featureCounts -T 10 -p -a $gtfip/Homo_sapiens.GRCh38.100.gtf -t gene -g gene_id -o G240_count_100.gtf.txt G240_TruseqStranded_merged.sorted.bam


gtfip=/data/sata_data/workshop/wsu28/IICB/references/hg38/gtfs_ensembl_102
featureCounts -T 10 -p -a $gtfip/Homo_sapiens.GRCh38.102.gtf -t gene -g gene_id -o G240_count_102.gtf.txt G240_TruseqStranded_merged.sorted.bam


picard CollectInsertSizeMetrics \
      I=G240_TruseqStranded_merged.sorted.bam \
      O=insert_size_metrics.txt \
      H=insert_size_histogram.pdf \
      M=0.5

#library("countToFPKM")
p<-read.table("G240_count.txt", header=TRUE)
head(p)
head(p$G240_TruseqStranded_merged.sorted.bam)

#This feature length calculation is wrong. There we require to use the biomaRt package.
#This is going to be another level of difficulties. So cufflink is better.
featureLength<-length(p$G240_TruseqStranded_merged.sorted.bam)


featureCounts -O -t gene -g ID -a $gtfip/Homo_sapiens.GRCh38.102.chr.gff3 -o counts.txt pat014_B_TruSeq.bam

featureCounts -p -a $gtfip/Homo_sapiens.GRCh38.102.chr.gff3 -t gene -g ID -o countsNew.txt pat014_B_TruSeq.bam

# GTF file also can be processed see the syntax of the script
#https://bioconductor.org/packages/release/bioc/vignettes/Rsubread/inst/doc/SubreadUsersGuide.pdf
#Page 46
featureCounts -p -a $gtfip/Homo_sapiens.GRCh38.102.chr.gtf -t gene -g gene_id -o countsNew2.txt pat014_B_TruSeq.bam

featureCounts -T 10 -p -a $gtfip/Homo_sapiens.GRCh38.102.gtf -t gene -g gene_id -o countsNew5.txt pat014_B_TruSeq.bam
