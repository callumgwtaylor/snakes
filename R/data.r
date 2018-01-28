#' 237 Medically Relevant Snakes
#'
#' A dataset containing the names, regions, and antivenoms for the 237 medically relevant snake species on the WHO online database
#' 
#'
#' @format A data frame with 237 rows and 12 variables, one variable is a list, two variables are nested:
#' \describe{
#'   \item{snake_species_id}{WHO unique identifier for snake}
#'   \item{snake_common_name}{Name of the Snake Species, e.g. "Common Death Adder"}
#'   \item{snake_species}{Scientific Name of the Snake Species, e.g. "Acanthophis antarcticus"}
#'   \item{snake_family}{Name of the Species Family, e.g. "Elapidae"}
#'   \item{snake_map_link}{URL of WHO Map of the Snake Geographical Distribution}
#'   \item{snake_map_legend_link}{URL for the legend for the snake_map_link}
#'   \item{snake_picture_link}{URL of WHO Picture of the Snake}
#'   \item{snake_common_name_other}{Other Name of the Snake Species}
#'   \item{snake_common_name_remainder}{List of Other Names of the Snake Species}
#'   \item{snake_previous_name}{Any Previous Scientific Name of the Snake Species}
#'   \item{snake_regions}{Nested Data Frame of all Regions and Sub-Regions}
#'   \item{snake_antivenoms}{Nested Data Frame of Antivenoms, Manufacturers, Countries of Origin}
#'   
#'   ...
#' }
#' @source \url{http://apps.who.int/bloodproducts/snakeantivenoms/database/}
"snake_species_data"

#' Medically Relevant Snakes In All Countries
#'
#' A dataset containing the medically relevant snake species in all countries as recorded on the WHO online database
#' 
#'
#' @format A data frame with 1324 rows and 5 variables:
#' \describe{
#'   \item{country_name}{Name Of Country As Recorded On WHO Database}
#'   \item{country_id}{Name Of Country As Recorded On WHO Database}
#'   \item{snake_family}{Medical Importance Category, Either 1 or 2}
#'   \item{snake_common_name}{Name of the Snake Species, e.g. "Common Death Adder"}
#'   \item{snake_species}{Scientific Name of the Snake Species, e.g. "Acanthophis antarcticus"}
#'   ...
#' }
#' @source \url{http://apps.who.int/bloodproducts/snakeantivenoms/database/}
"snake_country_data"