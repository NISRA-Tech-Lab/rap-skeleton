# ##############################################################################
# f_excel_tables.R
# function to add a single table to an excel worksheet.
# Required parameters are title, info (accessibility requirement),
# dataframe(df), sheet and tablename
# #############################################################################

f_single_excel <- function(
  title,
  info,
  notes = NA,
  df,
  sheet,
  tablename,
  num_cols = NA,
  pct_cols = NA
) {
  r <- 1

  writeData(
    new_workbook,
    sheet = sheet,
    x = title,
    startRow = r,
    colNames = FALSE
  )

  addStyle(
    new_workbook,
    sheet = sheet,
    style = page_title,
    rows = r,
    cols = 1
  )

  r <- r + 1

  writeData(
    new_workbook,
    sheet = sheet,
    x = info,
    startRow = r,
    colNames = FALSE
  )

  r <- r + 1

  if (!is.na(notes[1])) {
    writeData(
      new_workbook,
      sheet = sheet,
      x = notes,
      startRow = r,
      colNames = FALSE
    )

    addStyle(
      new_workbook,
      sheet = sheet,
      style = page_title_bold,
      rows = r,
      cols = 1
    )

    r <- r + length(notes)
  }

  writeDataTable(
    new_workbook,
    sheet = sheet,
    x = df,
    startRow = r,
    tableStyle = "none",
    tableName = tablename,
    withFilter = FALSE,
    bandedRows = FALSE,
    headerStyle = column_header_right,
    keepNA = TRUE
  )

  # Applies style to cells of table
  addStyle(
    new_workbook,
    sheet = sheet,
    style = column_header_left,
    rows = r,
    cols = 1
  )

  if (!all(is.na(num_cols))) {
    addStyle(
      new_workbook,
      sheet = sheet,
      style = ns_comma,
      rows = (r + 1):(r + nrow(df)),
      cols = num_cols,
      gridExpand = TRUE
    )
  }

  if (!all(is.na(pct_cols))) {
    addStyle(
      new_workbook,
      sheet = sheet,
      style = ns_percentage,
      rows = (r + 1):(r + nrow(df)),
      cols = pct_cols,
      gridExpand = TRUE
    )
  }
}
