# analyze trends in case studies from systematic review

# load necessary packages
library(tidyverse)
library(patchwork)
library(RColorBrewer) 

# clear variables and set working directory
rm(list = ls())
setwd("scripts/")

# load in case study list
cases <- read.csv("../data/case_studies_clean.csv")
cases$Year <- as.integer(cases$Year)

# case study count by year
yearly_counts <- data.frame(year = 1969:2022, num = numeric(54))
for (i in 1969:2022) {
  yearly_counts$num[i-1968] <- sum(cases$Year == i)
  yearly_counts$year[i-1968] <- i
}

########################### FIGURE 3 ###########################
tiff("../outputs/Fig3.tiff",units="mm", width=180,height=70,res=500)
# time series of case studies
# p1a <- ggplot(yearly_counts,aes(year,num)) + 
#   geom_bar(stat = "identity", fill = "black", width = 0.8) +
#   theme_classic() +
#   xlab("Year") +
#   ylab("Number of case studies") 

# taxonomic breakdown of case studies
p1b <- ggplot(cases) +
  geom_bar(aes(x = Taxonomic.Group), fill = "black", position = "dodge", stat = "count") +
  theme_classic() +
  xlab("Taxon") +
  ylab("Number of case studies") +
  ylim(0,27) +
  coord_flip()

p1b
dev.off()
