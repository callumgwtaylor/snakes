#' This function is used by the snake_country_download script, to create a data_frame listing the snakes on an individual page
#'
#' @param page_element the next page to load to download the snake country data
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_country_secondary_download()

snake_country_secondary_download <- function(page_element){
  
  element <- remDr$findElement(using = 'css selector', page_element)
  element$clickElement()
  
  country_html <- xml2::read_html(remDr$getPageSource()[[1]])
  
  secondary_country <- country_html %>%
  rvest::html_node("#SnakesGridView") %>%
  rvest::html_table(fill = TRUE)
  
  secondary_country
}
