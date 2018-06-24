# draw a wenxiang diagram for sequence lengths up to 18
#' Create Wenxiang diagrams to visualize alpha helical sequences.
#'
#' This function visualizes alpha-helical peptides as
#' Wenxiang diagrams.
#' Sequences between 2 and 18 (inclusive) characters can be visualized.
#' The residue closest to the center represents the amino acid at the
#' N-terminus (first in `sequence`).
#'
#' @param sequence  character vector containing amino acid sequence
#'   from N-terminus to C-terminus
#' @param col colors for each amino acid type in the following order:
#'   nonpolar residues, polar residues, basic residues, acidic residues
#' @export
#' @examples
#' draw_wenxiang("GIGAVLKVLTTGLPALIS")
#' draw_wenxiang("QQRKRKIWSILAPLGTTL")
draw_wenxiang <- function(sequence, col = c("grey", "yellow", "blue", "red")) {
  # check length of sequence
  if (nchar(sequence) != 18) {
    stop("ERROR: sequence must have exactly 18 characters.")
  }
  num.resid <- nchar(sequence)

  # make sure colors are valid
  NUM.COLORS <- 4 # hydrophobic, hydrophilic, basic, acidic
  if (sum(col %in% grDevices::colors()) != NUM.COLORS) {
    stop("ERROR: parameter `col` has invalid, missing, or too many colors.")
  }

  # hard-code coordinates for center of 18 circles in helix
  # assume window of [-1, 1] by [-1, 1] (X by Y)
  x.center <- c(0.5650, 0.4887, 0.4416, 0.6000, 0.6187, 0.3813,
                0.4450, 0.7329, 0.5425, 0.2550, 0.5954, 0.8148,
                0.3325, 0.2539, 0.8361, 0.7125, 0.1006, 0.4634)
  y.center <- c(0.5000, 0.5640, 0.4624, 0.4047, 0.5996, 0.5996,
                0.3268, 0.4316, 0.7413, 0.5000, 0.2144, 0.6146,
                0.7901, 0.2557, 0.2557, 0.8681, 0.6454, 0.0371)

  # not sure why, but these adjustments were necessary
  x.center <- 0.97 * (x.center - 0.5) + 0.5
  y.center <- 0.96 * (y.center - 0.5) + 0.5

  # setup important constants for later use
  CIRCLE.RADIUS <- 0.0375
  X_INIT <- 0.5
  Y_INIT <- 0.5
  R_DELTA <- 0.045
  R_INIT <- 0.065

  # setup df for geom_circle
  circle.data <- data.frame(x = x.center[1:num.resid],
                            y = y.center[1:num.resid])
  fill.col <- vapply(X = strsplit(sequence, "")[[1]],
                     FUN.VALUE = integer(1),
                     FUN = function(curr.resid) {
                       residue_col(curr.resid)
                     })
  circle.data$fill.col <- col[fill.col]

  # setup plot
  old.mar <- graphics::par()$mar            # save old settings for reversion
  on.exit(graphics::par(mar = old.mar))     # go back to old settings
  graphics::par(mar = c(0, 0, 0, 0))        # remove margins for more drawing space
  graphics::plot.new()                      # blank canvas for plotrix drawing

  # top half of spiral
  temp <- vapply(X = seq(1, 9, by = 2),
                 FUN.VALUE = logical(1),
                 FUN = function(i) {
                   plotrix::draw.arc(x = X_INIT, y = Y_INIT,
                                     radius = R_INIT + (i - 1) * R_DELTA,
                                     deg1 = 0, deg2 = 180)
                   return(TRUE)
                 })

  # bottom half of spiral
  temp <- vapply(X = seq(2, 8, by = 2),
                 FUN.VALUE = logical(1),
                 FUN = function(i) {
                   plotrix::draw.arc(x = X_INIT + R_DELTA, y = Y_INIT,
                                     radius = R_INIT + (i - 1) * R_DELTA,
                                     deg1 = 180, deg2 = 360)
                   return(TRUE)
                 })

  # draw last one separately (only part of arc needs to be drawn)
  plotrix::draw.arc(x = X_INIT + R_DELTA, y = Y_INIT,
                    radius = R_INIT + 9 * R_DELTA,
                    deg1 = 180, deg2 = 260)

  # draw wenxiang diagram circles using plotrix
  temp <- vapply(X = 1:num.resid, FUN.VALUE = logical(1),
                 FUN = function(i) {
                   plotrix::draw.circle(x = circle.data$x[i],
                                        y = circle.data$y[i],
                                        radius = CIRCLE.RADIUS,
                                        col = circle.data$fill.col[i],
                                        border = "black")
                   return(TRUE)
                 })
}
