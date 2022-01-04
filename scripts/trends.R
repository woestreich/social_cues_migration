# analyze trends in case studies from systematic review
16

########################### FIGURE 5 ###########################
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
