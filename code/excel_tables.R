# Placeholder for Excel table

library(here)

# Creating spreadsheets
source(paste0(here(),"/code/config.R"))
source(paste0(here(),"/code/data_prep.R"))


# naming output file
output_file <- paste0("outputs/excel_tables.xlsx")

#### create new workbook ####
# update meta data (creator and title)
new_workbook <- createWorkbook(creator = "Dept name",
                               title = "Add theme here")

# set basic formatting
modifyBaseFont(new_workbook, fontSize = 12, fontName = "Arial")

#### Cover sheet ####

addWorksheet(new_workbook, sheetName = "Cover sheet")

# add info for cover sheet

df_cover_info <- c("Main title",
                   "The following tables contain (insert type) statistics for Northern Ireland",
                   "Issued by",
                   "Dept",
                   "Address 1",
                   "Address 2",
                   "Published",
                   pub_date_words_dmy,
                   "Email",
                   "PLACEHOLDER EMAIL")

# write text to worksheet
writeData(new_workbook, sheet = "Cover sheet",
          x = df_cover_info,
          startRow = 1,
          colNames = FALSE)

# email hyperlink and link text
email <- "mailto:contact@nisra.gov.uk" 
names(email) <- "contact@nisra.gov.uk"
class(email) <- "hyperlink"

# # overwrite PLACEHOLDER with hyperlink and link text
writeData(new_workbook, sheet = "Cover sheet",
          x = email,
          startRow = which(df_cover_info == "PLACEHOLDER EMAIL"), colNames = FALSE)


# style headings etc
addStyle(new_workbook, sheet = "Cover sheet",
         style = pt, rows = 1, cols = 1)

addStyle(new_workbook, sheet = "Cover sheet",
         style = pt2, rows = c(3, 7, 9), cols = 1)

addStyle(new_workbook, sheet = "Cover sheet",
         style = tw, rows = 2, cols = 1)

setRowHeights(new_workbook, sheet = "Cover sheet", rows = c(3, 7, 9), heights = 22)
setColWidths(new_workbook, sheet = "Cover sheet", cols = 1, widths = 150)

#### Contents page ####

addWorksheet(new_workbook, sheetName = "Contents")

# create a vector of sheetnames
sheetnames <- c("Table 1",
                "Table 2",
                "Notes")

# create a vector of table numbers
table_nos <- c("Table 1",
               "Table 2",
               "Notes")

# table titles
t1_title <- paste0("Table 1: Title ",latest_year)
t2_title <- "Table 2: Title"
notes_title <- "Notes table"

# create a vector of table titles
table_titles <- c(t1_title,
                  t2_title,
                  notes_title)

# combine into a tibble and set column names
toc <- tibble(sheetnames, table_nos, table_titles)
names(toc) <- c("Worksheet name", "Table number", "Table name")

toc_title <- "Table of contents"

writeData(new_workbook, sheet = "Contents",
          x = toc_title,
          startRow = 1,
          colNames = FALSE)

# format title
addStyle(new_workbook, sheet = "Contents",
         style = pt,
         rows = 1,
         cols = 1)

# paste toc as table
writeDataTable(new_workbook, sheet = "Contents",
               x = toc,
               startRow = 2,
               colNames = TRUE,
               tableStyle = "none",
               tableName = "Table_of_contents",
               withFilter = FALSE,
               bandedRows = FALSE,
               headerStyle = h3)

#format text and set col width
addStyle(new_workbook, sheet = "Contents",
         style = tw,
         rows = 3:35,
         cols = 1:3,
         gridExpand = TRUE)

# add internal hyperlinks to table numbers
writeFormula(new_workbook, "Contents",
             x = '=HYPERLINK("#Table_1!A5", "Table 1")',
             startCol = 2, startRow = 3)
writeFormula(new_workbook, "Contents",
             x = '=HYPERLINK("#Table_2!A6", "Table 2")',
             startCol = 2, startRow = 4)
writeFormula(new_workbook, "Contents",
             x = '=HYPERLINK("#notes!A3", "Notes")',
             startCol = 2, startRow = 5)

setColWidths(new_workbook, "Contents", cols = c(1, 2, 3), widths = c(20, 15, 120))
setRowHeights(new_workbook, "Contents", rows = 2, heights = 40)


#### Table 1 ####

addWorksheet(new_workbook, sheetName = "Table_1")



#### Table 2 ####

addWorksheet(new_workbook, sheetName = "Table_2")


#### Notes sheet ####

addWorksheet(new_workbook, sheetName = "Notes")


note_no <- c("note 1")
notes <- c("Note content")

t_notes <- tibble(note_no, notes)
names(t_notes) <- c("Note number", "Note")

# write title to notes sheet
writeData(new_workbook, sheet = "Notes",
          x = notes_title,
          startRow = 1,
          colNames = TRUE)

# format title
addStyle(new_workbook, sheet = "Notes",
         style = pt,
         rows = 1,
         cols = 1)

# write out notes table 
writeDataTable(new_workbook, sheet = "Notes",
               x = t_notes,
               startRow = 2,
               colNames = TRUE,
               tableStyle = "none",
               tableName = "notes",
               withFilter = FALSE,
               bandedRows = FALSE,
               headerStyle = h3)

setColWidths(new_workbook, sheet = "Notes", cols = c(1, 2), widths = c(15, 100))

#### Save workbook ####
saveWorkbook(new_workbook, output_file, overwrite = TRUE)