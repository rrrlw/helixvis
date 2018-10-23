# draw a wenxiang diagram for sequence lengths up to 18
#' Create Wenxiang diagrams to visualize alpha helical sequences.
#'
#' This function visualizes alpha-helical peptides as
#' Wenxiang diagrams.
#' Sequences between 2 and 18 (inclusive) characters can be visualized.
#' The residue closest to the center represents the amino acid at the
#' N-terminus (first in `sequence`).
#'
#' @inheritParams draw_wheel
#' @importFrom rlang .data
#' @export
#' @examples
#' draw_wenxiang("GIGAVLKVLTTGLPALIS")
#' draw_wenxiang("QQRKRKIWSILAPLGTTL")
draw_wenxiang <- function(sequence, col = c("grey", "yellow", "blue", "red"),
                          labels = FALSE, label.col = "black", fixed = TRUE,
                          legend = FALSE) {
  # check length of sequence
  if (nchar(sequence) > 18) {
    stop("ERROR: sequence must have less than or equal to 18 characters.")
  } else if (nchar(sequence) < 2) {
    stop("ERROR: sequence must have at least 2 characters.")
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

  # prepare data frame for spiral
  BETWEEN.DISTANCE <- 0.042
  START.RADIUS <- 0.0625
  CENTER.X <- 0.5
  CENTER.Y <- 0.52
  df.spiral <- data.frame(start.angle = rep(c(0, pi), 5),
                          end.angle = rep(c(pi, 2 * pi), 5),
                          center.y = rep(c(CENTER.X, CENTER.X + BETWEEN.DISTANCE), 5),
                          center.x = rep(CENTER.Y, 10))
  df.spiral$end.angle[10] <- 260 / 180 * pi
  curr.radius <- START.RADIUS
  for (i in 1:10) {
    df.spiral$radius[i] <- curr.radius
    curr.radius <- curr.radius + BETWEEN.DISTANCE
  }

  # subset spirals (only as many as we need)
  resid.spiral <- c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 7, 8, 8, 9, 9, 10)
  df.spiral <- df.spiral[1:resid.spiral[num.resid], ]
  df.spiral$end.angle[nrow(df.spiral)] <- df.spiral$start.angle[nrow(df.spiral)] +
    (((num.resid - 1) * 100 / 180 * pi -
        pi * (resid.spiral[num.resid] - 1)) %% (2 * pi))

  # prepare data frame for residue
  df.resid <- data.frame(y = c(0.5625, 0.4891, 0.4438, 0.5943, 0.6122, 0.3878,
                               0.4478, 0.7191, 0.5400, 0.2695, 0.5893, 0.7955,
                               0.3428, 0.2689, 0.8151, 0.6993, 0.1255, 0.4655),
                         x = c(0.5200, 0.5816, 0.4843, 0.4295, 0.6142, 0.6142,
                               0.3568, 0.4555, 0.7470, 0.5200, 0.2516, 0.6276,
                               0.7924, 0.2908, 0.2908, 0.8651, 0.6563, 0.0862))

  # subset residues (only as many as we need)
  df.resid <- df.resid[1:num.resid, ]

  # make fill colors for residues
  fill.col <- vapply(X = strsplit(sequence, "")[[1]],
                     FUN.VALUE = integer(1),
                     FUN = function(curr.resid) {
                       residue_col(curr.resid)
                     })
  resid.types <- c("hydrophobic", "polar", "basic", "acidic")
  df.resid$fill.col <- resid.types[fill.col]
  df.resid$lettername <- vapply(X = 1:nchar(sequence),
                                FUN.VALUE = character(1),
                                FUN = function(i) substr(sequence, i, i))

  # draw with ggplot2 (use .data from rlang to prevent R CMD check issues)
  g <- ggplot2::ggplot() +
         ggforce::geom_arc(data = df.spiral,
                           ggplot2::aes(x0 = .data$center.x, y0 = .data$center.y,
                                        r = .data$radius,
                                        start = .data$start.angle,
                                        end = .data$end.angle)) +
         ggforce::geom_circle(data = df.resid,
                              ggplot2::aes(x0 = .data$x, y0 = .data$y,
                                           r = 0.04, fill = .data$fill.col)) +
         ggplot2::xlim(c(0, 1)) + ggplot2::ylim(c(0, 1)) +
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
    g <- g + ggplot2::geom_text(data = df.resid,
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
