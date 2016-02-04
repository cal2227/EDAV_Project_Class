require(foreign )
require(stats)
require(gplots)

filename <- "Survey+Response.xlsx"
cleanData <- tidydata(filename)

#reading the skills table from clean data
skills <- cleanData[,12:31]
skills[is.na(skills)] <- 0

#Sorting the columns based on number of people that mentioned each skill
freq <- colSums(skills)
freq <- sort(freq, decreasing = TRUE)

#Creating table skills2 which contains only top 10 mentioned skills
freq2 <- (freq[1:10])
plot(freq2, type= 'h', col = "red",ylab = "Frequency", xlab = "Skills", lwd = 5)

skills2 <- skills[, names(freq2)]
names(skills2)[5] <- "Google drive"
names(skills2)[6] <- "Dropbox"
names(skills2)[9] <- "Terminal"

#Create correlation matrix of skills, setting diagonal to NA (so it doesn't show in the heatmap)
cor2 <- cor(skills2)
diag(cor2) <- NA

#Specify the colors we want to show (using 2 reds because there are no observations in the first category)
my_palette <- colorRampPalette(c("red", "red", "yellow", "green"))
par(mar = c(3,3,2,1), mgp = c(1.5,.5,0), tck = -.01, fg = "gray",
    oma = c(1,1,1,1),bty = "l")

#Plotting the heatmap
heatmap.2(cor2, trace="none", dendrogram = 'none',symkey=TRUE, col=my_palette, 
          density.info = "density",na.rm = TRUE, keysize = 2, key.xlab = "Correlation",
          key.ylab = "Density" )



