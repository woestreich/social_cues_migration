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
tiff("../outputs/Fig3.tiff",units="in", width=10,height=3.7,res=300)
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
  ylim(0,26) +
  coord_flip()

p1b
dev.off()

########################### FIGURE 4 ###########################
## Old figure, not included in final manuscript
cases$Cue.Type <- factor(cases$Cue.Type, 
                         levels = c("active cueing", "leader/follower",
                                    "social learning","presence of young",
                                    "density dependency","conspecific competition"))
cases$Decision.Scale <- factor(cases$Decision.Scale, 
                               levels = c("migration timing fine", "migration progress",
                                          "migration timing broad", "to migrate or not to migrate"))
tiff("../outputs/Fig4.tiff",units="in", width=12,height=5,res=300)
my_palette <- brewer.pal(name="Greens",n=4)
p4a <- ggplot(cases, aes(x=Taxonomic.Group, fill=Decision.Scale)) +
  geom_bar(color = "black") +
  scale_fill_manual(labels = c("migration timing (fine; \u2264 day)","migration progress",
                               "migration timing (broad; > day)","to migrate or not to migrate"),
                    values = my_palette) +
  xlab("Taxon") +
  ylab("Number of case studies") +
  guides(fill = guide_legend(title = "Temporal scale of decision")) +
  theme_classic() +
  theme(legend.position = c(0.8, 0.8)) +
  geom_segment(x = 3.9, y = 16.5, xend = 3.9, yend = 19,
               lineend = 'butt', linejoin = 'mitre',
               size = 1, arrow = arrow(length = unit(0.1, "inches"))) +
  geom_segment(x = 3.9, y = 19, xend = 3.9, yend = 16.5,
               lineend = 'butt', linejoin = 'mitre',
               size = 1, arrow = arrow(length = unit(0.1, "inches"))) +
  geom_text(x=3.9, y=15.5, label="broad",size=3) +
  geom_text(x=3.9, y=20, label="fine",size=3) +
  geom_text(x=0.8,y=22, label="A",size=5)

p4b <- ggplot(cases, aes(x=Taxonomic.Group, fill=Cue.Type)) +
  geom_bar(color = "black") +
  #scale_fill_manual(labels = c("active cueing","leader/follower","social learning",
  #                             "presence of young","density dependency","conspecific competition")) +
  scale_fill_brewer(labels = c("active cueing","leader/follower","social learning",
                               "presence of young","density dependency","conspecific competition")) +
  xlab("Taxon") +
  ylab("") +
  guides(fill = guide_legend(title = "Social cue")) +
  theme_classic() +
  theme(legend.position = c(0.85, 0.75)) +
  geom_segment(x = 4.3, y = 14, xend = 4.3, yend = 19,
               lineend = 'butt', linejoin = 'mitre',
               size = 1, arrow = arrow(length = unit(0.1, "inches"))) +
  geom_segment(x = 4.3, y = 19, xend = 4.3, yend = 14,
               lineend = 'butt', linejoin = 'mitre',
               size = 1, arrow = arrow(length = unit(0.1, "inches"))) +
  geom_text(x=4.3, y=13, label="implicit",size=3) +
  geom_text(x=4.3, y=20, label="explicit",size=3) +
  geom_text(x=0.8,y=22, label="B",size=5)

p4a+p4b
dev.off()

########################### FIGURE 5 ###########################
## Old figure, not included in final manuscript
tiff("../outputs/Fig5.tiff",units="in", width=9,height=5,res=300)
#option a
p5a <- ggplot(cases, aes(x = cue_type)) + 
  geom_bar(aes(fill = decision_type), position = "fill", color = "black") +
  scale_fill_brewer() +
  xlab("Social cue") +
  ylab("Normalized count") +
  guides(fill = guide_legend(title = "Temporal scale of decision")) +
  theme_classic()

#option b
p5b <- ggplot(cases, aes(x = decision_type)) + 
  geom_bar(aes(fill = cue_type), position = "fill", color = "black") +
  scale_fill_brewer() +
  scale_x_discrete(labels = c("migration timing\n (fine; \u2264 day)","migration progress",
                              "migration timing\n (broad; > day)","to migrate or\n not to migrate")) +
  xlab("Temporal scale of decision") +
  ylab("Normalized count") +
  guides(fill = guide_legend(title = "Social cue")) +
  theme_classic()
# +
#   theme(legend.position="right",
#         legend.margin=margin(0,0,0,0),
#         legend.box.margin=margin(50,50,50,50)) +
#   geom_segment(x = 5, y = 0.3, xend = 5, yend = 0.7,
#                lineend = 'butt', linejoin = 'mitre',
#                size = 1, arrow = arrow(length = unit(0.1, "inches"))) +
#   geom_segment(x = 5, y = 0.7, xend = 5, yend = 0.3,
#                lineend = 'butt', linejoin = 'mitre',
#                size = 1, arrow = arrow(length = unit(0.1, "inches"))) +
#   geom_text(x=5, y=0.25, label="implicit",size=3) +
#   geom_text(x=5, y=0.75, label="explicit",size=3) 

p5b
dev.off()
