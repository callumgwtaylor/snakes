#' Download Common Name Of Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output.
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_common_name_get()

###
### The following functions take the output from an individual snake species page,
### then they'll extract the relevant sections, ready for input into a data frame
###

snake_common_name_get <- function(snake_species){
  snake_species %>%
    rvest::html_node("#CommonNameLabel")%>%
    rvest::html_text()
}

#' Download Family Name Of Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output.
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_family_get()

snake_family_get <- function(snake_species){
  snake_species %>%
    rvest::html_node("#SnakeFamilyLabel") %>%
    rvest::html_text()
}

#' Download Species Name Of Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output.
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_species_get()

snake_species_get <- function(snake_species){
  snake_species %>%
    rvest::html_node("#SnakeNameLabel") %>%
    rvest::html_text()
}

#' Download Link To Map Of Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output.
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_map_link_get()

snake_map_link_get <- function(snake_species){
  snake_map <- snake_species %>%
    rvest::html_node("#ImageMapImageMap1") %>%
    rvest::html_node("area") %>%
    rvest::html_attr("href")
  
  weblink <- "http://apps.who.int/bloodproducts/snakeantivenoms/database/"
  stringr::str_c(weblink, snake_map)
}

#' Download Link To Map Legend For Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output.
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_map_legend_link_get()

snake_map_legend_link_get <- function(snake_species){
  snake_legend <- snake_species %>%
    rvest::html_node("#MapLegend") %>%
    rvest::html_attr("src")
  
  weblink <- "http://apps.who.int/bloodproducts/snakeantivenoms/database/"
  stringr::str_c(weblink, snake_legend)
}

#' Download Link To Picture For Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output.
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_picture_link_get()

snake_picture_link_get <- function(snake_species){
  snake_picture <- snake_species %>%
    rvest::html_node("#ImageMapImageMap2") %>%
    rvest::html_node("area") %>%
    rvest::html_attr("href")
  
  weblink <- "http://apps.who.int/bloodproducts/snakeantivenoms/database/"
  stringr::str_c(weblink, snake_picture)
}

#' Download Other Common Name For Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output.
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_common_name_other_get()

snake_common_name_other_get <- function(snake_species){
  snake_species %>%
    rvest::html_node("#CommonNamesFormView_AlternateCommonNameLabel") %>%
    rvest::html_text()
}

#' Download List of Other Common Names For Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output.
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_common_name_other_remainder_get()

snake_common_name_other_remainder_get <- function(snake_species){
  snake_species %>%
    rvest:: html_node("#CommonNamesFormView_IndigenousName1Label") %>% 
    rvest::html_text() %>%
    stringr::str_split(pattern = ", ")
}

#' Download Previous Names For Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output.
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_previous_name_get()

snake_previous_name_get <- function(snake_species){
  snake_species %>% 
    rvest::html_node("#PriorNamesFormView_PreviousSpeciesName1Label") %>%
    rvest::html_text()
}

#' Download Regions For Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output. This one is quite a bit different as it creates a data_frame, with one line for each region
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_regions_get()

snake_regions_get <- function(snake_species){
  snake_species %>%
    rvest::html_node("#RegionsSubRegionsDataList") %>%
    rvest::html_table() %>%
    tidyr::separate(X1, into = c("region", "region_sub"), sep = ":")
}

#' Download Antivenoms For Snake Species
#'
#' This sub-function is used by the function snake_dowload. To clean stuff up from the rvest output. This one is quite a bit different as it creates a data_frame, with one line for each antivenom
#'
#' @param snake_species Used by the function to work out which snake_id it needs to look at
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_previous_name_get()

snake_antivenoms_get <- function(snake_species){
  snake_antivenoms <- snake_species %>%
    rvest:: html_node("#AntivenomsDataList") %>%
    rvest::html_table() %>%
    tidyr::separate(X1, into = c("antivenom_product_title",
                                 "antivenom_product",
                                 "antivenom_manufacturer",
                                 "antivenom_country_origin"), sep = ":") %>%
    dplyr::select(-antivenom_product_title)
  
  snake_antivenoms$antivenom_product <- stringr::str_replace_all(snake_antivenoms$antivenom_product, "\r\n                            ", "")
  snake_antivenoms$antivenom_product <- stringr::str_replace_all(snake_antivenoms$antivenom_product, "Manufacturer", "")
  snake_antivenoms$antivenom_manufacturer <- stringr::str_replace_all(snake_antivenoms$antivenom_manufacturer,
                                                                      "\r\n                            ",
                                                                      "")
  snake_antivenoms$antivenom_manufacturer <- stringr::str_replace_all(snake_antivenoms$antivenom_manufacturer,
                                                                      "Country of origin",
                                                                      "")
  snake_antivenoms$antivenom_country_origin <- stringr::str_replace_all(snake_antivenoms$antivenom_country_origin,
                                                                        "\r\n                            ",
                                                                        "")
  snake_antivenoms
}