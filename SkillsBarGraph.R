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

  sdf <- data.frame("program" = td$program,uses_lay_tools, uses_gp_tools, uses_ds_tools)

  # summary stats
  # aggregate(uses_ds_tools ~ program, data = sdf, sum)
  # aggregate(uses_gp_tools ~ program, data = sdf, sum)
  # aggregate(uses_lay_tools ~ program, data = sdf, sum)

  return(sdf)

}

# Expects data sd output from SkillsData()
SkillsDataGraph <- function(sd)
{
  library(ggplot2)
}