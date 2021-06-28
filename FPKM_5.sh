#!/bin/bash

#Reference genome and the gtf files were downloaded from the link given below.
#https://hgdownload.soe.ucsc.edu/downloads.html#human

for L in 1 2 3 4 5 6 7 8 9 10
do

  if [ $L == 1 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/C1
      echo "1st Sample set is choosen."
  fi
  if [ $L == 2 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/C2
      echo "2nd Sample set is choosen."
  fi
  if [ $L == 3 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/C3
      echo "3rd Sample set is choosen."
  fi
  if [ $L == 4 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/Con-Set-3
      echo "4th Sample set is choosen."
  fi
  if [ $L == 5 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/Con-Set-4
      echo "5th Sample set is choosen."
  fi
  if [ $L == 6 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/I1
      echo "6th Sample set is choosen."
  fi
  if [ $L == 7 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/I2
      echo "7th Sample set is choosen."
  fi
  if [ $L == 8 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/I3
      echo "8th Sample set is choosen."
  fi
  if [ $L == 9 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/Sh123-Set3
      echo "9th Sample set is choosen."
  fi
  if [ $L == 10 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/R.Ain_IICB_RNA/Sh123-Set4
      echo "10th Sample set is choosen."
  fi





#Output results location.
output_resultLocation=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/mapping_result



##################################################################################

count=0
for entry in "$input_fileLocation"/*.gz
do
  echo "$entry"
  array[$count]="$entry"
  count=$(($count+1))
  echo $count
done


r1=${array[0]}
r2=${array[1]}


echo $r1
echo $r2


#####################################################################################

word=$(awk -F/ '{print $9}' <<< "${array[0]}")
echo $word
prefix=$(awk -F_ '{print $1}' <<< "${word}")_$(awk -F_ '{print $2}' <<< "${word}")
echo $prefix
nDir=$(awk -F_ '{print $1}' <<< "${word}")
echo $nDir

#Create a new Directory in the result folder
mkdir $output_resultLocation/$nDir
echo "Directory created:"
cd $output_resultLocation/$nDir
echo "Directory changed:"

#Reference file location. This link  is for ref Hg19.
ref=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/reference/ensamble/ref
#Reference file location. This link  is for ref Hg38.
#ref=/data/sata_data/workshop/wsu28/IICB/references/hg38/hisat2_index

# Build index for the reference file
#conda activate /data/sata_data/workshop/wsu28/anaconda3/envs/pdas
#hisat2-build -f -p 25 /data/sata_data/workshop/wsu28/IICB/references/hg38/refHg38/hg38.fa hg38
#hisat2-build -f -p 50 /data/sata_data/workshop/wsu28/IICB/references/hg19/refHg19/hg19.fa hg19

#Mapping
hisat2 -q -p 25 -x $ref/Rattus -1 $r1 -2 $r2 -S "$prefix"RNA_H3CV5DSX2_L1.sam
#hisat2 -q -p 50 -x $ref/hg38 -1 $r1 -2 $r2 -S "$prefix"_L3.sam
echo "Mapping L1 R1 and R2 is completed"



samtools view -@ 25 -bS "$prefix"RNA_H3CV5DSX2_L1.sam | samtools sort -@ 25 -o "$prefix"RNA_H3CV5DSX2_L1.sorted.bam
echo "Sort bam is completed"



#For installing the cufflink package please follow the code given below.
#conda install -c conda-forge python-cufflinks
gtf=/data/sata_data/workshop/wsu28/NGC/043-092_20-21_WTS_NS/reference/ensamble/gtf/Rattus_norvegicus.Rnor_6.0.104.gtf
#gtf=/data/sata_data/workshop/wsu28/IICB/references/hg38/gtfs/hg38.knownGene.gtf


#For counting thereads
featureCounts -T 25 -p -a $gtf -t gene -g gene_id -o "$prefix"count.txt "$prefix"RNA_H3CV5DSX2_L1.sorted.bam
echo "Feature count is completed"


#Using multiple core to make the preocess fasster.
#cufflinks "$prefix"RNA_H3CV5DSX2_L1.sorted.bam -p 25 -G $gtf -o result --library-type fr-firststrand
#echo "Cuffloink task is completed"

#stringtie is using expecting the process will be fast
stringtie "$prefix"RNA_H3CV5DSX2_L1.sorted.bam -p 25 -G $gtf -o "$prefix"_RNA_H3CV5DSX2_L1.FPKM.gtf
echo "stringtie task is completed"

done
