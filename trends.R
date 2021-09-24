# analyze trends in case studies from systematic review

# load necessary packages
library(tidyverse)
rm(list = ls())

# load in case study list
cases <- read.csv('data/case_studies.csv')
cases$year <- as.integer(cases$year)

# case study count by year
yearly_counts <- data.frame(year = 1985:2021, count = numeric(37))
for (i in 1985:2021) {
  yearly_counts$count[i-1984] <- sum(cases$year == i)
  yearly_counts$year[i-1984] <- i
}

p1 <- ggplot(yearly_counts,aes(year,count)) + geom_col() +
  theme_classic() +
  xlab("Year") +
  ylab("Number of case studies")
p1

