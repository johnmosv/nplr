
# nplr

<!-- badges: start -->
<!-- badges: end -->

The goal of nplr is to parse and extract some usefull information (currently `atc`, `nplid` and `pack-text`)from
[NPL](https://www.lakemedelsverket.se/sv/e-tjanster-och-hjalpmedel/substans-och-produktregister/npl#hmainbody1)
based on `nplpackid`.

## Installation

You can install the development version of nplr like so:

``` r
remotes::install_github("johnmosv/nplr")
```

## Example

Download NPL (4.5 at time writing) from [here](https://npl.mpa.se/MpaProductExport/4.5/)

``` r
library(nplr)
## basic example code: process all nplpackid in Productsdata folder
npl_df = process_npl_directory("path/to/npl_folder/Productsdata")
```

