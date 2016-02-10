#Set working directory
dirPath<-"C:/Users/Srividya/Desktop/EDAV/HW1"
setwd(dirPath)
filename<-"Survey+Response.xlsx"
source("tidydata.R")
source("GenderProgramPlot.R")
source("TextEditorProgramPlot.R")
cleanData<-tidydata(filename)
ggp<-GenderProgramPlot(cleanData)
ggp
ggp2<-TextEditorProgramPlot(cleanData)
ggp2
