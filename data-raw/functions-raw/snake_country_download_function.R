#' This function is used by the snake_country_data script, to create a data_frame listing all countries and the snakes they contain
#'
#' @param x the address for selenium to find the next country
#' @param country_id the ID WHO uses for countries
#' @param country_name the name of the country
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' snake_country_download()

snake_country_download <- function(x, country_id, country_name){
  # Then Go To Our Country
  remDr$navigate("http://apps.who.int/bloodproducts/snakeantivenoms/database/SearchFrm.aspx") # First we load the databas
  element<- remDr$findElement(using = 'css selector', x)
  element$clickElement() #We'll need to create a way to insert the country into that child form
  
  # Then Extract The Snake Page
  country_html <- xml2::read_html(remDr$getPageSource()[[1]])
  
  country_table <- country_html %>%
    rvest::html_node("#SnakesGridView") %>%
    rvest::html_table(fill = TRUE)
  
  # Then Determine If There Are More Pages
  more_pages <- length(country_table) > 4
  
  if(more_pages == TRUE){
    # Then Work Out Exactly How Many More Pages
    country_table_number <- country_html %>%
      rvest::html_node("#SnakesGridView") %>%
      rvest::html_node("tbody > tr:nth-child(12)") %>%
      rvest::html_node("td") %>%
      rvest::html_node("table") %>%
      rvest::html_node("tr") %>%
      rvest::html_nodes("td") %>%
      length()
    
    # Then create a data frame, with new address from us to download these from
    country_pages <- dplyr::data_frame(
      page_number = 1:country_table_number,
      page_element = stringr::str_c("#SnakesGridView > tbody > tr:nth-child(12) > td > table > tbody > tr > td:nth-child(", page_number, ")"))
    
    country_pages <- country_pages[-1,]
    country_pages <- country_pages[,2]
    
    # Then use a secondary function to download these
    secondary_country <- purrr::pmap(country_pages, snake_country_secondary_download) %>%
      dplyr::bind_rows()
    
    # Then, for countries that we had to download multiple pages, merge them all together
    country_table <- dplyr::bind_rows(country_table, secondary_country)
    country_table <- country_table[,1:4] %>%
      dplyr::filter(is.na(`Link*`))
  }
  
  country_table <- country_table %>%
    dplyr::mutate(country_id = country_id,
           country_name = country_name)
  
  message(country_name)
  country_table
}