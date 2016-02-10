GenderProgramPlot<-function(d)
{
  library(ggplot2)
  #Plotting stacked bar plot to show distribution of students in class by program and gender
  
  #Create a table with counts
  pdata<-data.frame(table(d$gender, d$program))
  names(pdata)<-c("Gender","Program", "Count")
  
  #format the x tick labels so that they wrap to the next line and not bleed
  levels(pdata$Program)<-gsub(" ","\n", levels(pdata$Program))
  
  #ggplot code
  ggp<-ggplot(data=pdata, aes(x=reorder(Program,-Count), y=Count, fill = Gender)) + 
      geom_bar(stat = "identity") +
      theme_bw() +
      ggtitle("Distribution of class by Gender and Program") +
      xlab("Program") +
      ylab("Number of students in Program")
  return(ggp)
}

