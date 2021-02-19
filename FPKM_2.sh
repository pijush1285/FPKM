#!/bin/bash

#Reference genome and the gtf files were downloaded from the link given below.
#https://hgdownload.soe.ucsc.edu/downloads.html#human

#File input_fileLocation
input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/HD24

#File names
r1=HD24_TruseqStranded_HFGYGDSXY_L3_R1.fastq.gz
r2=HD24_TruseqStranded_HFGYGDSXY_L3_R2.fastq.gz

r3=HD24_TruseqStranded_HFGYGDSXY_L4_R1.fastq.gz
r4=HD24_TruseqStranded_HFGYGDSXY_L4_R2.fastq.gz




#Output results location
output_resultLocation=/data/sata_data/workshop/wsu28/IICB/results/HD24


#prefix
prefix=HD24_TruseqStranded_HFGYGDSXY

#Reference file location
ref=/data/sata_data/workshop/wsu28/IICB/references/hg38/hisat2_index


# Build index for the reference file
#conda activate /data/sata_data/workshop/wsu28/anaconda3/envs/pdas
#hisat2-build -f -p 25 /data/sata_data/workshop/wsu28/IICB/references/hg38/refHg38/hg38.fa hg38


hisat2 -q -p 50 -x $ref/hg38 -1 $input_fileLocation/$r1 -2 $input_fileLocation/$r2 -S $output_resultLocation/"$prefix"_L3.sam
hisat2 -q -p 50 -x $ref/hg38 -1 $input_fileLocation/$r3 -2 $input_fileLocation/$r4 -S $output_resultLocation/"$prefix"_L4.sam



samtools view -@ 50 -bS $output_resultLocation/"$prefix"_L3.sam | samtools sort -@ 50 -o $output_resultLocation/"$prefix"_L3.sorted.bam
samtools view -@ 50 -bS $output_resultLocation/"$prefix"_L4.sam | samtools sort -@ 50 -o $output_resultLocation/"$prefix"_L4.sorted.bam


samtools merge -@ 50 $output_resultLocation/"$prefix"_merged.sorted.bam $output_resultLocation/"$prefix"_L3.sorted.bam $output_resultLocation/"$prefix"_L4.sorted.bam -O BAM


#For installing the cufflink package please follow the code given below.
#conda install -c conda-forge python-cufflinks

gtf=/data/sata_data/workshop/wsu28/IICB/references/hg38/gtfs/hg38.knownGene.gtf

#Using multiple core to make the preocess fasster.
#cufflinks $output_resultLocation/"$prefix"_merged.sorted.bam -p 50 -G $gtf -o $output_resultLocation/result1
cufflinks $output_resultLocation/"$prefix"_merged.sorted.bam -p 50 -G $gtf -o result

#cufflinks G240_TruseqStranded_merged.sorted.bam -G $gtf -o result
#cufflinks G240_TruseqStranded_merged.sorted.bam -p 50 -G $gtf -o result1
