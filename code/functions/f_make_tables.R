# ##############################################################################
# f_make_tables.R
# Creates downloadable CSV and Excel files from data frames with formatted
# tables, generates download buttons for embedding in report
# #############################################################################


f_make_tables <- function(
  data,
  title,
  footnotes = NA,
  data_style = ns_comma,
  data_dir = here("outputs/figdata"),
  ggplot = FALSE,
  plotly_id = NULL,
  plotly_ids = NULL
) {
  require(openxlsx)
  require(janitor)
  require(htmltools)
  require(xfun)

  # Create the output directory if it does not already exist
  dir.create(
    data_dir,
    recursive = TRUE,
    showWarnings = FALSE
  )

  # Excel sheet name is generated from everything before ":" in the title
  sheet <- gsub("(.*):.*", "\\1", title)

  # Excel worksheet names cannot exceed 31 characters
  sheet <- substr(sheet, 1, 31)

  # Generate output filenames from the sheet name
  csv_file <- gsub(
    " +",
    "-",
    tolower(
      paste0(
        sheet,
        "-",
        pub_date_words_my,
        ".csv"
      )
    )
  )

  excel_file <- sub(
    ".csv",
    ".xlsx",
    csv_file,
    fixed = TRUE
  )

  csv_path <- file.path(data_dir, csv_file)
  excel_path <- file.path(data_dir, excel_file)

  # Write the CSV file
  write.table(
    data,
    file = csv_path,
    append = FALSE,
    sep = ",",
    row.names = FALSE,
    fileEncoding = "utf-16le"
  )

  # Create the Excel workbook
  wb <- createWorkbook(
    creator = "Tech Lab",
    title = title,
    subject = "Metadata subject",
    category = "Metadata category"
  )

  modifyBaseFont(
    wb,
    fontSize = 12,
    fontName = "Arial"
  )

  # Add the worksheet
  addWorksheet(wb, sheet)

  r <- 1

  # Add the title
  writeData(
    wb,
    sheet,
    title,
    startCol = 1,
    startRow = r
  )

  addStyle(
    wb,
    sheet = sheet,
    style = header_14,
    rows = r,
    cols = 1
  )

  r <- r + 1

  # Add the source
  writeData(
    wb,
    sheet,
    "Source: My data source",
    startCol = 1,
    startRow = r
  )

  r <- r + 1

  # Add footnotes when supplied
  if (!all(is.na(footnotes))) {
    writeData(
      wb,
      sheet,
      c("Notes:", footnotes),
      startCol = 1,
      startRow = r
    )

    r <- r + 1 + length(footnotes)
  }

  # Generate a valid Excel table name
  table_number <- sub(
    "^\\D*(\\d+).*$",
    "\\1",
    title
  )

  table_name <- paste0(
    "table_",
    table_number
  )

  # If the title contains no number, create a fallback table name
  if (!grepl("\\d+", title)) {
    table_name <- paste0(
      "table_",
      as.integer(Sys.time())
    )
  }

  # Add the dataframe
  writeDataTable(
    wb,
    sheet,
    data,
    startCol = 1,
    startRow = r,
    colNames = TRUE,
    tableName = table_name,
    withFilter = FALSE,
    bandedRows = FALSE,
    tableStyle = "none",
    headerStyle = column_header_right
  )

  addStyle(
    wb,
    sheet = sheet,
    style = column_header_left,
    rows = r,
    cols = 1
  )

  addStyle(
    wb,
    sheet = sheet,
    style = left_align,
    rows = r + seq_len(nrow(data)),
    cols = 1,
    gridExpand = TRUE
  )

  if (ncol(data) >= 2) {
    addStyle(
      wb,
      sheet = sheet,
      style = data_style,
      rows = r + seq_len(nrow(data)),
      cols = 2:ncol(data),
      gridExpand = TRUE
    )
  }

  # Set column widths
  setColWidths(
    wb,
    sheet,
    cols = 1,
    widths = 28
  )

  if (ncol(data) >= 2) {
    setColWidths(
      wb,
      sheet,
      cols = 2:ncol(data),
      widths = 14
    )
  }

  # Save the Excel workbook
  saveWorkbook(
    wb,
    excel_path,
    overwrite = TRUE
  )

  # Calculate displayed file sizes
  csv_size <- round_half_up(
    file.size(csv_path) / 1000
  )

  csv_size <- if (csv_size == 0) {
    "1kB"
  } else {
    paste0(csv_size, "kB")
  }

  xl_size <- round_half_up(
    file.size(excel_path) / 1000
  )

  xl_size <- if (xl_size == 0) {
    "1kB"
  } else {
    paste0(xl_size, "kB")
  }

  # Create embedded download links
  em_csv <- embed_file(
    csv_path,
    text = paste0(
      sub("^fig", "Figure ", sheet),
      ".CSV (",
      csv_size,
      ")"
    )
  )

  em_xl <- embed_file(
    excel_path,
    text = paste0(
      sub("^fig", "Figure ", sheet),
      ".XLSX (",
      xl_size,
      ")"
    )
  )

  # Create one download button with a dropdown menu
  buttons <- tags$div(
    class = "table-download-container",
    tags$details(
      class = "download-dropdown",
      tags$summary(
        class = "download-dropdown-button",
        "Download"
      ),
      tags$div(
        class = "download-dropdown-menu",
        tags$div(
          class = "download-dropdown-item",
          em_csv
        ),
        tags$div(
          class = "download-dropdown-item",
          em_xl
        ),
        if (ggplot) {
          tags$div(
            class = "download-dropdown-item",
            tags$a(
              href = "#",
              onclick = paste0("
                event.preventDefault();

                const section = this.closest('.section');
                  if (!section) return;

                  const img = section.querySelector('img');
                  if (!img) return;

                  const link = document.createElement('a');
                  link.href = img.src;
                  link.download = '", sheet, "';
                  link.click();
              "),
              paste0(
                sub("^fig", "Figure ", sheet),
                " as image"
              )
            )
          )
        } else if (!is.null(plotly_ids)) {
          tagList(
            lapply(
              names(plotly_ids),
              function(lbl) {
                pid <- plotly_ids[[lbl]]

                tags$div(
                  class = "download-dropdown-item",
                  tags$a(
                    href = "#",
                    onclick = paste0(
                      "
var gd = window.", pid, ";

var originalAnnotations =
  gd.layout.annotations || [];

var originalImages =
  gd.layout.images || [];

var exportTitle = {
  text:'<b>", lbl, "</b>',
  x:0.5,
  y:1.15,
  xref:'paper',
  yref:'paper',
  showarrow:false,
  xanchor:'center',
  font:{
    family:'Arial',
    size:22,
    color:'black'
  }
};

var exportLogo = {
source:
    'https://nisra-tech-lab.github.io/rs-resources/' +
    'img/nisra-only-colour.png',  xref: 'paper',
  yref: 'paper',
  x: 1,
  y: -.14,
  sizex: 0.12,
  sizey: 0.12,
  xanchor: 'right',
  yanchor: 'bottom',
  layer: 'above'
};

var originalMargin =
  gd.layout.margin || {};

Plotly.relayout(
  gd,
  {
    annotations:
      originalAnnotations.concat([exportTitle]),
    images:
      originalImages.concat([exportLogo]),
    margin:{
      l:80,
      r:40,
      b:120,
      t:120
    }
  }
)
.then(function(){

  return Plotly.downloadImage(
    gd,
    {
      format:'png',
      filename:'", gsub(" ", "_", lbl), "',
      width:1200,
      height:800,
      scale:2
    }
  );

})
.then(function(){

  Plotly.relayout(
    gd,
    {
      annotations: originalAnnotations,
      images: originalImages,
      margin: originalMargin
    }
  );

});

return false;
"
                    ),
                    paste0(lbl, ".PNG")
                  )
                )
              }
            )
          )
        } else if (!is.null(plotly_id)) {
          tags$div(
            class = "download-dropdown-item",
            tags$a(
              href = "#",
              onclick = paste0(
                "
var gd = window.", plotly_id, ";

var originalAnnotations =
  gd.layout.annotations || [];

var originalImages =
  gd.layout.images || [];

var exportTitle = {
  text:'<b>", title, "</b>',
  x:0.5,
  y:1.15,
  xref:'paper',
  yref:'paper',
  showarrow:false,
  xanchor:'center',
  font:{
    family:'Arial',
    size:22,
    color:'black'
  }
};



var exportLogo = {
  source:
    'https://nisra-tech-lab.github.io/rs-resources/' +
    'img/nisra-only-colour.png',
  xref: 'paper',
  yref: 'paper',
  x: 1,
  y: -.14,

  sizex: 0.12,
  sizey: 0.12,

  xanchor: 'right',
  yanchor: 'bottom',

  layer: 'above'
};

var originalMargin =
  gd.layout.margin || {};

Plotly.relayout(
  gd,
  {
    annotations:
  originalAnnotations.concat([exportTitle]),

images:
  originalImages.concat([exportLogo]),

margin:{
      l:80,
      r:40,
      b:120,
      t:120
    }
  }
)
.then(function(){

  return Plotly.downloadImage(
    gd,
    {
      format:'png',
      filename:'", sheet, "',
      width:1200,
      height:800,
      scale:2
    }
  );

})
.then(function(){

  Plotly.relayout(
  gd,
  {
    annotations: originalAnnotations,
    images: originalImages,
    margin: originalMargin
  }
);

});

return false;
"
              ),
              paste0(
                sub("^fig", "Figure ", sheet),
                " as image"
              )
            )
          )
        }
      )
    )
  )

  # Ensure embedded HTML is rendered rather than printed as escaped text
  buttons_html <- as.character(buttons)

  if (grepl("&lt;", buttons_html, fixed = TRUE)) {
    buttons_html <- gsub(
      "&lt;",
      "<",
      buttons_html,
      fixed = TRUE
    )

    buttons_html <- gsub(
      "&gt;",
      ">",
      buttons_html,
      fixed = TRUE
    )

    HTML(buttons_html)
  } else {
    buttons
  }
}
