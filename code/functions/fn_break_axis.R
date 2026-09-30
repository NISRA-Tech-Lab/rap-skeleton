# #############################################################################
# f_n_break_axis.R
# This function will insert a broken axis symbol on the y axis when called.
# It takes three arguments:
# 1. p - a plotly object
# 2. linecolor - a string containing colour code of axis, you should match the
#    colour defined here to that of the axis lines
# 3. ref_line - optional argument, list definition of reference line
# #############################################################################

fn_break_axis <- function(
  p,
  linecolor,
  ref_line = list()
) {
  layout(
    p,
    shapes = list(
      # First shape is a white line to break the axis
      list(
        type = "line",
        xref = "paper",
        x0 = 0,
        x1 = 0,
        yref = "paper",
        y0 = 0.032,
        y1 = 0.052,
        line = list(
          color = "#ffffff",
          width = 4
        )
      ),
      # Second shape is the first tick
      list(
        type = "line",
        xref = "paper",
        x0 = -0.01,
        x1 = 0.01,
        yref = "paper",
        y0 = 0.04,
        y1 = 0.07,
        line = list(
          color = linecolor
        )
      ),
      # Third shape is the second tick
      list(
        type = "line",
        xref = "paper",
        x0 = -0.01,
        x1 = 0.01,
        yref = "paper",
        y0 = 0.02,
        y1 = 0.05,
        line = list(
          color = linecolor
        )
      ),
      ref_line
    )
  )
}
