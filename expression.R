# 6-3-2024 
# Manipulation of gene expression data (Breast cancer data of humans, RNA-seq data)
# setwd("C:/Users/salon/OneDrive/Desktop/Gene expression")

# Loading the libraries
library(dplyr)
library(tidyverse)
BiocManager::install('GEOquery')
library(GEOquery)

# Read the data 'GSE183947_fpkm.csv'
dat <- read.csv(file = 'GSE183947_fpkm.csv')
dim(dat)

# Obtaining metadata
gse <- getGEO(GEO = 'GSE183947', GSEMatrix = TRUE)
gse

metadata <- pData(phenoData(gse[[1]]))
head(metadata)

# metadata_subset <- select(metadata, c(1,10,11,17))
# Using pipe operation (%>%) to reduce the number of variables in data manipulation

metadata_modified <- metadata %>%
  select(1,10,11,17) %>%
  rename(tissue = characteristics_ch1, metastasis = characteristics_ch1.1) %>%
  mutate(tissue = gsub("tissue: ", "", tissue)) %>%
  mutate(metastasis = gsub("metastasis: ", "", metastasis)) 

# Reshaping data
dat_long <- dat %>%
  rename(gene = X) %>%
  gather(key = "samples", value = "FPKM", -gene) #gather convert wide format data (i.e. dat) to
                                                 #long format data (dat_long)

# Joining dataframes (dat_long and metadata_modified)
dat_long <- dat_long %>%
  left_join(., metadata_modified, by = c("samples" = "description"))

# Saving the output in tab delimited format
write.table(dat_long, file = 'GSE183947_long_format.txt' , sep ='\t', row.names = FALSE)

# Data Exploration
dat_long %>%
  filter(gene == 'BRCA1'| gene == 'BRCA2') %>%
  group_by(gene,tissue) %>%
  summarise(mean_FPKM = mean(FPKM),
            median_FPKM = median(FPKM),
            std_FPKM = sd(FPKM)) %>%
  arrange(mean_FPKM)  #ascending order 

#for descending order: arrange(-mean(FPKM))
# The output shows that BRCA1 is highly expressed in both the normal as well as breast tumor tissues 
# compared to BRCA2.





  
  
