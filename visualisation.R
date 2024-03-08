# 7-3-24
# Visualization of gene expression data (GSE183947)
# setwd("C:/Users/salon/OneDrive/Desktop/Gene expression")

# loading libraries
library(ggplot2)
library(tidyverse)

# Loading of data
# dat_long data to be used which is generated in the script expression.R and 
# saved as a tsv file GSE183947_long_format.txt

new_data <- read.table(file = "GSE183947_long_format.txt", header = TRUE)

# Basic format for ggplot
# ggplot(data, aes(x = variable name, y = variable name)) +
# geom_bar or geom_col or .......

# 1. Barplot (for different samples representing BRCA1 and BRCA2 gene expression)
plot <- new_data %>% 
  filter(gene == 'BRCA1' | gene == 'BRCA2') %>% 
  ggplot(., aes(x = samples, y = FPKM, fill = tissue)) +
  geom_bar(stat = 'identity', color = 'black', size = 0.1) +
  facet_wrap(~gene, ncol = 2) +
  labs(title = "FPKM Expression of BRCA1 and BRCA2 Across Tissues in Different Samples",
       x = "Samples", y = "FPKM Values",
       fill = "Tissue Type") +
  scale_fill_manual(values = c("orange" , "violet"), aesthetics = "fill") + 
  theme(plot.title = element_text(size=10, face="bold.italic"), 
        legend.position = "bottom", 
        legend.title = element_text(size=7),
        legend.text = element_text(size=7),
        legend.key.size = unit(0.2, "cm"),
        legend.background = element_rect(color="black", linewidth=0.1),
        axis.text.x = element_text(angle=60, hjust=1, vjust=0.5, size=2.7, margin=margin(t=2)),
        axis.text.y = element_text(size=5),
        axis.title.x = element_text(size=8, margin=margin(t=10)),
        axis.title.y = element_text(size=8))

# To remove grid: theme(panel.grid = element_blank(), panel.background = element_rect(fill = "white))        

# Saving the plot
ggsave(plot, filename = "barplot.png", width = 5.6, height = 3.47) 


# 2. Density Plot
dplot <- new_data %>% 
  filter(gene == 'BRCA1' | gene == 'BRCA2') %>% 
  ggplot(., aes(x=FPKM, fill=tissue)) +
  geom_density(alpha = 0.3, color = 'black', size = 0.1) +
  facet_wrap(~gene, ncol=2)+
  labs(title = 'Distribution of FPKM Expression of BRCA1 and BRCA2 Across Tissues in Different Samples',
       x = 'FPKM Expression', y = 'Density', fill = 'Tissue Type') +
  scale_fill_manual(values = c("red", "blue"), aesthetics = "fill") +
  theme(plot.title = element_text(size = 8.2, face = "bold.italic"),
        legend.position = "bottom", legend.title = element_text(size=7),
        legend.text = element_text(size=7), legend.key.size = unit(0.2, "cm"),
        legend.background = element_rect(color="black", linewidth=0.1),
        axis.text = element_text(size=4), axis.title = element_text(size=6, margin=margin(t=10)))
  
# Saving the plot
ggsave(dplot, filename = "densityplot.png", width = 5.6, height = 3.47) 


# 3. Boxplot
bplot <- new_data %>% 
  filter(gene == 'BRCA1'|gene == 'BRCA2') %>% 
  ggplot(., aes(x=metastasis, y= FPKM, fill = metastasis))+
  geom_boxplot(size = 0.1, outlier.color = "red", outlier.shape = 8, outlier.size = 1)+
  stat_summary(fun = "median", geom = "point", shape = 10, size=0.5, color="black") +
  facet_wrap(~gene, ncol=2) +
  labs(title = "FPKM Expression by Metastasis Status", y = 'FPKM Expression', 
       x = "Metastasis", fill = "Metastasis") +
  theme(plot.title = element_text(size = 10, face = "bold.italic", hjust = 0.5),
        axis.text = element_text(size=6), axis.title = element_text(size=7))
       
# saving the plot
ggsave(bplot, filename = "boxplot.png", width = 4.3, height = 3.47)
        

# 4. Scatterplot
library(GGally)
data2 <- new_data %>% 
  filter(gene == 'BRCA1' | gene == 'BRCA2') %>% 
  spread(key = gene, value = FPKM) %>% 
  select(BRCA1, BRCA2, tissue)

splot <- ggpairs(data2, aes(color=tissue), columns = c("BRCA1", "BRCA2"),
                 cardinality_threshold = 60) +
  labs(title = 'Correlation Between BRCA1 and BRCA2 Across Different Tissues in Various Samples')+
  theme(plot.title = element_text(size=9.8, face = "bold.italic", hjust=0.5),
        axis.text= element_text(size=5))

ggsave(splot, filename= 'scatterplot.png', width = 5.6, height = 4.7)


# 5. Heatmap
genes_of_interest <- c('BRCA1', 'BRCA2', 'CFTR', 'RAD52', 'MYCN', 'JUN', 'TP53')

hplot <- new_data %>% 
  filter(gene %in% genes_of_interest) %>% 
  ggplot(., aes(x=samples, y=gene, fill=FPKM))+
  geom_tile() +
  labs(title = 'Heatmap Showing FPKM Expression of Multiple Genes Across Various Samples', x = "Samples", y='Genes')+
  theme(plot.title = element_text(size=10, face = "bold.italic", hjust=0.5),
        axis.text.x= element_text(size=4, angle=90, margin=margin(t=5)), axis.text.y = element_text(size=6),
        axis.title = element_text(size=10, margin=margin(t=12)))+
  scale_fill_gradient(low= 'white', high ='darkblue')
ggsave(hplot, filename="heatmap.png", width = 5.6, height = 4.7)
        



         