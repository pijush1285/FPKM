#!/bin/bash

#Reference genome and the gtf files were downloaded from the link given below.
#https://hgdownload.soe.ucsc.edu/downloads.html#human

for L in 1 2 3 4 5 6 7 8 9
do

  if [ $L == 1 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/G240
      echo "1st Sample set is choosen."
  fi
  if [ $L == 2 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/HD24
      echo "2nd Sample set is choosen."
  fi
  if [ $L == 3 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/HP24
      echo "3rd Sample set is choosen."
  fi
  if [ $L == 4 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/MK1E
      echo "4th Sample set is choosen."
  fi
  if [ $L == 5 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/MK2U
      echo "5th Sample set is choosen."
  fi
  if [ $L == 6 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/MK3K
      echo "6th Sample set is choosen."
  fi
  if [ $L == 7 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/MK4D
      echo "7th Sample set is choosen."
  fi
  if [ $L == 8 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/MKP2
      echo "8th Sample set is choosen."
  fi
  if [ $L == 9 ]
  then
      #File input_fileLocation
      input_fileLocation=/data/sata_data/workshop/wsu28/IICB/RawData/MKP5
      echo "9th Sample set is choosen."
  fi



#Output results location. This location is used for Gh19
output_resultLocation=/data/sata_data/workshop/wsu28/IICB/resultHg19
#Output results location. This location is used for Gh38
#output_resultLocation=/data/sata_data/workshop/wsu28/IICB/results


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
r3=${array[2]}
r4=${array[3]}

echo $r1
echo $r2
echo $r3
echo $r4

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
ref=/data/sata_data/workshop/wsu28/IICB/references/hg19/hisat2_index
#Reference file location. This link  is for ref Hg38.
#ref=/data/sata_data/workshop/wsu28/IICB/references/hg38/hisat2_index

# Build index for the reference file
#conda activate /data/sata_data/workshop/wsu28/anaconda3/envs/pdas
#hisat2-build -f -p 25 /data/sata_data/workshop/wsu28/IICB/references/hg38/refHg38/hg38.fa hg38
#hisat2-build -f -p 50 /data/sata_data/workshop/wsu28/IICB/references/hg19/refHg19/hg19.fa hg19

#Mapping
hisat2 -q -p 50 -x $ref/hg19 -1 $r1 -2 $r2 -S "$prefix"_L3.sam
#hisat2 -q -p 50 -x $ref/hg38 -1 $r1 -2 $r2 -S "$prefix"_L3.sam
echo "Mapping L3 R1 and R2 is completed"
hisat2 -q -p 50 -x $ref/hg19 -1 $r3 -2 $r4 -S "$prefix"_L4.sam
#hisat2 -q -p 50 -x $ref/hg38 -1 $r3 -2 $r4 -S "$prefix"_L4.sam
echo "Mapping L4 R1 and R2 is completed"


samtools view -@ 50 -bS "$prefix"_L3.sam | samtools sort -@ 50 -o "$prefix"_L3.sorted.bam
samtools view -@ 50 -bS "$prefix"_L4.sam | samtools sort -@ 50 -o "$prefix"_L4.sorted.bam


samtools merge -@ 50 "$prefix"_merged.sorted.bam "$prefix"_L3.sorted.bam "$prefix"_L4.sorted.bam -O BAM


#For installing the cufflink package please follow the code given below.
#conda install -c conda-forge python-cufflinks
gtf=/data/sata_data/workshop/wsu28/IICB/references/hg19/gtfs/hg19.knownGene.gtf
#gtf=/data/sata_data/workshop/wsu28/IICB/references/hg38/gtfs/hg38.knownGene.gtf

#Using multiple core to make the preocess fasster.
cufflinks "$prefix"_merged.sorted.bam -p 50 -G $gtf -o result

done
