# ##############################################################################
# f_worksheet.R
# Adds a formatted worksheet to an Excel workbook for single or multiple tables,
# creates contents page links and applies consistent styling throughout
# #############################################################################


f_worksheet <- function(
  wb,
  sheet_name,
  contents,
  title,
  outlining,
  tables
) {
  addWorksheet(
    wb,
    sheetName = sheet_name
  )

  r <- 1

  writeData(
    wb,
    sheet_name,
    x = title,
    startRow = r
  )

  addStyle(
    wb,
    sheet_name,
    rows = r:(r + length(title) - 1),
    cols = 1,
    style = page_title,
    gridExpand = TRUE
  )

  setRowHeights(
    wb,
    sheet_name,
    rows = r:(r + length(title) - 1),
    heights = 30
  )

  r <- r + length(title)

  if (length(tables) == 1) {
    writeData(
      wb,
      sheet_name,
      x = paste("This worksheet contains one table,", outlining),
      startRow = r
    )
  } else {
    writeData(
      wb,
      sheet_name,
      x = paste(
        "This worksheet contains",
        english(length(tables)),
        "tables, presented vertically with one blank row in between,",
        outlining
      ),
      startRow = r
    )
  }

  r <- r + 1

  if (length(tables) > 1) {
    writeData(
      wb,
      "Contents",
      contents,
      startRow = cr
    )

    addStyle(
      wb,
      "Contents",
      style = page_title_bold,
      rows = cr,
      cols = 1
    )

    setRowHeights(
      wb,
      "Contents",
      rows = cr,
      heights = 30
    )

    cr <<- cr + 1
  }

  for (i in seq_along(tables)) {
    table_name <- tables[[i]]$title |>
      sub(
        pattern = ":.*",
        replacement = ""
      ) |>
      sub(
        pattern = " ",
        replacement = "_"
      ) |>
      tolower()

    if (length(tables) > 1) {
      writeData(
        wb,
        sheet_name,
        tables[[i]]$title,
        startRow = r
      )

      addStyle(
        wb,
        sheet_name,
        rows = r,
        cols = 1,
        style = page_title_bold
      )

      setRowHeights(
        wb,
        sheet_name,
        rows = r,
        heights = 30
      )

      r <- r + 1
    }

    if ("note" %in% names(tables[[i]])) {
      note_lines <- as.character(tables[[i]]$note)
      writeData(
        wb,
        sheet_name,
        x = note_lines,
        startRow = r
      )
      r <- r + length(note_lines)
    }

    writeDataTable(
      wb,
      sheet_name,
      x = tables[[i]]$data,
      startRow = r,
      headerStyle = column_header_lined_right,
      tableStyle = "none",
      withFilter = FALSE,
      tableName = table_name,
      keepNA = TRUE,
      na.string = "No data"
    )

    addStyle(
      wb,
      sheet_name,
      rows = r,
      cols = 1,
      style = column_header_lined_left
    )

    addStyle(
      wb,
      sheet_name,
      rows = (r + 1):(r + nrow(tables[[i]]$data) - 1),
      cols = 2:(ncol(tables[[i]]$data)),
      style = ns_comma,
      gridExpand = TRUE
    )

    # To make the bottom row of tables bold change the style below to "ns_bold"
    addStyle(
      wb,
      sheet_name,
      rows = (r + nrow(tables[[i]]$data)),
      cols = 2:(ncol(tables[[i]]$data)),
      style = ns_comma,
      gridExpand = TRUE
    )

    addStyle(
      wb,
      sheet_name,
      rows = (r + 1):(r + nrow(tables[[i]]$data)),
      cols = 1,
      style = page_title_bold
    )

    na_positions <- which(
      is.na(tables[[i]]$data),
      arr.ind = TRUE
    )

    if (nrow(na_positions) > 0) {
      addStyle(
        wb,
        sheet_name,
        rows = r + na_positions[, "row"],
        cols = 1 + na_positions[, "col"],
        style = white_text,
        gridExpand = FALSE
      )
    }

    table_title <- sub(
      " \\[Note.*",
      "",
      tables[[i]]$title
    )

    writeFormula(
      wb,
      "Contents",
      x = makeHyperlinkString(
        sheet = sheet_name,
        row = r,
        col = 1,
        text = if (length(tables) > 1) table_title else contents
      ),
      startRow = cr
    )

    addStyle(
      wb,
      "Contents",
      rows = cr,
      cols = 1,
      style = if (length(tables) > 1) indent else page_title_bold,
      stack = TRUE
    )

    setRowHeights(
      wb,
      "Contents",
      rows = cr,
      heights = 30
    )

    cr <<- cr + 1

    r <- r + nrow(tables[[i]]$data) + 2
  }

  setColWidths(
    wb,
    sheet_name,
    cols = seq_len(ncol(tables[[1]]$data)),
    widths = c(27, rep(12, ncol(tables[[1]]$data) - 1))
  )
}
