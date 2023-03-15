# Demo specific configuration

library(here)

source(paste0(here(),"/code/config.R"))

#### INPUTS AND SETTINGS ####
##### SETTINGS #####

report_final = FALSE

# set folder for images for HTML demo output
images_source_root_demo = paste0(project_root, "/code/demo/demo_data/images/")

outputs_source_root_demo = paste0(project_root, "/code/demo/demo_outputs/")

ifelse(!dir.exists(outputs_source_root_demo), dir.create(outputs_source_root_demo), "Outputs folder exists already")


demo_data_dir <- paste0(outputs_source_root_demo, "figdata/")
# folder for download button csv and excel files
ifelse(!dir.exists(demo_data_dir), dir.create(demo_data_dir), "demo figdata folder exists already") 

# check if demo excel tables exist. Used in demo_report to embed files
demo_excel_ready <- file.exists(paste0(outputs_source_root_demo, "RAP_demo_tables.xlsx"))