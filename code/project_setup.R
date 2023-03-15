#### RUN THIS SCRIPT BEFORE ANY OTHERS ####

# check list of packages and install if needed before loading
# if package already installed will be loaded
f_install_and_load_packages <- function(packages) {
  installed_packages <- rownames(installed.packages())
  packages_to_install <- packages[!packages %in% installed_packages]
  
  if (length(packages_to_install) > 0) {
    message(paste0("Installing packages: ", paste(packages_to_install, collapse = ", ")))
    install.packages(packages_to_install)
  } else {
    message("All packages already installed.")
  }
  
  # load all packages, whether newly installed or not
  for (pkg in packages) {
    library(pkg, character.only = TRUE, quietly = TRUE)
  }
}

f_install_and_load_packages(c("dplyr","tidyr", "stringr","forcats","xfun","htmltools",
                            "openxlsx","readxl","lubridate","plotly","here","kableExtra",
                            "scales","ggrepel","DT","AMR","ggpubr","sf","tmap","htmltools",
                            "formattable","here"))

