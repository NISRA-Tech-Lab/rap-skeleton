# Set folder path
library(here)

# Read config file
source(paste0(here(), "/code/config.R"))


#### Read data in ####

# Unhash as necessary (Ctrl + Shift + C)

## Read csv file
# dfexample = read.csv(paste0(here(),
#   "enter your data file here"))


## Read xlsx file
# dfexample <- read_excel(paste0(here(),"enter your data file here"),
#                         sheet = "enter sheet name here")


## Read in SPSS (.sav) files
# dfexample <- read.spss(paste0(here(), "enter file name here"),
#                          sheet = "Enter sheet name",
#                          to.data.frame = TRUE)


## SQL Code
# Set up the connection to the SQL Server database
# con <<- dbConnect(odbc(),
#                   Driver = "SQL Server",
#                   Server = "Enter your server name",
#                   Database = "Enter the database name",
#                   Trusted_Connection = "True")
#
# Read SQL table
# dfexample <- dbGetQuery(con, 'select *
#                              from dbo.table_name;')



#### Create some variables for use in code and Rmd ####
#### Read Maps in ####


#### Create lgd data for maps ####


#### Add dfs for tables and charts ####
