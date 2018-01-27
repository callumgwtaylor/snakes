#' Download Data Frame Of Snake Species
#'
#' This script is what will create our snake_species_data data_frame.
#'
#' @param
#' @importFrom magrittr "%>%"
#' @export

snakes <- xml2::read_html("http://apps.who.int/bloodproducts/snakeantivenoms/database/SearchFrm.aspx") %>%
  rvest::html_nodes("#ddlSpeciesName") %>%
  rvest::html_children() %>%
  rvest::html_attr("value") %>%
  dplyr::data_frame(snake_species_id = .)

snakes <- snakes[-1,]

snake_species_data <- purrr::pmap(snakes, snake_download) %>%
  dplyr::bind_rows()

#readr::write_rds(snake_species_data, "./data-raw/snake_species_data_raw.rds")
