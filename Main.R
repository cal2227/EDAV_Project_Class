#Set working directory
dirPath<-"/Users/MaxTan/Documents/CU_16spring/EDAV/assign1"
setwd(dirPath)
filename<-"Survey+Response.xlsx"
source("tidydata.R")
df<-tidydata(filename)

source("GenderProgramPlot.R")
GenderProgramPlot(df)

source("TextEditorProgramPlot.R")
TextEditorProgramPlot(df)


source("ToolScoreProgramPlot.R")
ToolScoreProgramPlot(df)


source("SkillScoreProgramPlot.R")
SkillScoreProgramPlot(df)


source("SkillScorePieChart.R")
SkillScorePieChart(df)

