SkillScorePieChart<-function(d)
{
  #Plot Skill Score Plot for Different Skills
  #The Skill Score evaluation is the same as the previous evaluation
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
  
  
  
  skilldata2 <- skilldata
  levels(skilldata2$Program)
  names(skilldata2)
  
  
  skilldata2[115,2:7] <- colSums(skilldata2[1:114,2:7])
  skilltotalscore <- skilldata2[115,2:7]
  
  library(plotrix)
  library(scales)
  totalscore <- data.matrix(skilltotalscore)
  perc <- percent(totalscore/sum(totalscore))
  pie(totalscore,labels=paste(names(skilltotalscore),perc,sep="\n"), radius = 1,angle = 90,
        col = c(2:7), main="Pie Chart of Total Scores\nfor Different Skills")
}