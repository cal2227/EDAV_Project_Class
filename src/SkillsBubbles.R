SkillsBubbleRvM <- function(df) {
    library(ggplot2)
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
    #prepare plotting dataframe
    plotdf <- skillsdf %>%
        group_by(program) %>%
        summarize(avg_r_skill = round(mean(r_skill),2), 
                  avg_matlab_skill = round(mean(matlab_skill),2), 
                  avg_github_skill = round(mean(github_skill),2),
                  count =  length(program))
    
    ggp <- ggplot(data = plotdf, 
                  aes(x = avg_r_skill, y = avg_matlab_skill, 
                      weight = count, colour = program, size = count)) +
        geom_point(alpha = 0.8) + 
        scale_size_area(breaks=c(20, 30, 40, 50), "Number of respondents\non the program", max_size=30) +
        theme_bw() +
        theme(legend.position = "top") +
        xlab("Average R Skill") + 
        ylab("Average Matlab Skill") +
        scale_x_continuous(limits = c(0,2)) +
        scale_y_continuous(limits = c(0,2)) +
        ggtitle("R Skill vs Matlab Skill\nby Program Affiliation")
    
    return(ggp)
    
}

SkillsBubbleRvG <- function(df) {
    library(ggplot2)
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
    #prepare plotting dataframe
    plotdf <- skillsdf %>%
        group_by(program) %>%
        summarize(avg_r_skill = round(mean(r_skill),2), 
                  avg_matlab_skill = round(mean(matlab_skill),2), 
                  avg_github_skill = round(mean(github_skill),2),
                  count =  length(program))
    
    ggp <- ggplot(data = plotdf, 
                   aes(x = avg_r_skill, y = avg_github_skill, 
                       weight = count, colour = program, size = count)) +
        geom_point(alpha = 0.8) + 
        scale_size_area(breaks=c(20, 30, 40, 50), "Number of respondents\non the program", max_size=30) +
        theme_bw() +
        theme(legend.position = "none") +
        xlab("Average R Skill") + 
        ylab("Average Github Skill") +
        scale_x_continuous(limits = c(0,2)) +
        scale_y_continuous(limits = c(0,2)) +
        ggtitle("R Skill vs Github Skill\nby Program Affiliation")
    
    return(ggp)
    
}

SkillsBubbleGvM <- function(df) {
    library(ggplot2)
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
    #prepare plotting dataframe
    plotdf <- skillsdf %>%
        group_by(program) %>%
        summarize(avg_r_skill = round(mean(r_skill),2), 
                  avg_matlab_skill = round(mean(matlab_skill),2), 
                  avg_github_skill = round(mean(github_skill),2),
                  count =  length(program))

    ggp <- ggplot(data = plotdf, 
                   aes(x = avg_github_skill, y = avg_matlab_skill, 
                       weight = count, colour = program, size = count)) +
        geom_point(alpha = 0.8) + 
        scale_size_area(breaks=c(20, 30, 40, 50), "Number of respondents\non the program", max_size=30) +
        theme_bw() +
        theme(legend.position = "none") +
        xlab("Average Github Skill") + 
        ylab("Average Matlab Skill") +
        scale_x_continuous(limits = c(0,2)) +
        scale_y_continuous(limits = c(0,2)) +
        ggtitle("Github Skill vs Matlab Skill\nby Program Affiliation")
    
    return(ggp)
    
}