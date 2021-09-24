# analyze trends in case studies from systematic review

# load necessary packages
library(tidyverse)
rm(list = ls())

# load in case study list
cases <- read.csv('data/case_studies.csv')
cases$year <- as.integer(cases$year)

# case study count by year
yearly_counts <- data.frame(year = 1975:2021, count = numeric(47))
for (i in 1975:2021) {
  yearly_counts$count[i-1974] <- sum(cases$year == i)
  yearly_counts$year[i-1974] <- i
}

p1a <- ggplot(yearly_counts,aes(year,count)) + 
  geom_bar(stat = "identity", fill = "darkblue", width = 0.8) +
  theme_classic() +
  xlab("Year") +
  ylab("Number of case studies")
p1a


p1b <- ggplot(cases) +
  geom_bar(aes(x = class), fill = "darkblue", position = "dodge", stat = "count") +
  theme_classic() +
  xlab("Taxon") +
  ylab("Number of case studies") +
  coord_flip()
p1b
