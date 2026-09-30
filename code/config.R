# configuration script

#### INPUTS AND SETTINGS ####

##### SETTINGS #####

# Set Report parameters, name of department, pre release status and logo type

nics_theme <- "dof"
prerelease <- FALSE
bilingual <- TRUE

###### parameter options:
#  nics_theme - can be any of teo, daera, dfc, de, dfe, dof, dfi, doh, doj, bso
#  prerelease - can be TRUE or FALSE
#  bilingual - can be TRUE or FALSE - Sets language for NISRA Logo

##### YEAR OF DATA & REPORT TITLE  #####

# Specify the current year your data is for.
# Set the report title and subtitle if required
# THESE SHOULD BE UPDATED FOR EACH NEW PUBLICATION

current_year <- 2024

title <- "NISRA Technology and Support Lab RAP Skeleton Demo Report"

subtitle <- "Version Two"

##### HEADER ######

# Select the Statistic type for the report - select from the list of five below

statistic_type <- "as"

# options:
# as  (Accredited Official Statistics)
# os  (Official Statistics)
# osd (Official Statistics in Development)
# mi  (Management Information)
# rr  (Research Report)

# Set the report publication data and next publication data if required

pub_date <- "10 June 2024"
next_pub_date <- "10 June 2025"

##### CONTACT DETAILS #####

# Set contact details for the report - these details will feed into the contact
# function and appear at the bottom of the report above the footer

header_publisher <-
  "Dissemination Branch, Northern Ireland Statistics and Research Agency"

lead_statistician <- "John Smith"
header_telephone <- "028 XX XXXXXX"
header_email <- "contact@nisra.gov.uk"


#### INSTALL PACKAGES  ####

# check for presence of required packages and if necessary,
# install and then load each

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
library(formattable)
library(httpuv)
library(janitor)
library(odbc)
library(DBI)
library(foreign)
library(fontawesome)
library(leaflet)
library(english)
library(knitr)
library(lintr)
library(styler)
library(tinyknit)
library(ggplot2)

# turn off warning messages
options(warn = -1)


#### DERIVED TEXT ####

statistic_type_text <- case_when(
  statistic_type == "as" ~ "Accredited Official Statistics",
  statistic_type == "os" ~ "Official Statistics",
  statistic_type == "osd" ~ "Official Statistics in Development",
  statistic_type == "mi" ~ "Management Information",
  statistic_type == "rr" ~ "Research Report",
  TRUE ~ "[UNDEFINED statistic_type_text]"
)


#### DERIVE GLOBAL DATES  ####

# convert to lubridate
pub_date <- parse_date_time(
  pub_date,
  orders = "dmY"
)

folder_year <- format(
  pub_date,
  "%Y"
)

folder_month <- format(
  pub_date,
  "%m"
)

# create pub_date in different formats
pub_date_words_dmy <- format(
  pub_date,
  "%d %B %Y"
)

pub_date_words_my <- format(
  pub_date,
  "%B-%Y"
)

# update pub_date to 1st of month
day(pub_date) <- 1

# set reusable dates - this_month refers to the month of the date
# e.g. publication date Dec 21, data is Nov 21 (this_month = Nov 21)
# lubridate version
this_month <- pub_date - months(1)
last_month <- pub_date - months(2)
last_year <- pub_date - months(13)

## Get date last updated time for the report

last_updated <- Sys.Date()

last_updated_formatted <- format(
  last_updated,
  "%d %B %Y"
)


#### CONFIGURE FOLDER PATHS FOR DOWNLOAD BUTTONS #####

# create folder for download button csv and excel files if it doesn't exist
if (!dir.exists(
  here("outputs")
)) {
  dir.create(
    here("outputs")
  )
}

if (!dir.exists(
  here(
    "outputs",
    "figdata"
  )
)) {
  dir.create(
    here(
      "outputs",
      "figdata"
    )
  )
}


#### NISRA COLOURS AND LOGOS ####

##### LOGOS #####

# NISRA logo
if (bilingual == TRUE) {
  nisra_logo <- here(
    "data",
    "images",
    "nisra-only-white.svg"
  )
} else {
  nisra_logo <- here(
    "data",
    "images",
    "nisra-only-white.svg"
  )
}

nisra_logo <- paste0(
  "data:image/svg+xml,",
  readLines(
    nisra_logo
  ) |>
    paste(
      collapse = " "
    ) |>
    encodeURIComponent()
)

nisra_alt <- "NISRA logo, links to NISRA homepage"

# Departmental logo
dep_logo <- encodeURIComponent(
  here(
    "data",
    "images",
    "dept_logos",
    paste0(
      "logo-white-unstacked-",
      nics_theme,
      ".svg"
    )
  )
)

dep_alt <- paste(
  toupper(nics_theme),
  "logo, links to",
  toupper(nics_theme),
  "homepage"
)

# Accredited Official Statistics logo
acc_official_stats <- paste0(
  "data:image/svg+xml,",
  readLines(
    here(
      "data",
      "images",
      "Accredited_Official_Statistics_Logo_English.svg"
    )
  ) |>
    paste(
      collapse = " "
    ) |>
    encodeURIComponent()
)

nat_alt <- "Accredited Official Statistics logo"

rel_path <- paste0(
  here(
    "data",
    "images"
  ),
  "/"
)


##### COLOURS #####

nisra_green_decoration <- "#CEDC20"
nisra_blue <- "#3878c5"
nisra_navy <- "#00205b"
nisra_col3_green <- "#68a41e" # needs black text
nisra_col4_purple <- "#732777"
nisra_col5_lilac <- "#ce70d2" # needs black text
nisra_col6_olive <- "#434700"
nisra_col7_brown <- "#A88F8F"
nisra_col8_slate <- "#3b3b3b"
nisra_col9_pink <- "#e64791"
nisra_col10_burgandy <- "#400b23"

ons_blue <- "#12436d"
ons_green <- "#28a197"
ons_red <- "#801650"
ons_orange <- "#f46a25"


#### CALL & LOAD FUNCTIONS SCRIPTS ####

for (file in list.files(
  path = here(
    "code",
    "functions"
  )
)) {
  source(
    here(
      "code",
      "functions",
      file
    )
  )
}

utils::globalVariables(
  c(
    "new_workbook",
    ".",
    "report_final"
  )
)
