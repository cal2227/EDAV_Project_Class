SkillConfidenceLine <- function(df) 
{
    library(dplyr)
    
    ## extracting and summarizing the data ##
    skillsdf <- df[,c(2,6:10)]
    for (i in 2:6) {
        levels(skillsdf[,i]) <- c(0:3)
        skillsdf[,i] <- as.numeric(as.character(skillsdf[,i]))
    }
    
    Program_exp <- skillsdf %>%
        group_by(program) %>%
        summarize(mean_graph = mean(r_graphics_skill),
                  mean_multivariate = mean(r_advanced_skill),
                  mean_Markdown = mean(r_reproduce_skill),
                  mean_Matlab = mean(matlab_skill),
                  mean_Github = mean(github_skill))
    
    plot_colors <- c("blue","red","green","black","Cyan")
    
    ## create the plot ##
    plot(c(1,4), c(0,3), type="n", xlab="Program", ylab="Average Confidence",axes=F, ann=F)
    
    #### Labelling Axis ####
    axis(1, at= Program_exp$program, labels = Program_exp$program )
    axis(2, las=1, at= seq(0, 3, .4)) #0:max(g_range))
    axis(4, las =0 ,at= c(0,1,2,3), labels = c("None","A Little","Confident","Expert"),cex= 2)
    box()
    
    ## Title the axis ##
    title(xlab= "Program", col.lab=rgb(0,0.5,0))
    title(ylab= "Average Confidence", col.lab=rgb(0,0.5,0))
    
    ## plot line for all the skills ##
    lines(Program_exp$mean_graph, type="o", pch=22, lty=2, col=plot_colors[1],lwd = 2)
    lines(Program_exp$mean_multivariate, type="o", pch=22, lty=2, col=plot_colors[2],lwd = 2)
    lines(Program_exp$mean_Markdown, type="o", pch=22, lty=2, col=plot_colors[3],lwd = 2)
    lines(Program_exp$mean_Matlab, type="o", pch=22, lty=2, col=plot_colors[4],lwd = 2)
    lines(Program_exp$mean_Github, type="o", pch=22, lty=2, col=plot_colors[5],lwd = 2)
    
    ## add legend ##
    legend("topright", c("Graphics","Multivariate","Markdown","Matlab","Github"), 
           col=plot_colors, pch=22, lty=2,lwd = 2, bty= "n",cex=.6)
}