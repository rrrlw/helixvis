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
#' @param labels logical value; if TRUE, one-letter residue codes are
#'   overlaid on the residue circles
#' @param label.col character value for color of labels added if `labels = TRUE`
#' @param fixed if TRUE (default), ensures that residues will be circles
#'   (not ellipses) even if graphics device is rectangular
#' @param legend if TRUE, adds legend to plot
#' @importFrom rlang .data
#' @export
#' @examples
#' draw_wheel("GIGAVLKVLTTGLPALIS")
#' draw_wheel("QQRKRKIWSILAPLGTTL")
draw_wheel <- function(sequence, col = c("grey", "yellow", "blue", "red"),
                       labels = FALSE, label.col = "black", fixed = TRUE,
                       legend = FALSE) {
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

  # make sure labels is a logical value and label.col is valid
  if (!is.logical(labels)) {
    stop("labels parameter must be logical (either TRUE or FALSE)")
  }
  if (!(label.col %in% grDevices::colors())) {
    stop("label.col parameter must be a valid color (see list of valid colors using grDevices::colors())")
  }

  # hard-code details of 18 circles in helix
  # assume window of [-1, 1] by [-1, 1] (X by Y)
  x.center <- c(0.0000, 0.8371, -0.2907, -0.7361, 0.5464,
                0.5464, -0.7361, -0.2907, 0.8371, 0.0000,
                -0.8371, 0.2907, 0.7361, -0.5464, -0.5464,
                0.7361, 0.2907, -0.8371)
  y.center <- c(0.8500, -0.1476, -0.7987, 0.4250, 0.6511,
                -0.6511, -0.4250, 0.7987, 0.1476, -0.8500,
                0.1476, 0.7987, -0.4250, -0.6511, 0.6511,
                0.4250, -0.7987, -0.1476)
  CIRCLE.RADIUS <- 0.143

  # prepare data  frame with circle information (residues)
  circle.data <- data.frame(x = x.center[1:num.resid],
                            y = y.center[1:num.resid])
  fill.col <- vapply(X = strsplit(sequence, "")[[1]],
                     FUN.VALUE = integer(1),
                     FUN = function(curr.resid) {
                       residue_col(curr.resid)
                     })
  resid.types <- c("hydrophobic", "polar", "basic", "acidic")
  circle.data$fill.col <- resid.types[fill.col]
  circle.data$lettername <- vapply(X = 1:nchar(sequence),
                                   FUN.VALUE = character(1),
                                   FUN = function(i) substr(sequence, i, i))

  # prepare data frame with segment information
  segment.data <- data.frame(xstart = x.center[1:(num.resid - 1)],
                             ystart = y.center[1:(num.resid - 1)],
                             xend = x.center[2:num.resid],
                             yend = y.center[2:num.resid])

  # draw with ggplot2 (use .data from rlang to prevent R CMD check issues)
  g <- ggplot2::ggplot() +
         ggplot2::geom_segment(data = segment.data,
                               ggplot2::aes(x = .data$xstart, y = .data$ystart,
                                            xend = .data$xend, yend = .data$yend)) +
         ggforce::geom_circle(data = circle.data,
                              ggplot2::aes(x0 = .data$x, y0 = .data$y,
                                           r = CIRCLE.RADIUS,
                                           fill = .data$fill.col)) +
         ggplot2::xlim(c(-1, 1)) + ggplot2::ylim(c(-1, 1)) +
         ggplot2::scale_fill_manual(values = c("hydrophobic" = col[1],
                                               "polar" = col[2],
                                               "basic" = col[3],
                                               "acidic" = col[4]),
                                    name = "Residue Types") +
         ggplot2::theme(panel.grid.major = ggplot2::element_blank(),
                        panel.grid.minor = ggplot2::element_blank(),
                        panel.background = ggplot2::element_blank(),
                        panel.border = ggplot2::element_blank(),
                        axis.title = ggplot2::element_blank(),
                        axis.text = ggplot2::element_blank(),
                        axis.ticks = ggplot2::element_blank(),
                        legend.position = "none")

  # add labels if user requests (labels = TRUE)
  if (labels) {
    g <- g + ggplot2::geom_text(data = circle.data,
                                ggplot2::aes(x = .data$x, y = .data$y,
                                             label = .data$lettername,
                                             colour = I(label.col)))
  }
  
  # fixed coordinates if user desires
  if (fixed) {
    g <- g + ggplot2::coord_fixed()
  }
  
  # legend if user desires
  if (legend) {
    g <- g + ggplot2::theme(legend.position = "right")
  }
  
  g
}

