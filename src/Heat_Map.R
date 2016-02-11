FreqTools <- function(df)
{
    library(ggplot2)
    #reading the skills table from clean data
    skills <- df[,11:30]
    
    #Sorting the columns based on number of people that mentioned each skill
    freq <- colSums(skills)
    freq <- sort(freq, decreasing = TRUE)
    
    #Creating table skills2 which contains only top 10 mentioned skills
    freq2 <- data.frame(tool = names(freq)[1:10], freq = freq[1:10], stringsAsFactors = F)
    freq2$tool[5] <- "Google drive"
    freq2$tool[6] <- "Dropbox"
    freq2$tool[9] <- "Terminal"
    
    reorder_size <- function(x) {
        factor(x$tool, levels = x[sort(x[,2], decreasing = T, index.return = T)$ix,1], ordered = T)
    }
    
    ggp <- ggplot(data = freq2, aes(x = reorder_size(freq2), y = freq, fill = freq)) + 
        geom_bar(stat = "identity") +
        theme_bw() +
        theme(axis.text.x = element_text(angle = 90, size = 9)) +
        ggtitle("Most Frequently Selected Tools") +
        xlab("") +
        ylab("Frequency")
        
    
    return(ggp)
}

HeatMap <- function(df) 
{
    require(foreign)
    require(stats)
    require(gplots)

    #reading the skills table from clean data
    skills <- df[,11:30]

    #Sorting the columns based on number of people that mentioned each skill
    freq <- colSums(skills)
    freq <- sort(freq, decreasing = TRUE)

    #Creating table skills2 which contains only top 10 mentioned skills
    
    skills2 <- skills[, names(freq)[1:10]]
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
}



