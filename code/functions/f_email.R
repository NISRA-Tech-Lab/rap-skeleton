# ##############################################################################
# f_email.R
# Creates a simple mailto: hyperlink for email addresses in HTML output
# #############################################################################

f_email <- function(email) {
  a(
    href = paste0(
      "mailto:",
      email
    ),
    email
  )
}
