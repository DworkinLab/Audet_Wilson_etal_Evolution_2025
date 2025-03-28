combined_allometry <- plot_grid(F35_allometry,F75_allometry,labels = c('A', 'B'),ncol = 1)

part1_SSD <- plot_grid(NULL,F35_SSD,NULL,F75_SSD,labels=c('A','','B',''),ncol =1,rel_heights = c(0.09,1,0.09,1))

x.grob <- textGrob("F-M Sexual dimorphism", 
                   gp=gpar(fontface="bold", col="black", fontsize=10))

plot_grid(part1_SSD,x.grob,ncol = 1,rel_heights = c(1,0.03))


combined_condition <- plot_grid(F35_condition,F75_condition,labels = c('A','B'),ncol = 1)

combined_SSD_condition <- plot_grid(F35_SSD_condition,F75_SSD_condition,labels=c('A','B'),ncol = 1)
