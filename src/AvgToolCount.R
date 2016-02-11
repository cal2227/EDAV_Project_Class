ToolScoreProgramPlot<-function(df)
{
    library(ggplot2)
    library(dplyr)
    d <- df[,c(2,11:30)]
    d$tool_score <- rowSums(d[,-1])
    
    mean_by_program <- d %>%
        group_by(program) %>%
        summarize(mean = mean(tool_score))
    
    ggp <- ggplot(data = d, aes(x = tool_score, fill = program)) + 
        geom_histogram(aes(y=..density..), binwidth = 2) + facet_grid(. ~ program) + 
        theme_bw() +
        ggtitle("Distribution of Tool Counts Used by Program") + 
        xlab("ToolCount") +
        ylab("Density") +
        scale_y_continuous(labels = scales::percent) +
        theme(axis.text.x = element_text(size = 8 , lineheight = 0.9, hjust = 1)) +
        theme(axis.text.y = element_text(size = 8)) +
        theme(legend.text = element_text(size = 8)) + 
        geom_vline(data = mean_by_program, aes(x = mean, xintercept = mean), colour = "red", size = 1) +
        geom_label(data = mean_by_program, 
                   aes(fill = program, x = mean, y = 0.15, label = paste("mean = ", round(mean,2))), 
                   hjust = -0.05, colour = "white", fontface = "bold")
    
    return(ggp)
}
