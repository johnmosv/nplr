test_that("can parse test xml", {
  # path_to_xml
  test_file <- file.path("..", "..", "data-raw", "test.xml")

  if (!file.exists(test_file)) {
    skip("Test XML file does not exist. Probably because of check()")
  }

  npl_df <- parse_npl_file(test_file)
  expect_true(is.data.frame(npl_df))
})
