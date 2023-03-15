
f_comment_box <- function(colour_style = "red", text_words = NA) {
  
if(!report_final) { div(
    p(class = paste0("statusbox_",colour_style), text_words)
  )} 
}


f_borderline <- function() {
  
  div(
    div(class="row", style="display: flex; margin-top: 15px;  margin-bottom: 10px"),
    div(class = "row-indent"),
    div(class="border", style=paste0("background-color: var(--nics-three-bar-colour-1); float:left")),
    div(class="border", style=paste0("background-color: var(--nics-three-bar-colour-2); float:left")),
    div(class="border", style=paste0("background-color: var(--nics-three-bar-colour-3); float:right")),
    div(class = "row-indent"),
  
  br())
}



f_banner <- function() {
  
  div(
    div(class = "row", style = "display: flex;",
        div(class = "row-indent"),
        div(class = "left", img(src = nisraLogo, alt = "NISRA logo")),
        div(class = "middlenatstats", if(statistic_type == "ns") { img(src = natStats, alt = "National Statistics Logo")} ),
        div(class = "right", img(src =  depLogo, alt = "DoF logo")),
        # div(class = "left", img(src = base64enc::dataURI(file = paste0(images_source_root,"NISRA-full-name-stacked-white.png")), alt = "NISRA logo")),
        # div(class = "middle", img(src = base64enc::dataURI(file = paste0(images_source_root,"NatStats.png")), alt = "National Statistics Logo")),
        # div(class = "right", img(src = base64enc::dataURI(file = paste0(images_source_root,"dept_logos/top-white-", params$nicstheme, ".png")), alt = "DoF logo")),
        div(class = "row-indent")),
    
    div(class = "row", style = "display: flex;",
        div(class = "row-indent"),
        div(class = "left", ""),
        div(class = "middle", p(class = "toc-ignore", rmarkdown::metadata$title)),
        div(class = "right", ""),
        div(class = "row-indent")),

        div(class = "row", style = "display: flex;",
      div(class = "row-indent"),
      div(class = "findings", paste0("Published ", pub_date_words_dmy)),
      div(class = "row-indent", style = paste0("background-color: var(--nics-banner-bg);")),
      div(class = "row-indent")),
    
    div(class = "row", style = "display: flex;",
        div(class = "row-indent"),
        div(style = paste0("background-color: var(--nics-banner-highlight); height: 9px; width: 100%;")),
        div(class = "row-indent")),
    
    br())

}

f_header <- function() {

  div(class = "header",
      if(params$prerelease == TRUE) {
      div(class = "prerelease-stripes", ".",
        div(class="prerelease", 
            p(style = "text-align: center", "Official - Sensitive - Statistics",br(),
            strong("Do not forward")),
            p("Official statistics - please treat as protected, for named individuals or identified post holders only. Not for sharing with anyone else or to be used in any other documents before publication."),
            p("If you think you need to discuss and share with anyone not on the circulation list, first contact the Department's senior statistician. Any accidental or wrongful release should be reported immediately and may lead to an inquiry. Wrongful release includes indications of the content or trend of the figures, including description such as 'favourable' or 'unfavourable'.")
        ))
      } else { div()},
      
      p(strong(case_when(substr(statistic_type,1,1) %in% c("a", "e", "i", "o", "u") ~ "An", TRUE ~ "A"), a(statistic_type_text, href="#NatStats"), "Publication"),
      br(),
      strong("Published by: "), header_publisher),
      
      div(class="row", style = "display:flex",
          div(style = "width: 67%; padding-left:15px; font-size: 120%;",
            p(strong("Contact: "), header_contact,
              br(),
            strong("Telephone: "), header_telephone,
              br(),
            strong("Email: "), header_email)),
          div(style = "width: 33%; font-size: 120%;",
            p(strong("Theme: "), header_theme,
              br(),
            strong("Coverage: "), header_coverage,
              br(),
            strong("Frequency: "), header_frequency))),
          p(strong("Publication date: "), pub_date_words_dmy))

  
}

f_print_code <- function(c) {
  pre(class = "r", code(class = "hljs", c))
}


