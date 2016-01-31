
#Function that takes the survey file and returns a clean & tidy dataframe
tidydata<-function(filename)
{
  library(xlsx) 
  df<-read.xlsx(filename, 1, header=T)
  removeCol<-c(19:38,5:11)
  #remove unused columns
  df<-df[,-removeCol]
  #clean up Program column
  table(df[,2])
  Program<-unique(df[,2])
  df[,2]<-replace(df[,2],df[,2]=="Ms in ds", "IDSE (master)")
  df[,2]<-replace(df[,2],df[,2]=="MSDS", "IDSE (master)")
  df[,2]<-replace(df[,2],df[,2]=="Data Science", "Data Science Certification")
  df[,2]<-replace(df[,2],df[,2]=="QMSS", "QMSS (master)")
  df[,2]<-droplevels(df[,2])
  
  #Cleanup Text Editors
  levels(df[,6])<-c(levels(df[,6]),"Eclipse","TextWrangler","None","Any","Jupyter")
  df[grep("Sublime Text / Eclipse",df[,6], ignore.case = FALSE),6]<- "Eclipse"
  df[grep("Sublime",df[,6], ignore.case = TRUE),6]<-"Sublime"
  df[grep("wrangler",df[,6], ignore.case = TRUE),6]<-"TextWrangler"
  df[grep("eclipse",df[,6], ignore.case = TRUE),6]<-"Eclipse"
  df[grep("haven't used any",df[,6], ignore.case = TRUE),6]<-"None"
  df[grep("20 years ",df[,6], ignore.case = TRUE),6]<-"Any"
  df[grep("Jupyter",df[,6], ignore.case = TRUE),6]<-"Jupyter"
  df[grep("ipynb",df[,6], ignore.case = TRUE),6]<-"Ipython"
  df[,6]<-droplevels(df[,6])
  
  
  #Clean up Experience with tools
  
  #Split the column into a list of lists
  temp<-strsplit(as.character(df[,3]),", ")
  #find the number of unique elements in the Experience with tools column
  skills<-unique(unlist(temp))
  #create a temporary data frame with 1 column for each unique skill
  newColNames<-skills
  skillsdf<-as.data.frame(matrix(nrow=nrow(df),ncol=20,dimnames=list(NULL,newColNames)))
  
  #The below for loop goes through each row in the excel file and looks at the
  #experience with tools column. If a skill is present, then you put a 1 against that
  #row and column in the temporary skills dataframe.
  for (i in 1:nrow(df))
  {
    skillList<-temp[[i]]
    for (j in 1:length(skillList))
    {
      skill<-skillList[j]
      skillsdf[i,skill]<-1
    }
  }
  #bind the temporary dataframe to the original dataframe
  cleandf<-cbind(df,skillsdf)
  return(cleandf)
}


