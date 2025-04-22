test_that("can process direcotyr", {
  test_dir <- file.path("..", "..", "data-raw")
  if (!dir.exists(test_dir)) {
    skip("Test directory does not exist. Probably because of check()")
  }
  # this actually takes a while so you probably want to save it somewhere
  npl_df <- process_npl_directory(test_dir)
  expect_true(is.data.frame(npl_df))
})
