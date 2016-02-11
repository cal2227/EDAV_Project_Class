# Expects data td output from tidydata.R
SkillsData <- function(td)
{
  lay_tools <- c("Excel", "dropbox", "google drive (formerly docs)")
  gp_tools <- c("SQL", "Python", "regular expressions (grep)", "Github", "shell (terminal / command line)", "Web: html css js", "XML", "C/C++")
  ds_tools <- c("R", "RStudio", "ggplot2", "Stata", "Sweave/knitr", "Matlab", "SPSS", "lattice")

  # Indicate if row contains at least one real value in skills subset
  skills_predicate <- function(df, skills)
  {
    return(apply(!is.na(df[,skills]), 1, any))
  }
  uses_lay_tools <- skills_predicate(td, lay_tools)
  uses_gp_tools <- skills_predicate(td, gp_tools)
  uses_ds_tools <- skills_predicate(td, ds_tools)

  sd <- data.frame("program" = td$program, uses_lay_tools, uses_gp_tools, uses_ds_tools)

  # summary stats
  # aggregate(uses_lay_tools ~ program, data = sd, sum)
  # aggregate(uses_gp_tools ~ program, data = sd, sum)
  # aggregate(uses_ds_tools ~ program, data = sd, sum)

  return(sd)

}

# Expects data sd output from SkillsData()
SkillsDataDiagrams1 <- function(sd)
{
  library(VennDiagram)

  individual_sum <- aggregate(. ~ program, data=sd, sum)
  lay_gp_sum <- aggregate(uses_lay_tools ~ program, data=subset(sd, uses_lay_tools & uses_gp_tools), sum)
  gp_ds_sum <- aggregate(uses_gp_tools ~ program, data=subset(sd, uses_gp_tools & uses_ds_tools), sum)
  ds_lay_sum <- aggregate(uses_ds_tools ~ program, data=subset(sd, uses_ds_tools & uses_lay_tools), sum)
  lay_gp_ds_sum <- aggregate(uses_ds_tools ~ program, data=subset(sd, uses_lay_tools & uses_gp_tools & uses_ds_tools), sum)

  #> levels(sd$program)
  #[1] "DS Certification"    "IDSE (master)"       "Other masters"       "Other PhD"          
  #[5] "Statistics (master)
  for (level in levels(sd$program))
  {
  draw.triple.venn(
    area1 = individual_sum[which(individual_sum$program == level),]$uses_lay_tools,
    area2 = individual_sum[which(individual_sum$program == level),]$uses_gp_tools,
    area3 = individual_sum[which(individual_sum$program == level),]$uses_ds_tools,
    n12 = lay_gp_sum[which(lay_gp_sum$program == level),]$uses_lay_tools,
    n23 = gp_ds_sum[which(gp_ds_sum$program == level),]$uses_gp_tools,
    n13 = ds_lay_sum[which(ds_lay_sum$program == level),]$uses_ds_tools,
    n123 = lay_gp_ds_sum[which(lay_gp_ds_sum$program == level),]$uses_ds_tools,
    category = c('uses_lay_tools', 'uses_gp_tools', 'uses_ds_tools'),
    lty = 'blank',
    fill = c('skyblue', 'pink1', 'mediumorchid'))
  }

}

# Expects data sd output from SkillsData()
# venns <- SkilldsDataDiagrams2(td)
# plot(venns[[1]])
SkillsDataDiagrams2 <- function(sd)
{
  library(venneuler)

  # repeat
  individual_sum <- aggregate(. ~ program, data=sd, sum)
  lay_gp_sum <- aggregate(uses_lay_tools ~ program, data=subset(sd, uses_lay_tools & uses_gp_tools), sum)
  gp_ds_sum <- aggregate(uses_gp_tools ~ program, data=subset(sd, uses_gp_tools & uses_ds_tools), sum)
  ds_lay_sum <- aggregate(uses_ds_tools ~ program, data=subset(sd, uses_ds_tools & uses_lay_tools), sum)
  lay_gp_ds_sum <- aggregate(uses_ds_tools ~ program, data=subset(sd, uses_lay_tools & uses_gp_tools & uses_ds_tools), sum)

  # probably a better way to do this using apply()
  venns <- list()
  for (level in levels(sd$program))
  {
    area1 <- individual_sum[which(individual_sum$program == level),]$uses_lay_tools
    area2 <- individual_sum[which(individual_sum$program == level),]$uses_gp_tools
    area3 <- individual_sum[which(individual_sum$program == level),]$uses_ds_tools
    n12 <- lay_gp_sum[which(lay_gp_sum$program == level),]$uses_lay_tools
    n23 <- gp_ds_sum[which(gp_ds_sum$program == level),]$uses_gp_tools
    n13 <- ds_lay_sum[which(ds_lay_sum$program == level),]$uses_ds_tools
    n123 <- lay_gp_ds_sum[which(lay_gp_ds_sum$program == level),]$uses_ds_tools
    venns <- c(venns, list(venneuler(c(A=area1, B=area2, C=area3, "A&B"=n12, "B&C"=n23, "A&C"=n13, "A&B&C"=n123))))
  }
  return(venns)
}

# Expects data sd output from SkillsData()
# pies <- SkilldsDataDiagrams3(td)
# plot(pies[[1]])
SkillsDataDiagrams3 <- function(sd)
{
  library(ggplot2)
}