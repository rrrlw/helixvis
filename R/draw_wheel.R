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
#' @export
#' @examples
#' draw_wheel("GIGAVLKVLTTGLPALIS")
#' draw_wheel("QQRKRKIWSILAPLGTTL")
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
  if (sum(col %in% grDevices::colors()) != NUM.COLORS) {
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

  # previous vals were for ggplot2 and ggforce implementation
  # scale and shift for plotrix implementation
  x.center <- x.center / 2 + 0.5
  y.center <- y.center / 2 + 0.5

  # setup df for geom_circle
  CIRCLE.RADIUS <- 0.0725
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
  segment.data$slope <- with(segment.data,
                             (yend - ystart) / (xend - xstart))
  segment.data$intercept <- vapply(X = 1:nrow(segment.data),
                                   FUN.VALUE = numeric(1),
                                   FUN = function(i) {
                                     # vertical line
                                     if (is.infinite(segment.data$slope[i])) {
                                       return(segment.data$xstart[i])
                                     }

                                     # normal lines
                                     return(with(segment.data,
                                                 ystart[i] - xstart[i] * slope[i]))
                                   })

  # setup plot
  old.mar <- graphics::par()$mar            # save old settings for reversion
  on.exit(graphics::par(mar = old.mar))     # go back to old settings
  graphics::par(mar = c(0, 0, 0, 0))        # remove margins for more drawing space
  graphics::plot.new()                      # blank canvas for plotrix drawing

  # draw helical wheel segments using plotrix
  temp <- vapply(X = 1:(num.resid - 1), FUN.VALUE = logical(1),
                 FUN = function(i) {
                   # vertical line
                   if (is.infinite(segment.data$slope[i])) {
                     with(segment.data,
                          plotrix::ablineclip(v = intercept[i],
                                              y1 = ystart[i],
                                              y2 = yend[i]))
                   # normal line
                   } else {
                     with(segment.data,
                          plotrix::ablineclip(a = intercept[i],
                                              b = slope[i],
                                              x1 = xstart[i],
                                              x2 = xend[i]))
                   }

                   # all went okay
                   return(TRUE)
                 })

  # draw helical wheel circles using plotrix
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
