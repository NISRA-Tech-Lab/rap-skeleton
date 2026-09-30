# ##############################################################################
# Styles.R
# Defines consistent Excel styles for reports including headers, numbers,
# alignment, borders and formatting used across workbook generation functions
# #############################################################################

# ==============================================================================
# Page titles
# ==============================================================================

page_title <- createStyle(
  textDecoration = "bold",
  fontSize = 15
)

page_title_bold <- createStyle(
  textDecoration = "bold"
)

page_title_18 <- createStyle(
  textDecoration = "bold",
  fontSize = 18
)

# ==============================================================================
# Column headers
# ==============================================================================

column_header_right <- createStyle(
  halign = "right",
  valign = "bottom",
  wrapText = TRUE,
  textDecoration = "bold"
)

column_header_left <- createStyle(
  halign = "left",
  valign = "bottom",
  wrapText = TRUE,
  textDecoration = "bold"
)

column_header_centre <- createStyle(
  halign = "center",
  valign = "bottom",
  wrapText = TRUE,
  textDecoration = "bold"
)

column_header_lined_right <- createStyle(
  halign = "right",
  valign = "bottom",
  wrapText = TRUE,
  textDecoration = "bold",
  border = "TopBottom",
  borderStyle = c(
    "thin",
    "double"
  )
)

column_header_lined_left <- createStyle(
  halign = "left",
  valign = "bottom",
  wrapText = TRUE,
  textDecoration = "bold",
  border = "TopBottom",
  borderStyle = c(
    "thin",
    "double"
  )
)

# ==============================================================================
# Numeric styles
# ==============================================================================

ns_comma <- createStyle(
  numFmt = "#,##0",
  halign = "right"
)

ns_comma_12 <- createStyle(
  numFmt = "#,##0",
  halign = "right",
  fontSize = 12
)

ns_bold <- createStyle(
  numFmt = "#,##0",
  halign = "right",
  textDecoration = "bold"
)

ns_bold_12 <- createStyle(
  numFmt = "#,##0",
  halign = "right",
  fontSize = 12,
  textDecoration = "bold"
)

ns_italic <- createStyle(
  numFmt = "#,##0",
  halign = "right",
  textDecoration = "italic",
  border = "TopBottom",
  borderStyle = c(
    "thin",
    "thin"
  )
)

ns_decimal <- createStyle(
  numFmt = "#,###.##",
  halign = "right"
)

ns_decimal_1dp <- createStyle(
  numFmt = "#,##0.0",
  halign = "right"
)

ns_decimal_1dp_bold <- createStyle(
  numFmt = "#,##0.0",
  halign = "right",
  textDecoration = "bold"
)

ns_percent <- createStyle(
  numFmt = "#,##0.0%",
  halign = "right"
)

ns_percent_bold <- createStyle(
  numFmt = "#,##0.0%",
  halign = "right",
  textDecoration = "bold"
)

ns_percent_0dp <- createStyle(
  numFmt = "##0%",
  halign = "right",
  fontSize = 12
)

ns_percent_0dp_bold <- createStyle(
  numFmt = "##0%",
  halign = "right",
  fontSize = 12,
  textDecoration = "bold"
)

ns_percentage <- createStyle(
  numFmt = "#0.0",
  halign = "right"
)

num_resp <- createStyle(
  textDecoration = c(
    "bold",
    "italic"
  ),
  border = "TopBottom",
  borderStyle = c(
    "thin",
    "thin"
  )
)

# ==============================================================================
# Currency styles
# ==============================================================================

currency_0dp <- createStyle(
  numFmt = "£#,##0",
  halign = "right",
  valign = "center"
)

currency_0dp_bold <- createStyle(
  numFmt = "£#,##0",
  halign = "right",
  valign = "center",
  textDecoration = "bold"
)

currency_2dp <- createStyle(
  numFmt = "£#,##0.00",
  halign = "right",
  valign = "center"
)

currency_2dp_bold <- createStyle(
  numFmt = "£#,##0.00",
  textDecoration = "bold",
  halign = "right",
  valign = "center"
)

# ==============================================================================
# Alignment
# ==============================================================================

right_align <- createStyle(
  halign = "right"
)

left_align <- createStyle(
  halign = "left"
)

right_align_12 <- createStyle(
  halign = "right",
  valign = "bottom",
  fontSize = 12
)

right_align_bold <- createStyle(
  halign = "right",
  textDecoration = "bold"
)

# ==============================================================================
# Text styles
# ==============================================================================

text_wrap <- createStyle(
  wrapText = TRUE
)

header_13 <- createStyle(
  halign = "left",
  textDecoration = "bold",
  fontSize = 13
)

header_14 <- createStyle(
  textDecoration = "bold",
  fontSize = 14
)

plain_text <- createStyle(
  textDecoration = NULL
)

# ==============================================================================
# Cell shading and text colour
# ==============================================================================

shaded <- createStyle(
  halign = "right",
  fgFill = "#D3D3D3"
)

shaded_comma <- createStyle(
  halign = "right",
  fgFill = "#D3D3D3",
  numFmt = "#,##0"
)

shaded_percent <- createStyle(
  halign = "right",
  fgFill = "#D3D3D3",
  numFmt = "#0.0"
)

grey_fill <- createStyle(
  fgFill = "#D9D9D9"
)

white_text <- createStyle(
  fontColour = "#FFFFFF"
)

# ==============================================================================
# Borders
# ==============================================================================

top_border <- createStyle(
  border = "Top",
  borderStyle = "thin"
)

# ==============================================================================
# Indentation
# ==============================================================================

indent <- createStyle(
  indent = 1
)

indent_bold <- createStyle(
  indent = 1,
  textDecoration = "bold"
)
