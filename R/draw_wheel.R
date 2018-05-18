# draw a helical wheel for sequence lengths up to 18
#' Create helical wheels to visualize alpha helical sequences.
#'
#' This function visualizes alpha-helical peptides as
#' helical wheels.
#' Sequences between 2 and 18 (inclusive) characters can be visualized.
#' The residue in the upper half of the wheel lying at the horizontal
#' center representing the amino acid at the N-terminus (first in `sequence`).
#'
#' @param sequence  character vector containing amino acid sequence
#'   from N-terminus to C-terminus
#' @param col colors for each amino acid type in the following order:
#'   nonpolar residues, polar residues, basic residues, acidic residues
#' @import ggplot2
#' @export
draw_wheel <- function(sequence, col = c("grey", "yellow", "blue", "red")) {
  # check length of sequence
  MIN.NUM <- 2
  MAX.NUM <- 18
  if (!(nchar(sequence) %in% MIN.NUM:MAX.NUM)) {
    stop("ERROR: sequence must have between 2 and 18 (inclusive) characters.")
  }
  num.resid <- nchar(sequence)

  # make sure colors are valid
  NUM.COLORS <- 4 # hydrophobic, hydrophilic, basic, acidic
  if (sum(col %in% colors()) != 4) {
    stop("ERROR: parameter `col` has invalid, missing, or too many colors.")
  }

  # hard-code coordinates for center of 18 circles in helix
  # assume window of [-1, 1] by [-1, 1] (X by Y)
  x.center <- c(0.0000, 0.8371, -0.2907, -0.7361, 0.5464,
                0.5464, -0.7361, -0.2907, 0.8371, 0.0000,
                -0.8371, 0.2907, 0.7361, -0.5464, -0.5464,
                0.7361, 0.2907, -0.8371)
  y.center <- c(0.8500, -0.1476, -0.7987, 0.4250, 0.6511,
                -0.6511, -0.4250, 0.7987, 0.1476, -0.8500,
                0.1476, 0.7987, -0.4250, -0.6511, 0.6511,
                0.4250, -0.7987, -0.1476)

  # setup df for geom_circle
  CIRCLE.RADIUS <- 0.145
  circle.data <- data.frame(x = x.center[1:num.resid],
                            y = y.center[1:num.resid])
  fill.col <- vapply(X = strsplit(sequence, "")[[1]],
                     FUN.VALUE = integer(1),
                     FUN = function(curr.resid) {
                       residue_col(curr.resid)
                     })
  circle.data$fill.col <- col[fill.col]

  # setup df for segments connecting circles
  segment.data <- data.frame(xstart = x.center[1:(num.resid - 1)],
                             ystart = y.center[1:(num.resid - 1)],
                             xend = x.center[2:num.resid],
                             yend = y.center[2:num.resid])

  # draw helical wheel using ggplot2
  ggplot() +
    geom_segment(data = segment.data,
                 aes(x = xstart, y = ystart, xend = xend, yend = yend)) +
    ggforce::geom_circle(data = circle.data,
                aes(x0 = x, y0 = y, r = 0.145, fill = I(fill.col))) +
    theme(line = element_blank(),
          rect = element_blank(),
          text = element_blank(),
          title = element_blank(),
          plot.margin = unit(c(0, 0, 0, 0), "cm")) +
    guides(fill = FALSE) +
    xlim(-1, 1) +
    ylim(-1, 1)
}
