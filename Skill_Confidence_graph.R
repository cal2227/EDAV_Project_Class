Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_73')
require(rJava)
require(xlsx)
df <-read.xlsx("C:\\Users\\sugandha\\Documents\\GitHub\\01-29_Initial_analyses.xlsx", sheetName = "Sheet3",header=T,stringsAsFactors=FALSE)

### calculate mean of confidence level ######

df_IDSE <- subset(df, program =="IDSE (master)")

mean_graph_idse <-mean (df_IDSE$graphic)
mean_multivariate_idse <-mean (df_IDSE$multivariate)
mean_Markdown_idse <-mean (df_IDSE$Markdown)
mean_Matlab_idse <-mean (df_IDSE$Matlab)
mean_Github_idse <-mean (df_IDSE$Github)

df_OTMS <- subset(df, program =="Other masters")

mean_graph_OTMS <-mean (df_OTMS$graphic)
mean_multivariate_OTMS <-mean (df_OTMS$multivariate)
mean_Markdown_OTMS <-mean (df_OTMS$Markdown)
mean_Matlab_OTMS <-mean (df_OTMS$Matlab)
mean_Github_OTMS <-mean (df_OTMS$Github)

df_DSCert <- subset(df, program =="Data Science Certification")

mean_graph_DSCert <-mean (df_DSCert$graphic)
mean_multivariate_DSCert <-mean (df_DSCert$multivariate)
mean_Markdown_DSCert <-mean (df_DSCert$Markdown)
mean_Matlab_DSCert <-mean (df_DSCert$Matlab)
mean_Github_DSCert <-mean (df_DSCert$Github)

df_stat <- subset(df, program =="Statistics (master)")

mean_graph_stat <-mean (df_stat$graphic)
mean_multivariate_stat <-mean (df_stat$multivariate)
mean_Markdown_stat <-mean (df_stat$Markdown)
mean_Matlab_stat <-mean (df_stat$Matlab)
mean_Github_stat <-mean (df_stat$Github)

df_phd <- subset(df, program =="Ph.D.")

mean_graph_phd <-mean (df_phd$graphic)
mean_multivariate_phd <-mean (df_phd$multivariate)
mean_Markdown_phd <-mean (df_phd$Markdown)
mean_Matlab_phd <-mean (df_phd$Matlab)
mean_Github_phd <-mean (df_phd$Github)

df_math <- subset(df, program =="Applied Math")

mean_graph_math <-mean (df_math$graphic)
mean_multivariate_math <-mean (df_math$multivariate)
mean_Markdown_math <-mean (df_math$Markdown)
mean_Matlab_math <-mean (df_math$Matlab)
mean_Github_math <-mean (df_math$Github)

program<- c("IDSE (master)","Other masters","Data Science Certification","Statistics (master)","Ph.D.", "Applied Math")
mean_graph <- c(mean_graph_idse, mean_graph_OTMS,mean_graph_DSCert, mean_graph_stat, mean_graph_phd,mean_graph_math)
mean_multivariate <- c(mean_multivariate_idse, mean_multivariate_OTMS,mean_multivariate_DSCert, mean_multivariate_stat, mean_multivariate_phd,mean_multivariate_math)
mean_Markdown <- c(mean_Markdown_idse, mean_Markdown_OTMS,mean_Markdown_DSCert, mean_Markdown_stat, mean_Markdown_phd,mean_Markdown_math)
mean_Matlab <- c(mean_Matlab_idse, mean_Matlab_OTMS,mean_Matlab_DSCert, mean_Matlab_stat, mean_Matlab_phd,mean_Matlab_math)

mean_Github <- c(mean_Github_idse, mean_Github_OTMS,mean_Github_DSCert, mean_Github_stat, mean_Github_phd,mean_Github_math)

 ### Construct dataframe from the obtained means of skills across all programs ###

Program_exp <- data.frame(program, mean_graph, mean_multivariate,mean_Markdown , mean_Matlab,mean_Github)



g_range <- range(0, Program_exp$mean_graph, Program_exp$mean_multivariate,mean_Matlab,mean_Markdown, Program_exp$mean_Github)
plot_colors <- c("blue","red","forestgreen","purple","Cyan")

## create the plot ##
plot( x<- Program_exp$program,y<-Program_exp$mean_graph,type="o", col=plot_colors[1], ylim= g_range ,axes=FALSE, ann=FALSE)

#### Labelling Axis ####
axis(1, at= Program_exp$program, labels = Program_exp$program)
axis(2, las=1, at= seq(0, max(g_range), .2))#0:max(g_range))
axis(4, las =1 ,at= c(0,1,2,3), labels = c("None","A Little","Confident","Expert"),cex= 2)

box()

## Title the axis
title(xlab= "Program", col.lab=rgb(0,0.5,0))
title(ylab= "Average Confidence", col.lab=rgb(0,0.5,0))

## plot line for all the skills ##

lines(Program_exp$mean_multivariate, type="o", pch=22, lty=2, col=plot_colors[2])

lines(Program_exp$mean_Markdown, type="o", pch=22, lty=2, col=plot_colors[3])


lines(Program_exp$mean_Matlab, type="o", pch=22, lty=2, col=plot_colors[4])


lines(Program_exp$mean_Github, type="o", pch=22, lty=2, col=plot_colors[5])

## add legend #

legend("topleft", c("Graphics","Multivariate","Markdown","Matlab","Github"), 
      col=plot_colors, pch=22, lty=2, bty= "n",cex=.6);

