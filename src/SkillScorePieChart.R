SkillScorePieChart <- function(df)
{
    library(ggplot2)
    library(dplyr)
    #picking right skill confidence answers and program from the tidy dataset
    d <- df[,c(2,5:10)]
    #aggregating skill score
    for (i in 2:7) {
        d[,i] <- as.numeric(d[,i])
        d[,i] <- d[,i] - 1
    }
    sd <- data.frame(Skill = c("Manipulation","Graphics"," Multivariate\n Analysis",
                               "R Markdown","Data Visualization","Github"),
                     SkillScore = colSums(d[,2:7]))
    sd$SkillPercent <- sd$SkillScore / sum(sd$SkillScore)
    sd <- sd[sort(sd[,2], decreasing = T, index.return = T)$ix,]
    
    reorder_size <- function(x) {
        factor(x$Skill, levels = x[sort(x[,2], decreasing = T, index.return = T)$ix,1], ordered = T)
    }
    #plotting pie chart
    ggp <- ggplot(data = sd, aes(reorder_size(sd), SkillScore, fill = Skill)) +
        geom_bar(stat = "identity", width = 1) + 
        theme_bw() + 
        theme(text = element_text(),axis.text.x = element_text(size = 11)) +
        coord_polar(theta = "x") +
        ggtitle("Pie Chart of Total Scores per Skill") + 
        scale_x_discrete(name="") + 
        geom_text(aes(x = Skill, y = 150, label = paste(round(SkillPercent*100,1),"%")), 
                      fontface = "bold", vjust = 1.2, size = 5)
    
    return(ggp)
}