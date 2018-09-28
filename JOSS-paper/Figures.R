# load libraries
library("helixvis")
library("ggplot2")
library("gridExtra")

# load sample data
data("sequence")

# create ggplots for helical wheel and wenxiang diagram
left.gg <- draw_wheel("ADEKRLKWGTSRLYYSKG")
right.gg<- draw_wenxiang("ADEKRLKWGTSRLYYSKG")

# create side-by-side plots using gridExtra
png("./JOSS-paper/helices.png", width = 700, height = 350)
grid.arrange(left.gg, right.gg, ncol = 2)
dev.off()
