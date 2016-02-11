GenderProgramPlot<-function(d)
{
  library(ggplot2)
  library(dplyr)
  #Plotting stacked bar plot to show distribution of students in class by program and gender
  
  #Create a table with counts
  pdata<-data.frame(table(d$gender, d$program))
  names(pdata)<-c("Gender","Program", "Count")
  
  #format the x tick labels so that they wrap to the next line and not bleed
  levels(pdata$Program)<-gsub(" ","\n", levels(pdata$Program))
  
  #ggplot code
  
  sum_count <- pdata %>%
      group_by(Program) %>%
      summarize(max_pos = sum(Count))
  
  ggp<-ggplot(data=pdata, aes(x=reorder(Program,-Count), y=Count, fill = Gender)) + 
      geom_bar(stat = "identity") +
      theme_bw() +
      ggtitle("Distribution of class by Gender and Program") +
      xlab("Program") +
      ylab("Number of students in Program") +
      geom_text(data = sum_count, aes(y = max_pos, x = Program, label = max_pos, fontface = "bold"), 
                inherit.aes=FALSE, size = 4, vjust = -0.5) +
      expand_limits(y = c(0, 65))
  return(ggp)
}

