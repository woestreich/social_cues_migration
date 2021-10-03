# analyze trends in case studies from systematic review

# load necessary packages
library(tidyverse)
library(patchwork)

# clear variables and set working directory
rm(list = ls())
setwd("scripts/")

# load in case study list
cases <- read.csv("../data/case_studies.csv")
cases$year <- as.integer(cases$year)

# case study count by year
yearly_counts <- data.frame(year = 1975:2021, count = numeric(47))
for (i in 1975:2021) {
  yearly_counts$count[i-1974] <- sum(cases$year == i)
  yearly_counts$year[i-1974] <- i
}

########################### FIGURE 1 ###########################
tiff("../outputs/Fig1.tiff",units="in", width=10,height=5,res=300)
# time series of case studies
p1a <- ggplot(yearly_counts,aes(year,count)) + 
  geom_bar(stat = "identity", fill = "darkblue", width = 0.8) +
  theme_classic() +
  xlab("Year") +
  ylab("Number of case studies") 

# taxonomic breakdown of case studies
p1b <- ggplot(cases) +
  geom_bar(aes(x = class), fill = "darkblue", position = "dodge", stat = "count") +
  theme_classic() +
  xlab("Taxon") +
  ylab("Number of case studies") +
  ylim(0,20) +
  coord_flip()

p1a/p1b
dev.off()

########################### FIGURE 4 ###########################
cases$cue_type <- factor(cases$cue_type, 
                         levels = c("active cueing behavior", "social learning",
                                    "presence of young","leading/following behavior",
                                    "density dependency","breeding competition"))
tiff("../outputs/Fig4.tiff",units="in", width=12,height=5,res=300)
p4a <- ggplot(cases, aes(x=class, fill=decision_type)) +
  geom_bar(color = "black") +
  scale_fill_brewer() +
  xlab("Taxon") +
  ylab("Number of case studies") +
  guides(fill = guide_legend(title = "Temporal scale of decision")) +
  theme_classic()

p4b <- ggplot(cases, aes(x=class, fill=cue_type)) +
  geom_bar(color = "black") +
  scale_fill_brewer() +
  xlab("Taxon") +
  ylab("") +
  guides(fill = guide_legend(title = "Social cue")) +
  theme_classic()

p4a+p4b
dev.off()

########################### FIGURE 5 ###########################
p5a <- ggplot(cases, aes(x = cue_type)) + 
  geom_bar(aes(fill = decision_type), position = "fill", color = "black") +
  scale_fill_brewer() +
  xlab("Social cue") +
  ylab("Normalized count") +
  guides(fill = guide_legend(title = "Temporal scale of decision")) +
  theme_classic()
p5a

p5b <- ggplot(cases, aes(x = decision_type)) + 
  geom_bar(aes(fill = cue_type), position = "fill", color = "black") +
  scale_fill_brewer() +
  xlab("Temporal scale of decision") +
  ylab("Normalized count") +
  guides(fill = guide_legend(title = "Social cue")) +
  theme_classic()
p5b
