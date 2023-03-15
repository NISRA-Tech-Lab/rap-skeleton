# Creates table outputs of the data in xlsx file

library(here)

# Creating spreadsheets
source(paste0(here(),"/code/config.R"))
source(paste0(here(),"/code/demo/demo_data_prep.R"))
source(paste0(here(),"/code/demo/demo_config.R"))

# naming output file
output_file <- paste0("code/demo/demo_outputs/RAP_demo_tables.xlsx")



#### create new workbook ####

new_workbook <- createWorkbook(creator = "Tech Lab",
                               title = "Demonstration tables")

# set basic formatting
modifyBaseFont(new_workbook, fontSize = 12, fontName = "Arial")



#### Cover sheet ####

addWorksheet(new_workbook, sheetName = "Cover sheet")

# add info for cover sheet

df_cover_info <- c("Mid-year population statistics for Northern Ireland 2022",
                   "The following tables contain population and demography statistics for Northern Ireland",
                   "Issued by",
                   "Tech Lab",
                   "Colby House",
                   "Belfast",
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
email <- "mailto:techlab@nisra.gov.uk" 
names(email) <- "techlab@nisra.gov.uk"
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
                "Table 3",
                "Table 3",
                "Notes")

# create a vector of table numbers
table_nos <- c("Table 1",
               "Table 2",
               "Table 3a",
               "Table 3b",
               "Notes")

# table titles
t1_title <- paste0("Table 1: Northern Ireland mid-year population estimates by age group and sex, ",latest_year)
t2_title <- "Table 2: Mid-year estimates of population aged under 25s by Local Government District (LGD)"
t3a_title <- paste0("Population of young people by LGD in NI ", latest_year)
t3b_title <- paste0("Population of elderly people by LGD in NI ", latest_year)
notes_title <- "Notes table"

# create a vector of table titles
table_titles <- c(t1_title,
                  t2_title,
                  t3a_title,
                  t3b_title,
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
             x = '=HYPERLINK("#Table_3!A4", "Table 3a")',
             startCol = 2, startRow = 5)
writeFormula(new_workbook, "Contents",
             x = '=HYPERLINK("#Table_3!A18", "Table 3b")',
             startCol = 2, startRow = 6)
writeFormula(new_workbook, "Contents",
             x = '=HYPERLINK("#notes!A3", "Notes")',
             startCol = 2, startRow = 7)

setColWidths(new_workbook, "Contents", cols = c(1, 2, 3), widths = c(20, 15, 120))
setRowHeights(new_workbook, "Contents", rows = 2, heights = 40)



#### Table 1 ####

addWorksheet(new_workbook, sheetName = "Table_1")


t1_info <- c("This worksheet contains 1 table of population data")

t1_notes <- c("Notes",
              "These estimates are produced using a variety of data sources and statistical models")


sheet = "Table_1"

f_single_excel(title = t1_title,
               info = t1_info,
               notes = t1_notes, # change to NA if no notes required
               df = df_t1_ss,
               sheet = sheet,
               tablename = "T_1",
               num_cols = 2:5, # col numbers requiring thousand separator
               pct_cols = NA) # col numbers of percentages with 1 decimal place


setRowHeights(new_workbook, sheet = "Table_1", rows = 5, heights = 30)



#### Table 2 ####

addWorksheet(new_workbook, sheetName = "Table_2")

t2_info <- "This worksheet contains 1 table of population data. Any additional notes referenced in the tables are found on the notes sheet"

t2_notes <- c("Notes",
              "The estimates are produced using a variety of data sources and statistical models",
              "Population aged under 25 on survey date")


# write to worksheet

f_single_excel(title = t2_title,
               info = t2_info,
               notes = t2_notes,
               df = df_t2_ss,
               sheet = "Table_2",
               tablename = "T_2",
               num_cols = c(2,3),
               pct_cols = 4)


setRowHeights(new_workbook, sheet = "Table_2", rows = 6, heights = 30)
setColWidths(new_workbook, sheet = "Table_2", cols = c(1,2,3,4), widths = c(30,13,13,13))



#### Tables 3a and 3b ####

# sheet with multiple tables coded without using the function as demo

addWorksheet(new_workbook, sheetName = "Table_3")

t3_sheet_title <- paste0("Population of under 25s and over 65s by LGD ", latest_year)
t3_info <- "This worksheet contains 2 tables of population data presented vertically separated by a single blank row"

t3a_titlerow <- 3
t3a_row <- t3a_titlerow + 1
t3b_titlerow <- t3a_row + nrow(df_t3a_ss) + 2
t3b_row <- t3b_titlerow + 1

# write titles and info to worksheet
writeData(new_workbook, sheet = "Table_3",
          x = t3_sheet_title,
          startRow = 1,
          colNames = FALSE)

writeData(new_workbook, sheet = "Table_3",
          x = t3_info,
          startRow = 2,
          colNames = FALSE)

writeData(new_workbook, sheet = "Table_3",
          x = t3a_title,
          startRow = t3a_titlerow,
          colNames = FALSE)

writeData(new_workbook, sheet = "Table_3",
          x = t3b_title,
          startRow = t3b_titlerow,
          colNames = FALSE)

# apply styles to titles
addStyle(new_workbook, sheet = "Table_3",
         style = pt,
         rows = 1, cols = 1)

addStyle(new_workbook, sheet = "Table_3",
         style = pt2,
         rows = c(t3a_titlerow, t3b_titlerow),
         cols = 1)

# write tables to worksheet
writeDataTable(new_workbook, sheet = "Table_3",
               x = df_t3a_ss,
               startRow = t3a_row,
               startCol = 1,
               colNames = TRUE,
               withFilter = FALSE,
               bandedRows = FALSE,
               tableStyle = "none",
               keepNA = T,
               tableName = "T_3a",
               headerStyle = ch)

writeDataTable(new_workbook, sheet = "Table_3",
               x = df_t3b_ss,
               startRow = t3b_row,
               startCol = 1,
               colNames = TRUE,
               withFilter = FALSE,
               bandedRows = FALSE,
               tableStyle = "none",
               keepNA = T,
               tableName = "T_3b",
               headerStyle = ch)

# left align first column heading
addStyle(new_workbook, sheet = "Table_3",
         style = chl,
         rows = c(t3a_row, t3b_row),
         cols = 1,
         gridExpand = TRUE)

# format numbers with thousand separator
addStyle(new_workbook, sheet = "Table_3",
         style = ns,
         rows = c((t3a_row+1):(t3a_row+nrow(df_t3a_ss)),
                  (t3b_row+1):(t3b_row+nrow(df_t3b_ss))),
         cols = 2:3,
         gridExpand = TRUE)

# format percentage columns to show 1dp
addStyle(new_workbook, sheet = "Table_3",
         style = ns_percent,
         rows = c((t3a_row+1):(t3a_row+nrow(df_t3a_ss)),
                  (t3b_row+1):(t3b_row+nrow(df_t3b_ss))),
         cols = 4,
         gridExpand = TRUE)

# set column widths so that LGD names are visible
setColWidths(new_workbook, sheet = "Table_3", cols = 1, widths = 30)
setRowHeights(new_workbook, sheet = "Table_3", rows = c(t3a_titlerow, t3b_titlerow), heights = 30)



#### Notes sheet ####

addWorksheet(new_workbook, sheetName = "Notes")


note_no <- c("note 1")
notes <- c("Youthrate is percentage of under 25s rounded to 1 decimal place")

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