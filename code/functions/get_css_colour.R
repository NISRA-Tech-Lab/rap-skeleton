# function to retrieve a CSS data variable value
# used to get pre-defined departmental theme colours out of CSS
# this allows you to e.g. create an R variable that can be used in plotly

# params nicstheme must be set in report yaml e.g.:
# params:
#   nicstheme: "dfi"
# function will search (default) style.css and find which theme you are using
# i.e. the value of data-nics-theme
# 
# pass the CSS var you want into the function and it will return the value including #
# e.g. if you want --nics-banner-bg value
# get_css_colour(nics-banner-bg)
# 
# note the two dashes (--) at the beginning of the variable should not be included


get_css_colour <- function(element_name) {
  
  # Read in css file
  css_file <- readLines(paste0(code_source_root, "style.css"))
 
  # Line theming for the department starts on
  dept_line <- which(css_file == paste0("[data-nics-theme=", params$nicstheme, "] {"))
  
  # Which lines contain the text entered as element_name
  elements <- which(grepl(element_name, css_file))
  
  # The first line after dept_line which contains element_name
  colour_line <- css_file[elements[elements > dept_line][1]]
  
  # Extract colour from line
  gsub(".*#", "", colour_line) %>%
    gsub(";", "", .) %>%
    paste0("#", .)
  
}
