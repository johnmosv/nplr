#' Parse NPL XML File for Package Information
#'
#' This function parses an XML file from the Swedish Läkemedelsverket NPL database
#' to extract information such as `nplpackid`, `nplid`, ATC code, and package text.
#'
#' @param file_path A string representing the path to the XML file to be parsed.
#'
#' @return A data frame containing the extracted package information with columns:
#' \describe{
#'   \item{nplpackid}{The NPL package ID.}
#'   \item{nplid}{The NPL ID.}
#'   \item{atc_code}{The ATC code, or \code{NA} if not found.}
#'   \item{pack_text}{The package text, or \code{NA} if not found.}
#' }
#' If no packages are found, an empty data frame with the correct structure is returned.
#'
#' @examples
#' \dontrun{
#' parse_npl_file("path/to/npl_file.xml")
#' }
#'
#' @importFrom xml2 read_xml xml_ns xml_text xml_find_first xml_find_all
#' @importFrom purrr map_df
#' @export
parse_npl_file <- function(file_path) {
  # Read XML file
  xml_data <- tryCatch(
    {
      xml2::read_xml(file_path)
    },
    error = function(e) {
      warning(paste("Could not read file:", file_path, "-", e$message))
      return(NULL)
    }
  )

  if (is.null(xml_data)) {
    return(NULL)
  }

  # Register the namespaces
  xml_ns <- xml2::xml_ns(xml_data)

  # Extract nplid
  nplid <- xml2::xml_text(xml2::xml_find_first(xml_data, ".//mpa:nplid", xml_ns))

  # Extract ATC code
  atc_code <- tryCatch(
    {
      first_atc <- xml2::xml_find_first(xml_data, ".//mpa:atc-code-lx", xml_ns)
      # extract the 'v' attribute
      xml2::xml_attr(first_atc, attr = "v")
    },
    error = function(e) {
      NA_character_
    }
  )

  # Extract package information an nplnodeset
  packages <- xml2::xml_find_all(xml_data, ".//npl:package", xml_ns)

  if (length(packages) == 0) {
    # If no packages found, return empty data frame with correct structure
    return(data.frame(
      nplpackid = character(0),
      nplid = character(0),
      atc_code = character(0),
      pack_text = character(0),
      stringsAsFactors = FALSE
    ))
  }

  # Process each package
  package_data <- purrr::map_df(packages, function(pkg) {
    # Extract nplpackid
    nplpackid <- xml2::xml_text(xml2::xml_find_first(pkg, ".//mpa:nplpackid", xml_ns))

    # Extract pack text
    pack_text <- tryCatch(
      {
        xml2::xml_text(xml2::xml_find_first(pkg, ".//mpa:pack-text/mpa:v", xml_ns))
      },
      error = function(e) {
        NA_character_
      }
    )

    # Return as data frame row
    data.frame(
      nplpackid = nplpackid,
      nplid = nplid,
      atc_code = atc_code,
      pack_text = pack_text,
      stringsAsFactors = FALSE
    )
  })

  return(package_data)
}
