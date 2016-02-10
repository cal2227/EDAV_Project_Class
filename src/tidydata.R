
#Function that takes the survey file and returns a clean & tidy dataframe
tidydata<-function(filename)
{
  library(xlsx) 
  df<-read.xlsx(filename, sheetIndex = 1, header = T, stringsAsFactors = F)
  removeCol<-c(19:38,5:11)
  #remove unused columns
  df<-df[,-removeCol]
  #regroup columns logic-wise
  df<-df[c(1,2,5,6,4,7:11,3)]
  #clean up waiting list info
  df[,1]<-replace(df[,1],df[,1]=="Yes",1)
  df[,1]<-replace(df[,1],df[,1]=="No",0)
  df[,1] <- factor(df[,1], levels = c(0,1), labels = c("No","Yes"))
  names(df)[1] <- "waiting_list"
  
  #clean up Program column
  df[,2]<-replace(df[,2],df[,2]=="Ms in ds", "IDSE (master)")
  df[,2]<-replace(df[,2],df[,2]=="MSDS", "IDSE (master)")
  df[,2]<-replace(df[,2],df[,2]=="Data Science", "DS Certification")
  df[,2]<-replace(df[,2],df[,2]=="Data Science Certification", "DS Certification")
  df[,2]<-replace(df[,2],df[,2]=="QMSS", "QMSS (master)")
  df[,2]<-replace(df[,2],df[,2]=="Applied Math", "Other masters")
  df[,2]<-replace(df[,2],df[,2]=="Ph.D.", "Other PhD")
  df[,2]<-replace(df[,2],df[,2]=="PhD Biomedical Informatics", "Other PhD")
  df[,2]<-factor(df[,2])
  names(df)[2] <- "program"
  
  #clean up gender
  df[,3]<-replace(df[,3],df[,3]=="she/her","F")
  df[,3]<-replace(df[,3],df[,3]=="he/him","M")
  df[,3]<-replace(df[,3],df[,3]=="doesn't matter","NA")
  df[,3]<-replace(df[,3],is.na(df[,3]),"NA")
  df[,3]<-factor(df[,3])
  names(df)[3] <- "gender"
  
  #clean up Text Editors
  df[,4]<-factor(df[,4])
  levels(df[,4])<-c(levels(df[,4]),"Eclipse","TextWrangler","None","Any","Jupyter")
  df[grep("Sublime Text / Eclipse",df[,4], ignore.case = FALSE),4]<- "Eclipse"
  df[grep("Sublime",df[,4], ignore.case = TRUE),4]<-"Sublime"
  df[grep("wrangler",df[,4], ignore.case = TRUE),4]<-"TextWrangler"
  df[grep("eclipse",df[,4], ignore.case = TRUE),4]<-"Eclipse"
  df[grep("haven't used any",df[,4], ignore.case = TRUE),4]<-"None"
  df[grep("20 years ",df[,4], ignore.case = TRUE),4]<-"Any"
  df[grep("Jupyter",df[,4], ignore.case = TRUE),4]<-"Jupyter"
  df[grep("ipynb",df[,4], ignore.case = TRUE),4]<-"Ipython"
  df[,4]<-droplevels(df[,4])
  names(df)[4] <- "text_editor"
  
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


