# live search of package drive for repo folders
repos <- list.files("//pr-clus-vfpdfp/DOF_NISRA_R_Packages/")
repos <- (grep("^production", repos, value = T))
# add CRAN line to end of repo list
repos <- c(repos, "https://cran.rstudio.com/")
repo_list <- list()

# create list of repo folders to inform options("repos") and options("renv.config.repos.override")
for (i in seq_along(repos)) {
  if (grepl("^https", repos[i])) {
    repo <- repos[i]
  } else {
    repo <- paste0("file:////pr-clus-vfpdfp/DOF_NISRA_R_Packages/", repos[i])
  }

  repo_list[[paste0("TLCRAN", i)]] <- repo
}

names(repo_list)[length(repo_list)] <- "CRAN"

# set renv config repos override option
repo_override <- paste(
  sprintf("%s=%s", names(repo_list), unlist(repo_list)),
  collapse = ";"
)

# Used by renv bootstrap
Sys.setenv(RENV_CONFIG_REPOS_OVERRIDE = repo_override)
# set repos option
options(repos = unlist(repo_list))

# conditional activation of renv
source("renv/activate.R")

# tell renv to prefer binary installs over source
options(renv.config.install.prefer.binary = TRUE)

# reset repos option - cleared by activate
options(repos = unlist(repo_list))

# clear working directory
rm(list = ls())

message(cat(
  "\nWhen setting up renv within this project, you may see error lines printed to console similar to:",
  "\n\nrenv was unable to query available packages from the following repositories:",
  "\n- # file:////pr-clus-vfpdfp/DOF_NISRA_R_Packages/production/src/contrib --------",
  "\n\nThese do not affect the setup of the project and can be ignored"
))
