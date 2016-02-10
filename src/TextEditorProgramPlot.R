TextEditorProgramPlot<-function(d)
{
  library(ggplot2)
  #Plotting stacked bar plot to show distribution of students in class by program and gender
  
  #Create a table with counts
  te<-data.frame(table(d$text_editor, d$program))
  names(te)<-c("TextEditor","Program", "Count")
  te<-te[ which(te$Program!='Other PhD'),]
  
  #format the LEGEND labels they wrap to the next line and not bleed
  levels(te$Program)<-gsub(" ","\n", levels(te$Program))
  levels(te$TextEditor)<-gsub(" ","\n", levels(te$TextEditor))
  levels(te$TextEditor)<-gsub("Webstorm,\npycharm","Webstorm/pycharm",levels(te$TextEditor))
  
  #ggplot code
  ggp<-ggplot(data=te, aes(x=reorder(TextEditor,-Count), y=Count, fill = Program)) + 
    facet_grid(~ Program)+
    geom_bar(stat = "identity") +
    theme_bw() +
    theme(text = element_text(),axis.text.x = element_text(angle=90, vjust=1)) +
    ggtitle("Distribution of Text Editors Used by Program") + 
    xlab("Text Editor") +
    ylab("Counts")
  return(ggp)
}

