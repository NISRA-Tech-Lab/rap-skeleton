
# configuration script


#### INPUTS AND SETTINGS ####

##### SETTINGS #####

# a space for project level flags or inputs

##### DATES  #####
# Specify your publication dates 
# *****THESE SHOULD BE UPDATED FOR EACH NEW PUBLICATION****

pub_date = "1 March 2023"
next_pub_date = "1 April 2023"

##### HEADER ######
statistic_type = "ex" # options: ns (National Statistic), os (Official Statistics), ex (Experimental Statistics)

header_publisher = "Dissemination Branch, Northern Ireland Statistics & Research Agency"
header_contact = "Dissemination Branch"
header_telephone = "028 XX XXXXXX"
header_email = "contact@nisra.gov.uk"

header_theme = "Population and Migration"
header_coverage = "Northern Ireland"
header_frequency = "Ad-Hoc"


#### INSTALL PACKAGES  ####
# check for presence of required packages and if necessary, install and then load each

library(markdown)
library(broom)
library(rmarkdown)
library(yaml)
library(dplyr)
library(tidyr)
library(stringr)
library(forcats)
library(xfun)
library(htmltools)
library(openxlsx)
library(readxl)
library(lubridate)
library(plotly)
library(here)
library(kableExtra)
library(scales)
library(ggrepel)
library(DT)
library(AMR)
library(ggpubr)
library(sf)
library(tmap)
library(htmltools)
library(formattable)


# turn off warning messages
options(warn=-1)


#### DERIVED TEXT ####

statistic_type_text = case_when(statistic_type == "ns" ~ "National Statistic", 
                                statistic_type == "os" ~ "Official Statistic",
                                statistic_type == "ex" ~ "Experimental Statistic",
                                TRUE ~ "[UNDEFINED statistic_type_text]")

#### DERIVE GLOBAL DATES  ####

# convert to lubridate
pub_date = parse_date_time(pub_date, orders = "dmY")
folder_year= format(pub_date, "%Y")
folder_month = format(pub_date, "%m")



# key info used for subtitle
pub_date_words_dmy = format(pub_date,"%d %B %Y")
pub_date_words_my = format(pub_date,"%B-%Y")
subtitle = paste("Published:",pub_date_words_dmy)

# update pub_date to 1st of month
day(pub_date) = 1

# set reusable dates
# this_month refers to the month of the date e.g. publication date Dec 21, data is Nov 21 (this_month = Nov 21)
# lubridate version
this_month = pub_date-months(1)
last_month = pub_date-months(2)
last_year = pub_date-months(13) 


#### CONFIGURE FOLDER PATHS #####
# configure the 'root' folder of the project
project_root = here()

data_source_root = paste0(project_root, "/data/inputs/", folder_year, "/", folder_month,"/")
outputs_source_root = paste0(project_root, "/outputs/")
code_source_root = paste0(project_root, "/code/")

# set folder for images for HTML output
images_source_root = paste0(project_root, "/data/images/")


# folder for csv and excel files created for chart downloads
dataDir = paste0(outputs_source_root, "figdata/")

# create folder for download button csv and excel files if it doesn't already exist
ifelse(!dir.exists(dataDir), dir.create(dataDir), "figdata folder already exists") 


#### NISRA COLOURS AND LOGOS ####
##### LOGOS #####

# NISRA logo
nisraLogo = base64enc::dataURI(file = paste0(images_source_root,"NISRA-full-name-stacked-white.png"))
nisraAlt = "NISRA logo"

# if not knitting, will set nicstheme to dof
if(!exists("params")) { 
  params = list(nicstheme = "dof", prerelease = FALSE)
  
  } 

# Departmental logo
depLogo = base64enc::dataURI(file = paste0(images_source_root,"dept_logos/logo-white-", params$nicstheme, ".png"))
depAlt = "DoF logo"

# National Stats logo
natStats = base64enc::dataURI(file = paste0(images_source_root,"NatStats.png"))
natAlt = "National Statistics logo"


##### COLOURS #####
nisra_blue = "#3878c5"
nisra_navy = "#00205b"
nisra_green = "#CEDC20"
nisra_lightblue = "#d9e7ff"
nisra_darkgreen = "#474c00"

ons_blue = "#12436d"
ons_green = "#28a197"
ons_red = "#801650"
ons_orange = "#f46a25"

#### CALL & LOAD FUNCTIONS SCRIPTS ####
for (file in list.files(path = paste0(code_source_root,"functions"))) {
  source(paste0(code_source_root,"functions/", file))
}
