# ##############################################################################
# f_header.R
# Creates report header showing status, publication date and last updated date;
# will include pre-release warning if applicable
# #############################################################################


f_header <- function() {
  require(htmltools)
  div(
    if (prerelease == TRUE) {
      div(
        class = "prerelease-stripes", ".",
        div(
          class = "prerelease",
          p(style = "text-align: center", "OFFICIAL SENSITIVE - restricted
            official statistics"),
          p(style = "text-align: center", strong("For named individuals only -
                                                 do not forward or share")),
          p("Recipients are reminded that these are Official Statistics, which
            you have received pre-release access to under the Pre-Release Access
            to Official Statistics (NI) Order 2009.  Recipients of pre-release
            statistics are cautioned:"),
          p("- to ensure that the statistics, or any information based on them,
            or any indication of the content is not made available to anyone who
            has not been granted privileged access in advance of release;"),
          p("- not to seek changes to release dates; and"),
          p("- to make the statistician responsible for the statistics aware of
            any accidental release of the information to others immediately."),
          p("Wrongful release includes indications of the content, including
            descriptions such as 'favourable' or 'unfavourable'. Recipients
            should note that a list of those who receive privileged early access
            is publicly available on the website."),
          p("If you think you need to discuss and share with anyone not on the
            circulation list, first contact the lead statistician. Any
            accidental or wrongful release should be reported immediately and
            may lead to an inquiry.")
        )
      )
    } else {
      div()
    },
    div(
      class = "row", style = "display:flex",
      div(
        style = "width: 60%; padding-left:10px; font-size: 120%;",
        p(strong("Status: "), statistic_type_text)
      ),
      div(
        style = "width: 60%; padding-left:15px; font-size: 120%;",
        p(strong("Publication date: "), pub_date_words_dmy)
      ),
      div(
        style = "Width: 60%; padding-left:10px; font-size: 120%",
        p(strong("Last updated: "), last_updated_formatted)
      )
    )
  )
}
