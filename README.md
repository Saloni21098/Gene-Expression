# Gene-Expression
This repository contains two R scripts that performs data manipulation of gene expression data. The first script works with the GSE183947_fpkm.csv for data manipulation and the second script works with GSE183947_long_format.txt for data visualization.

## Requirements
- R version 4.2.1
    
## Data manipulation
Libraries: dplyr, tidyverse, GEOquery
1. The data is obtained from GEO database of NCBI (GSE183947_fpkm.csv).
2. The metadat is obtained and modified.
3. The wide-format data is converted to long-format data.
4. Data is explored.

Conclusion: BRCA1 is highly expressed in both the normal as well as breast tumor tissues compared to BRCA2.

## Data visualization 
Libraries: ggplot2, tidyverse, GGally
1. The log-format data is used for visualization purpose.
2. Plots used:
   a. Barplot: Shows the expression of FPKM in the normal as well as breast tumor tissue of BRCA1 and BRCA2 genes.
      BRCA1 has high expression in both the normal as well as breast tumor tissues compared to BRCA2.
   
   b. Density plot: Compares the distribution of FPKM expression in the two tissue types of BRCA1 and BRCA2 gene.
      Majority of the breast tissues from the normal as well as tumor of BRCA1 gene have expression between 0-10 FPKM and BRCA2 gene have expression between 0-5         FPKM.
      The BRCA1 gene shows a slightly higher density in normal tissue compared to tumor tissue, indicating a potential difference in expression levels                   between these tissue types.
      The BRCA2 gene exhibits a more significant difference in density between normal and tumor tissues, with a notably higher density in normal tissue,                 suggesting a distinct expression pattern for this gene in different tissue types.
   
   c. Box plot: Compares the expression between two metastasis group of BRCA1 as well as BRCA2 genes.
      BRCA1 and BRCA2 expression is lower in the samples with no metastasis compared to that with metastasis.
      This boxplot likely shows inverse correlation, where higher BRCA1/BRCA2 expression is associated with a greater chance of metastasis.
      BRCA1 and BRCA2 are tumor suppressor genes, and mutations in these genes are known to be linked to increased cancer risk.

   d. Scatter plot: Shows the correlation between BRCA1 and BRCA2 genes across normal breast tissue and breast tumor tissue in various samples.
      The two variable BRCA1 and BRCA2 have a weak, positive correlation with each other.
      The breast tumor tissues have a weak negative correlation while the normal breast tissue have a strong positive correlation.
   
   e. Heatmap: Compares the expression of multiple genes across various samples.
      Expression order of the gene of interest: JUN > TP53 > RAD52 > BRCA1 > CFTR > BRCA2 > MYCN


