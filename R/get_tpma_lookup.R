get_tpma_lookup <- function(
    path = "https://raw.githubusercontent.com/The-Strategy-Unit/TPMAs/refs/heads/main/reference/tpma-lookup.csv"
) {
  readr::read_csv(path, col_types = "c") |>
    dplyr::filter(is.na(.data$active_to)) 
}