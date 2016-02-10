SkillScoreProgramPlot<-function(d)
{
  library(ggplot2)
  d <- d[-c(59,73,97),]
  d <- droplevels(d)
  #plot 2 Skill Score Plot for Different Programs
  #We want to know the distribution of students' skill scores from different programs.
  #"Expert" can add 3 points, "Confident" can add 2 points, "A little" can add 1 points and "None" is none.
  skilldata <- data.frame(d[,2],d[,5:10])
  names(skilldata) <- c("Program","Manipulation","Graphic","Multivariate Analysis","R Markdown","Data Visualization","Github")
  
  
  #preprocess the data frame:
  skilldata$Manipulation <- as.factor(skilldata$Manipulation)
  skilldata$Graphic <- as.factor(skilldata$Graphic)
  skilldata$`Multivariate Analysis` <- as.factor(skilldata$`Multivariate Analysis`)
  skilldata$`R Markdown` <- as.factor(skilldata$`R Markdown`)
  skilldata$`Data Visualization` <- as.factor(skilldata$`Data Visualization`)
  skilldata$Github <- as.factor(skilldata$Github)
  
  levels(skilldata$Manipulation) <- as.integer(c(1,2,3,0))
  skilldata$Manipulation <- as.numeric(levels(skilldata$Manipulation))[skilldata$Manipulation]
  sum(skilldata$Manipulation)
  
  levels(skilldata$Graphic) <- as.integer(c(1,2,3,0))
  skilldata$Graphic <- as.numeric(levels(skilldata$Graphic))[skilldata$Graphic]
  sum(skilldata$Graphic)
  
  levels(skilldata$`Multivariate Analysis`) <- as.integer(c(1,2,3,0))
  skilldata$`Multivariate Analysis` <- as.numeric(levels(skilldata$`Multivariate Analysis`))[skilldata$`Multivariate Analysis`]
  sum(skilldata$`Multivariate Analysis`)
  
  levels(skilldata$`R Markdown`) <- as.integer(c(1,2,3,0))
  skilldata$`R Markdown` <- as.numeric(levels(skilldata$`R Markdown`))[skilldata$`R Markdown`]
  sum(skilldata$`R Markdown`)
  
  levels(skilldata$`Data Visualization`) <- as.integer(c(1,2,3,0))
  skilldata$`Data Visualization` <- as.numeric(levels(skilldata$`Data Visualization`))[skilldata$`Data Visualization`]
  sum(skilldata$`Data Visualization`)
  
  levels(skilldata$Github) <- as.integer(c(1,2,3,0))
  skilldata$Github <- as.numeric(levels(skilldata$Github))[skilldata$Github]
  sum(skilldata$Github)
  
  skillscore <-as.factor(rowSums(skilldata[,2:7]))
  skillscore_df <- data.frame(d$program,skillscore)
  names(skillscore_df) <- c("Program","SkillScore")
  
  
  #Create a table with counts
  te<-data.frame(table(skillscore_df$SkillScore, skillscore_df$Program))
  te$Freq[1:15] <- te$Freq[1:15]/sum(te$Freq[1:15])
  te$Freq[16:30] <-te$Freq[16:30]/sum(te$Freq[16:30])
  te$Freq[31:45] <- te$Freq[31:45]/sum(te$Freq[31:45])
  te$Freq[46:60] <- te$Freq[46:60]/sum(te$Freq[46:60])
  names(te)<-c("SkillScore","Program", "Count")

  
  #format the LEGEND labels they wrap to the next line and not bleed
  #print(te$Program)
  levels(te$Program)<-gsub(" ","\n", levels(te$Program))
  #print(te$SkillScore)
  levels(te$SkillScore)<-gsub(" ","\n", levels(te$SkillScore))
  
  #x=reorder(SkillScore,-Count)
  
  #ggplot code
  ggp<-ggplot(data=te, aes(x=SkillScore, y=Count, fill = Program)) + 
    geom_bar(stat = "identity") +
    facet_grid(. ~ Program) +
    theme_bw() +
    ggtitle("Distribution of Skill Scores Used by Program") + 
    xlab("SkillScores") +
    ylab("Density") +
    theme(axis.text.x = element_text(size = 8 , lineheight = 0.9, hjust = 1)) +
    theme(axis.text.y = element_text(size = 8)) +
    theme(legend.text = element_text(size = 5))
  return(ggp)
}
#SkillScoreProgramPlot(df)