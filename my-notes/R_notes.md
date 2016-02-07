## R

#### Clean Data
<http://www.r-bloggers.com/r-function-of-the-day-table/>
<http://www.sthda.com/english/wiki/r-xlsx-package-a-quick-start-guide-to-manipulate-excel-files-in-r>

```{r, eval=FALSE}
library(xlsx)
df <- read.xlsx(filename, 1, header=T)
table(df[,2])
Program <- unique(df[,2])
df[,2] <- replace(df[,2],df[,2]=="MSDS", "IDSE (master)")
levels(df[,6]) <- c(levels(df[,6]),"Eclipse","TextWrangler","None","Any","Jupyter)
df[,2] <- droplevels(df[,2])
df[grep("Sublime",df[,6], ignore.case = TRUE),6] <- "Sublime"
df[,6] <- droplevels(df[,6])
cleandf <- cbind(df,skillsdf)
```

#### Text Editor Program Plot

```{r, eval=FALSE}
te <- data.frame(table(df$What.code.text.editor.do.you.use.most., df$Program))
names(te) <- c("TextEditor", "Program", "Count")
levels(te$Program) <- gsub(" ", "\n", levels(te$TextEditor))
library(ggplot2)
ggp <- ggplot(date=te, aes(x=reorder(TextEditor, -Count), y=Count, fill=Program))
  + geom_bar(stat="identity")
  + theme+bw()
  + ggtitle("Distribution of Text Editors Used by Program")
  + xlab("Text Editor")
  + ylab("Counts")

```

#### Misc

```{r, eval=FALSE}
list.files()
setwd('EDAV_Project_Class')
```