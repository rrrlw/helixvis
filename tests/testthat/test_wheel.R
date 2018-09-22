context("Test helical wheel drawing")

test_that("helical wheel produces valid ggplot object", {
  # make wheel with 18 alanine residues
  temp.seq <- "AAAAAAAAAAAAAAAAAA"
  temp.wheel <- draw_wheel(temp.seq)
  
  # make sure the object is the same as last time (reset if necessary with updates)
  expect_equal_to_reference(temp.wheel, file = "wheel-1")
  
  # make wheel with fewer residues (all types included)
  temp.seq <- "ADKS"
  temp.wheel <- draw_wheel(temp.seq)
  
  # make sure the object is the same as last time (reset if necessary with updates)
  expect_equal_to_reference(temp.wheel, file = "wheel-2")
})