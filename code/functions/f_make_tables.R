# ##############################################################################
# f_make_tables.R
# Creates downloadable CSV and Excel files from data frames with formatted  
# tables, generates download buttons for embedding in report
# #############################################################################


f_make_tables <- function(data,
                          title,
                          footnotes = NA,
                          data_style = ns_comma,
                          data_dir = here("outputs/figdata")) {
  require(openxlsx)
  require(janitor)
  require(htmltools)
  require(xfun)

  # Sheet name for excel is generated as everything before the : in title
  sheet <- gsub("(.*):.*", "\\1", title)

  # File name generated from sheet name

  csv_file <- sub(" ", "-", tolower(paste0(
    "TL-demo-", sheet, "-",
    pub_date_words_my, ".csv"
  )))
  excel_file <- sub(".csv", ".xlsx", csv_file, fixed = TRUE)


  # Write the dataframe to the csv file
  write.table(data,
    file = here(data_dir, csv_file),
    append = FALSE,
    sep = ",",
    row.names = FALSE
  )

  # Write the excel file
  # Creates a new excel workbook
  wb <- createWorkbook(
    creator = "Tech Lab",
    title = title,
    subject = "Metadata subject",
    category = "Metadata category"
  )

  modifyBaseFont(wb, fontSize = 12, fontName = "Arial")

  # Adds a sheet
  addWorksheet(wb, sheet)

  r <- 1

  # Adds a title
  writeData(wb, sheet, title, startCol = 1, startRow = r)

  addStyle(wb,
    sheet = as.character(sheet),
    style = ts,
    rows = r,
    cols = 1
  )

  r <- r + 1

  writeData(wb, sheet, "Source: My data source", startCol = 1, startRow = r)

  r <- r + 1

  if (!is.na(footnotes)) {
    writeData(wb, sheet, c("Notes:", footnotes),
      startCol = 1, startRow = r
    )

    r <- r + 1 + length(footnotes)
  }



  # Adds the dataframe
  writeDataTable(wb, sheet, data,
    startCol = 1, startRow = r, colNames = TRUE,
    tableName = paste0("table_", sub("^\\D*(\\d+).*$", "\\1", title)),
    withFilter = FALSE,
    bandedRows = FALSE,
    tableStyle = "none",
    headerStyle = hs
  )

  addStyle(wb,
    sheet = as.character(sheet),
    style = hs2,
    rows = r,
    cols = 1
  )

  addStyle(wb,
    sheet = as.character(sheet),
    style = la,
    rows = r + seq_len(nrow(data)),
    cols = 1,
    gridExpand = TRUE
  )


  addStyle(wb,
    sheet = as.character(sheet),
    style = data_style,
    rows = r + seq_len(nrow(data)),
    cols = 2:ncol(data),
    gridExpand = TRUE
  )

  # Source is added below last table

  setColWidths(wb, sheet, cols = 1, widths = 28)
  setColWidths(wb, sheet, cols = 2:length(data), widths = 14)

  # Workbook saved
  saveWorkbook(wb, here(data_dir, excel_file), overwrite = TRUE)

  csv_size <- round_half_up(file.size(here(data_dir, csv_file)) / 1000)

  csv_size <- if (csv_size == 0) {
    "1kB"
  } else {
    paste0(csv_size, "kB")
  }

  xl_size <- paste0(
    round_half_up(file.size(here(data_dir, excel_file)) / 1000),
    "kB"
  )


  em_csv <- embed_file(here(data_dir, csv_file),
    text = paste0(
      sub("fig", "Figure ", sheet),
      ".CSV", " (", csv_size, ")"
    )
  )
  em_xl <- embed_file(here(data_dir, excel_file),
    text = paste0(
      sub("fig", "Figure ", sheet),
      ".XLSX", " (", xl_size, ")"
    )
  )

  buttons <- div(
    div(
      class = "row", style = "display: flex;",
      div(class = "row-indent"),
      div(class = "download", "Download data: ")
    ),
    div(
      class = "row", style = c("display: flex;", "flex-wrap: wrap"),
      div(class = "row-indent"),
      div(class = "csv-button2", em_csv),
      div(
        class = "download",
        style = "padding-top: 7px; margin-top: 40px; padding-left: 5px;
          padding-right: 5px;"
      ),
      div(class = "xl-button2", em_xl),
      div(class = "download", style = "padding-top: 7px; padding-left: 5px;
          padding-right: 5px;")
    )
  )

  # Test html output to ensure correct format (no unformatted html
  # strings appearing in output)
  if (grepl("&lt;", buttons)) {
    buttons <- gsub("&lt;", "<", buttons) %>%
      # Remove escape characters and insert proper < > characters
      gsub("&gt;", ">", .)

    HTML(buttons) # Re-format as HTML string
  } else { # Else render as normal
    buttons
  }
}
