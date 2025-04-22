test_that("can process direcotyr", {
  test_dir <- "../2025-02-21_total_npl/Productdata"
  # this actually takes a while so you probably want to save it somewhere
  npl_df <- process_npl_directory(test_dir)
  rio::export(npl_df, "../../../../adhd-contraceptives/data/npl_info.csv")
})
