TextEditorProgramPlot<-function(d)
{
  library(ggplot2)
  #Plotting stacked bar plot to show distribution of students in class by program and gender
  
  #Create a table with counts
  te<-data.frame(table(d$What.code.text.editor.do.you.use.most., d$Program))
  names(te)<-c("TextEditor","Program", "Count")
  
  #format the LEGEND labels they wrap to the next line and not bleed
  levels(te$Program)<-gsub(" ","\n", levels(te$Program))
  levels(te$TextEditor)<-gsub(" ","\n", levels(te$TextEditor))
  
  
  #ggplot code
  ggp<-ggplot(data=te, aes(x=reorder(TextEditor,-Count), y=Count, fill = Program)) + 
    geom_bar(stat = "identity") +
    theme_bw() +
    ggtitle("Distribution of Text Editors Used by Program") + 
    xlab("Text Editor") +
    ylab("Counts")
  return(ggp)
}

