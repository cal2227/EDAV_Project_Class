ToolScoreProgramPlot<-function(d)
{
  library(ggplot2)
  d[is.na(d)] <- 0
  d <- d[-c(59,73,97),]
  d <- droplevels(d)
  #Tool Score Plot for Different Programs
  #We want to know the distribution of students' tool scores from different programs.
  #Every used tool can be regarded as one point. We use this judgement to evaluate students' capabilities.
  
  
  toolscore <-as.factor(rowSums(d[,12:31]))
  toolscore_df <- data.frame(d$program,toolscore)
  names(toolscore_df) <- c("Program","ToolScore")
  #Create a table with counts
  te<-data.frame(table(toolscore_df$ToolScore, toolscore_df$Program))
  te$Freq[1:16] <- te$Freq[1:16]/sum(te$Freq[1:16])
  te$Freq[17:32] <-te$Freq[17:32]/sum(te$Freq[17:32])
  te$Freq[33:48] <- te$Freq[33:48]/sum(te$Freq[33:48])
  te$Freq[49:64] <- te$Freq[49:64]/sum(te$Freq[49:64])
  
  te <- te[te$Freq>0,,]
  print(te)
  names(te)<-c("ToolScore","Program", "Count")
  
  #format the LEGEND labels they wrap to the next line and not bleed
  levels(te$Program)<-gsub(" ","\n", levels(te$Program))
  levels(te$ToolScore)<-gsub(" ","\n", levels(te$ToolScore))
  
  #x=reorder(ToolScore,-Count)
  
  #ggplot code
  ggp<-ggplot(data=te, aes(ToolScore,Count, fill = Program)) + 
    facet_grid(. ~ Program) +
    geom_bar(stat = "identity") +
    theme_bw() +
    ggtitle("Distribution of Tool Scores Used by Program") + 
    xlab("ToolScores") +
    ylab("Density") +
    theme(axis.text.x = element_text(size = 6 , lineheight = 0.9, hjust = 1)) +
    theme(axis.text.y = element_text(size = 8)) +
    theme(legend.text = element_text(size = 5))
  return(ggp)
}
#ToolScoreProgramPlot(df)