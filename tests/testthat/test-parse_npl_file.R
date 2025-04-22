test_that("can parse test xml", {
  # path_to_xml
  test_file <- list.files("../2025-02-21_total_npl/Productdata", full.names = TRUE)[1]
  file_path <- test_file
  npl_df <- parse_npl_file(test_file)
  expect_true(is.data.frame(npl_df))
})
