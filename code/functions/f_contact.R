# ##############################################################################
# f_contact.R
# Generates contact info block displaying -
# Lead Statistician
# Published By
# Telephone number
# Email address
# #############################################################################

f_contact <- function() {
  div(
    class = "header",
    div(
      class = "row",
      style = "display: flex",
      div(
        style = paste0(
          "width: 100%; ",
          "padding-left: 15px; ",
          "font-size: 120%;"
        ),
        p(
          strong("Published by: "),
          header_publisher
        ),
        p(
          strong("Lead Statistician: "),
          lead_statistician
        ),
        p(
          strong("Telephone: "),
          header_telephone
        ),
        p(
          strong("Email: "),
          f_email(header_email)
        )
      )
    )
  )
}
