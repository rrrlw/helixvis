# return index of col (see draw_wheel and draw_wenxiang) for specific
# amino acid residue (one-letter code)
residue_col <- function(resid) {
  # 1 = nonpolar, 2 = polar, 3 = basic, 4 = acidic
  resid.vals <- c(1, 3, 2, 4, 2,
                  2, 4, 1, 3, 1,
                  1, 3, 1, 1, 1,
                  2, 2, 1, 1, 1)
  resid.vals <- as.integer(resid.vals)
  names(resid.vals) <- c("A", "R", "N", "D", "C",
                         "Q", "E", "G", "H", "I",
                         "L", "K", "M", "F", "P",
                         "S", "T", "W", "Y", "V")

  # error if `resid` is not a valid one-letter code
  if (!(resid %in% names(resid.vals))) {
    stop(paste("ERROR:", resid,
               "is not a valid one-letter code for an amino acid."))
  }

  # return color index based on name
  resid.vals[resid]
}
