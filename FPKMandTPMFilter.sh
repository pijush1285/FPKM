


grep 'TPM' C1_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/.*transcript_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#transcript_id\tTPM' > C1_RNA_H3CV5DSX2_L1_V1.tpm.txt




grep 'FPKM' C1_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > C1_RNA_H3CV5DSX2_L1_V2.fpkm.txt
grep 'TPM' C1_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > C1_RNA_H3CV5DSX2_L1_V1.tpm.txt


C2_RNA_H3CV5DSX2_L1_V1.FPKM.gtf


grep 'FPKM' C2_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > C2_RNA_H3CV5DSX2_L1_V1.fpkm.txt
grep 'TPM' C2_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > C2_RNA_H3CV5DSX2_L1_V1.tpm.txt


C3_RNA_H3CV5DSX2_L1_V1.FPKM.gtf


grep 'FPKM' C3_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > C3_RNA_H3CV5DSX2_L1_V1.fpkm.csv
grep 'TPM' C3_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > C3_RNA_H3CV5DSX2_L1_V1.tpm.txt



Con-Set-3_RNA_H3CV5DSX2_L1.FPKM.gtf


grep 'FPKM' Con-Set-3_RNA_H3CV5DSX2_L1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > Con-Set-3_RNA_H3CV5DSX2_L1_V1.fpkm.csv
grep 'TPM' Con-Set-3_RNA_H3CV5DSX2_L1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > Con-Set-3_RNA_H3CV5DSX2_L1_V1.tpm.csv


Con-Set-4_RNA_H3CV5DSX2_L1.FPKM.gtf

grep 'FPKM' Con-Set-4_RNA_H3CV5DSX2_L1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > Con-Set-4_RNA_H3CV5DSX2_L1_V1.fpkm.csv
grep 'TPM' Con-Set-4_RNA_H3CV5DSX2_L1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > Con-Set-4_RNA_H3CV5DSX2_L1_V1.tpm.csv


I1_RNA_H3CV5DSX2_L1_V1.FPKM.gtf

grep 'FPKM' I1_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > I1_RNA_H3CV5DSX2_L1_V1.fpkm.csv
grep 'TPM' I1_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > I1_RNA_H3CV5DSX2_L1_V1.tpm.csv


I2_RNA_H3CV5DSX2_L1_V1.FPKM.gtf

grep 'FPKM' I2_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > I2_RNA_H3CV5DSX2_L1_V1.fpkm.csv 
grep 'TPM' I2_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > I2_RNA_H3CV5DSX2_L1_V1.tpm.csv


I3_RNA_H3CV5DSX2_L1_V1.FPKM.gtf


grep 'FPKM' I3_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > I3_RNA_H3CV5DSX2_L1_V1.fpkm.csv
grep 'TPM' I3_RNA_H3CV5DSX2_L1_V1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > I3_RNA_H3CV5DSX2_L1_V1.tpm.csv


Sh123-Set3_RNA_H3CV5DSX2_L1.FPKM.gtf

grep 'FPKM' Sh123-Set3_RNA_H3CV5DSX2_L1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > Sh123-Set3_RNA_H3CV5DSX2_L1_V1.fpkm.csv
grep 'TPM' Sh123-Set3_RNA_H3CV5DSX2_L1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > Sh123-Set3_RNA_H3CV5DSX2_L1_V1.tpm.csv


Sh123-Set4_RNA_H3CV5DSX2_L1.FPKM.gtf

grep 'FPKM' Sh123-Set4_RNA_H3CV5DSX2_L1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*FPKM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tFPKM' > Sh123-Set4_RNA_H3CV5DSX2_L1_V1.fpkm.csv
grep 'TPM' Sh123-Set4_RNA_H3CV5DSX2_L1.FPKM.gtf | cut -f9 | sed -r 's/gene_id "([^"]*).*TPM "([^"]*).*/\1\t\2/g' | sed '1i#gene_id\tTPM' > Sh123-Set4_RNA_H3CV5DSX2_L1_V1.tpm.csv
