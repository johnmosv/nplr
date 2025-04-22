#' Process a Directory of NPL XML Files
#'
#' This function processes a directory containing XML files from the Swedish Läkemedelsverket NPL database.
#' It parses each file to extract relevant package information and combines the results into a single data frame.
#'
#' @param directory_path A string representing the path to the directory containing the XML files to be processed.
#'
#' @return A data frame containing the combined package information extracted from all XML files in the directory.
#' The data frame includes columns such as `nplpackid`, `nplid`, ATC code, and package text.
#'
#' @examples
#' \dontrun{
#' npl_data <- process_npl_directory("/path/to/npl/Productsdata/")
#' write.csv(npl_data, "npl_package_data.csv", row.names = FALSE)
#' }
#'
#' @importFrom fs dir_ls
#' @importFrom purrr map_df
#' @export
process_npl_directory <- function(directory_path) {
  # Get list of XML files
  xml_files <- fs::dir_ls(directory_path, glob = "*.xml")

  # Progress counter
  total_files <- length(xml_files)
  cat("Processing", total_files, "XML files\n")

  # Process all files and combine results
  all_data <- purrr::map_df(seq_along(xml_files), function(i) {
    file_path <- xml_files[i]

    # Show progress
    if (i %% 100 == 0) {
      cat("Processing file", i, "of", total_files, "\n")
    }

    # Parse file
    parse_npl_file(file_path)
  })

  return(all_data)
}
