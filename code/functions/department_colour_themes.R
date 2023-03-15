# Department themes

# Define colour palettes
# DECISION: list or vector e.g. theme$Sixth vs theme[6] to reference colours i.e. by name or number
colours_dof <- c("#00205B", # banner background
                 "#3878c5", # banner background bottom border
                 "#2574a9", # a:link
                 "#1460aa", # h1, h2, h3
                 "#00205b", # 3-bar line break - colours #1
                 "#3878c5", # 3-bar line break - colours #2
                 "#CEDC20") # 3-bar line break - colours #3

colours_dfe <- list("white", "aliceblue", "antiquewhite", "antiquewhite1", "antiquewhite2", "antiquewhite3")
colours_teo <- c("azure2", "azure3", "azure4", "beige", "bisque", "bisque1", "yellow", "black", "pink")


# DECISION: how users will choose CSS theme. idea, use this script to output .css files and users change the style.css to e.g. style_dof.css as required.


# plot all the colours in a palette in a basic plot() as large circles
# cex= sets the size (larger number = bigger dots)
# default: colours_dof palette
preview_palette <- function(colours=colours_teo) {
  plot(1:length(colours), 1:length(colours), col=colours[1:length(colours)], pch=19, cex=7, xlab="", ylab="")
}



# identify fixed colours
# identify variable colours
# min variable colours (to cover at least banner, text, links, basic charts)
# max variable colours (to cover advanced charts, infographics etc.)