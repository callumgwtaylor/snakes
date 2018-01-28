#' Download Individual Snake Species
#'
#' This function is used by the snake_species_data_frame script, to create a data_frame with a single line about a single snake
#'
#' @param snake_species_id Used by the script to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_download()

snake_download <- function(snake_species_id){
  # Start the html session with their database
  snake <- rvest::html_session("http://apps.who.int/bloodproducts/snakeantivenoms/database/SearchFrm.aspx")
  
  # Load up their query form, create the input we want, and download the species page
  snake_form <- rvest::html_form(snake)[[1]]
  snake_form_submit <- rvest::set_values(snake_form, ddlSpeciesName = snake_species_id)
  snake_zero <- rvest::submit_form(snake, snake_form_submit) %>%
    xml2::read_html()
  
  # Use the species page to then extract the useful information (with other functions already written), and save it all in a data_frame
  snakesss <- dplyr::data_frame(
    snake_species_id = snake_species_id,
    snake_common_name = snake_common_name_get(snake_zero),
    snake_species = snake_species_get(snake_zero),
    snake_family = snake_family_get(snake_zero),
    snake_map_link = snake_map_link_get(snake_zero),
    snake_map_legend_link = snake_map_legend_link_get(snake_zero),
    snake_picture_link = snake_picture_link_get(snake_zero),
    snake_common_name_other = snake_common_name_other_get(snake_zero),
    snake_common_name_other_remainder = snake_common_name_other_remainder_get(snake_zero),
    snake_previous_name = snake_previous_name_get(snake_zero)
  )
  
  # Then we can't easily add regions as it's more than one cell, so we create a seperate one and add it in after nesting it.
  snake_regions <- snake_regions_get(snake_zero) %>%
    dplyr::mutate(snake_species_id = snake_species_id) %>%
    tidyr::nest(-snake_species_id, .key = "regions")
  snakesss <- dplyr::left_join(snakesss, snake_regions, by = "snake_species_id")
  
  # We do something similar for antivenoms as there can be multiple antivenoms
  
  snake_antivenoms <- snake_antivenoms_get(snake_zero) %>%
    dplyr::mutate(snake_species_id = snake_species_id) %>%
    tidyr::nest(-snake_species_id, .key = "antivenoms")
  
  snakesss <- dplyr::left_join(snakesss, snake_antivenoms, by = "snake_species_id")
  
  # Output that dataframe
  snakesss
}