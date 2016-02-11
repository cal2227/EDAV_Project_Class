SkillsBubble3D <- function(df) {
    library(scatterplot3d)
    library(dplyr)
    
    skillsdf <- df[,c(2,5:10)]
    for (i in 2:7) {
        levels(skillsdf[,i]) <- c(0:3)
        skillsdf[,i] <- as.numeric(as.character(skillsdf[,i]))
    }
    #weights are assigned subjectively
    skillsdf$r_skill <- with(skillsdf, 
                             {0.2*r_modelling_skill + 0.3*r_graphics_skill + 
                                     0.4*r_advanced_skill + 0.1*r_reproduce_skill})
    skillsdf$r_skill <- round(skillsdf$r_skill * 3 / max(skillsdf$r_skill),2)
    
    plotdf <- skillsdf %>%
        group_by(program) %>%
        summarize(avg_r_skill = round(mean(r_skill),2), 
                  avg_matlab_skill = round(mean(matlab_skill),2), 
                  avg_github_skill = round(mean(github_skill),2),
                  count =  length(program))
    
    with(plotdf, {
        scatterplot3d(x = avg_r_skill, 
                      y = avg_github_skill, 
                      z = avg_matlab_skill,
                      type = "h",
                      color = c(1:4), pch = 19, box = T,
                      cex.symbols = count / 10)
    })
    
}