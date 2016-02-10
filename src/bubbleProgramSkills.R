###tidy data is in df

avg_R_skill <- sapply(unique(df$Program), 
                      function(x) {mean(as.numeric(df[df$Program == x,4]))})
names(avg_R_skill) <- unique(df$Program)

avg_Matlab_skill <- sapply(unique(df$Program), 
                           function(x) {mean(as.numeric(df[df$Program == x,10]))})
names(avg_Matlab_skill) <- unique(df$Program)

size <- sapply(unique(df$Program), 
               function(x) {nrow(df[df$Program == x,])})
names(size) <- unique(df$Program)

bubble_table <- cbind(avg_Matlab_skill, avg_R_skill, size)
bubble_table2 <- as.data.frame(bubble_table)
bubble_table2$program <- row.names(bubble_table2)

library(ggplot2)
bplot <- ggplot(bubble_table2, 
                aes(x = avg_R_skill, 
                    y = avg_Matlab_skill, 
                    size = size, 
                    label = program), 
                guide = FALSE)
bplot + geom_point(alpha = 0.8,shape=21)
    + scale_size_area(max_size = 20) 
    + geom_text(size = 4) 
    + scale_colour_brewer(palette=2, type="qual",name="Program") 
    + guides(colour = guide_legend(override.aes = list(alpha = 1)))
    + scale_size_area(max_size = 25)


