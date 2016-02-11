SkillScoreProgramPlot <- function(df)
{
    library(ggplot2)
    library(dplyr)
    #picking right skill confidence answers and program from the tidy dataset
    d <- df[,c(2,5:10)]
    #aggregating skill score
    d$skill_score = as.numeric(d[,2]) + 
        as.numeric(d[,3]) +
        as.numeric(d[,4]) +
        as.numeric(d[,5]) +
        as.numeric(d[,6]) +
        as.numeric(d[,7]) - 6
    #summarizing mean score by program
    mean_by_program <- d %>%
        group_by(program) %>%
        summarize(mean = mean(skill_score))
    #plotting facetted histograms by program
    ggp <- ggplot(data = d, aes(x = skill_score, fill = program)) + 
        geom_histogram(aes(y=..density..), binwidth = 2) + facet_grid(. ~ program) + theme_bw() +
        ggtitle("Distribution of Skill Scores Used by Program") + 
        xlab("SkillScores") +
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