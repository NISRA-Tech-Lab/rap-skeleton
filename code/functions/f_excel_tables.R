f_excel_table <- function (title, df, sheet, table_name) {
  
r <- 1

  writeData(new_workbook, sheet = sheet,
          x = paste0(title),
          startRow = r,
          colNames = FALSE)

addStyle(new_workbook, sheet,
         style = pt,
         rows = r,
         cols = 1)

r <- r + 1

writeDataTable(new_workbook, sheet = sheet,
               x = df,
               startRow = r,
               tableStyle = "none",
               tableName = table_name,
               withFilter = FALSE,
               bandedRows = FALSE,
               headerStyle = ch,
               keepNA = TRUE)

# Applies style to cells of table
addStyle(new_workbook, sheet = sheet,
         style = chl,
         rows = r,
         cols = 1)

addStyle(new_workbook, sheet = sheet,
         style = ns,
         rows = r+1:(r + nrow(df)),
         cols = 2:length(df),
         gridExpand = TRUE)

# Iterates r to below table
r <- r + nrow(df) + 2

}

# function to add a single table to an excel worksheet. 
#Required parameters are title, info (accessibility requirement), dataframe(df), sheet and tablename

f_single_excel <- function(title, info, notes = c(NA), df, sheet, tablename, num_cols = NA,
                           pct_cols = NA) {
  
  r <- 1

writeData(new_workbook, sheet = sheet,
          x = paste0(title),
          startRow = r,
          colNames = FALSE)

addStyle(new_workbook, sheet,
         style = pt,
         rows = r,
         cols = 1)

r <- r + 1

writeData(new_workbook, sheet = sheet,
          x = paste0(info),
          startRow = r,
          colNames = FALSE)

r <- r + 1
if(is.na(notes[1])){
 
  
} else {
 
  
  writeData(new_workbook, sheet = sheet,
            x = paste0(notes),
            startRow = r,
            colNames = FALSE)
  
  addStyle(new_workbook, sheet = sheet,
           style = pt2,
           rows = r,
           cols = 1)
  
  r <- r + length(notes)
  
}

writeDataTable(new_workbook, sheet = sheet,
               x = df,
               startRow = r,
               tableStyle = "none",
               tableName = tablename,
               withFilter = FALSE,
               bandedRows = FALSE,
               headerStyle = ch,
               keepNA = TRUE)

# Applies style to cells of table
addStyle(new_workbook, sheet = sheet,
         style = chl,
         rows = r,
         cols = 1)

addStyle(new_workbook, sheet = sheet,
         style = ns,
         rows = r+1:(r + nrow(df)),
         cols = num_cols,
         gridExpand = TRUE)

addStyle(new_workbook, sheet = sheet,
         style = ns_percent,
         rows = r+1:(r + nrow(df)),
         cols = pct_cols,
         gridExpand = TRUE)

}



# # Style for Table titles
# ts2 <- createStyle(textDecoration = "bold")
# 
# #Style for numbers
# fs <- createStyle(numFmt = "#,##0",
#                   halign = "right")
# 
# # Style for column headers
# hs <- createStyle(halign = "right",
#                   wrapText = TRUE,
#                   textDecoration = "bold")
# 
# hs2 <- createStyle(halign = "left",
#                    wrapText = TRUE,
#                    textDecoration = "bold")
