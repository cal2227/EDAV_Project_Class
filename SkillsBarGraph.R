# Expects data td output from tidydata.R
SkillsBarGraph <- function(td)
{
  #library(ggplot2)

  programs_idx <- 2

  # lay_tools <- c("Excel", "dropbox", "google drive (formerly docs)")
  lay_tools_idx <- c(13, 19, 20)
  # cs_tools <- c("SQL", "Python", "regular_expressions (grep)", "Github", "shell (terminal / command line)", "Web: html css js", "XML", "C/C++")
  cs_tools_idx <- c(14, 17, 21, 22, 23, 26, 27)
  # ds_tools <- c("R", "RStudio", "ggplot2", "Stata", "Sweave/knitr", "Matlab", "SPSS", "lattice")
  ds_tools_idx <- c(12, 15, 16, 18, 25, 29, 30, 31)

  # Indicate if row contains at least one real value in skills subset
  skills_predicate <- function(df, skills)
  {
    return(apply(!is.na(df[,skills]), 1, any))
  }
  #uses_ds_tools <- apply(!is.na(td[,ds_tools_idx]), 1, any)
  uses_ds_tools <- skills_predicate(td, ds_tools_idx)
  #uses_cs_tools <- apply(!is.na(td[,cs_tools_idx]), 1, any)
  uses_cs_tools <- skills_predicate(td, cs_tools_idx)
  #uses_lay_tools <- apply(!is.na(td[,lay_tools_idx]), 1, any)
  uses_lay_tools <- skills_predicate(td, lay_tools_idx)

  skills_df <- data.frame("program" = td[,programs_idx],
                          uses_ds_tools,
                          uses_cs_tools,
                          uses_lay_tools)

  # summary stats
  aggregate(uses_ds_tools ~ program, data = sdf, sum)
  aggregate(uses_cs_tools ~ program, data = sdf, sum)
  aggregate(uses_lay_tools ~ program, data = sdf, sum)

  return(skills_df)

}