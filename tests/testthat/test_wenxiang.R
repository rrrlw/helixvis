context("Test wenxiang diagram drawing")

test_that("wenxiang diagram produces valid ggplot object", {
  # make wheel with 18 alanine residues
  temp.seq <- "AAAAAAAAAAAAAAAAAA"
  temp.wheel <- draw_wenxiang(temp.seq)
  
  # make sure the object is the same as last time (reset if necessary with updates)
  expect_equal_to_reference(temp.wheel, file = "wenxiang-1")
  
  # make wheel with fewer residues (all types included)
  temp.seq <- "ADKS"
  temp.wheel <- draw_wenxiang(temp.seq)
  
  # make sure the object is the same as last time (reset if necessary with updates)
  expect_equal_to_reference(temp.wheel, file = "wenxiang-2")
})