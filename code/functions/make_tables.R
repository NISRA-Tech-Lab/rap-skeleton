f_make_tables <- function (data, title, footnotes = NA, data_style = ns_comma, data_dir = dataDir) {
  

  # Sheet name for excel is generated as everything before the : in title
  sheet <- gsub("(.*):.*", "\\1", title)
  
  # File name generated from sheet name
   
  csvFile = sub(" ", "-", tolower(paste0("TL-demo-",sheet,"-",pub_date_words_my,".csv")))
  excelFile <- sub('.csv', '.xlsx', csvFile, fixed = TRUE)
  
  
  # Write the dataframe to the csv file
  write.table(data,
              file=paste0(data_dir, csvFile),
              append = F,
              sep=',',
              row.names=F)
  
  # Write the excel file
  # Creates a new excel workbook
  wb <- createWorkbook(creator = "Tech Lab",
                       title = title,
                       subject = "Metadata subject",
                       category = "Metadata category")
  
  modifyBaseFont(wb, fontSize = 12, fontName = "Arial")
  
  # Adds a sheet
  addWorksheet(wb, sheet)
  
  r <- 1
  
  # Adds a title
  writeData(wb, sheet, title, startCol = 1, startRow = r)
  
  addStyle(wb, sheet = as.character(sheet),
           style = ts,
           rows = r,
           cols = 1)
  
  r <- r + 1
  
  writeData(wb, sheet, "Source: My data source", startCol = 1, startRow = r)
  
  r <- r + 1
  
  if (!is.na(footnotes)) {
    writeData(wb, sheet, c("Notes:", footnotes),
              startCol = 1, startRow = r)
    
    r = r + 1 + length(footnotes)}
  
  

  # Adds the dataframe
  writeDataTable(wb, sheet, data, startCol = 1, startRow = r, colNames = TRUE,
                 tableName = paste0("table_",sub("^\\D*(\\d+).*$", "\\1", title)),
                 withFilter = FALSE,
                 bandedRows = FALSE,
                 tableStyle = "none",
                 headerStyle = hs)
  
  addStyle(wb, sheet = as.character(sheet),
           style = hs2,
           rows = r,
           cols = 1)
  
  addStyle(wb, sheet = as.character(sheet),
           style = la,
           rows = r+1:nrow(data),
           cols = 1,
           gridExpand = T)
  

  addStyle(wb, sheet = as.character(sheet),
           style = data_style,
           rows = r+1:nrow(data),
           cols = 2:ncol(data),
           gridExpand = T)
  
 # r = r + nrow(data) + 1
  
  
  # Source is added below last table
  
  setColWidths(wb, sheet, cols = 1, widths = 28)
  setColWidths(wb, sheet, cols = 2:length(data), widths = 14)
  
  # Workbook saved
  saveWorkbook(wb, paste0(data_dir, excelFile), overwrite = TRUE)
    

  
  CSVsize <- round(file.size(paste0(data_dir, csvFile)) / 1000)
  
  CSVsize <- if (CSVsize == 0) {
    "1kB"
  } else {
    paste0(CSVsize, "kB")
  }
  
  XLsize <- paste0(round(file.size(paste0(data_dir, excelFile)) / 1000), "kB")
  
  
  emCSV <- embed_file(paste0(data_dir, csvFile), text = paste0(sub("fig", "Figure ", sheet), ".CSV"," (",CSVsize,")"))
  emXL <- embed_file(paste0(data_dir, excelFile), text = paste0(sub("fig", "Figure ", sheet), ".XLSX"," (",XLsize,")"))
  
  div(
    
    div(class = "row", style = "display: flex;",
        div(class = "row-indent"),
        div(class = "download", "Download data: ")),
    
    div(class = "row", style = "display: flex;",
        div(class = "row-indent"),
        div(class = "csv-button2", emCSV),
        div(class="download", style="padding-top: 7px; padding-left: 5px; padding-right: 5px;"),
        div(class = "xl-button2", emXL),
        div(class="download", style="padding-top: 7px; padding-left: 5px; padding-right: 5px;"))
    
    
  )
  
  }
  


