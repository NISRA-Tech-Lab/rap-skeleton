# ##############################################################################
# f_comment_box.R
# Creates comment boxes for draft reports to display warnings or
# comments: hidden when report_final flag is true
# #############################################################################

f_comment_box <- function(
  colour_style = "red",
  text_words = NA
) {
  if (!report_final) {
    div(
      p(
        class = paste0(
          "statusbox_",
          colour_style
        ),
        text_words
      )
    )
  }
}
