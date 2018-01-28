# If it hasn't already been done, we need to load a Selenium Server
# `docker run -d -p 4445:4444 selenium/standalone-chrome`

# Then load up our browser
remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost",
                                 port = 4445L,
                                 browserName = "chrome")
remDr$open()

# Then create a country list

remDr$navigate("http://apps.who.int/bloodproducts/snakeantivenoms/database/SearchFrm.aspx")

snake_countries <- xml2::read_html(remDr$getPageSource()[[1]]) %>%
  rvest::html_nodes("#ddlCountry") %>%
  rvest::html_children() %>%
  rvest::html_attr("value") %>%
  dplyr::data_frame(country_id = .)

snake_country_names <- xml2::read_html(remDr$getPageSource()[[1]]) %>%
  rvest::html_nodes("#ddlCountry") %>%
  rvest::html_children() %>%
  rvest::html_text()

snake_countries <- snake_countries %>%
  dplyr::mutate(list_position = 1:160,
                country_name = snake_country_names,
                x = stringr::str_c("#ddlCountry > option:nth-child(",list_position, ")"))

# We chop off our first one as we are never going to navigate to there
snake_countries <- snake_countries[-1,]

# Then download our dataset
snake_countries <- snake_countries %>%
  dplyr::select(-list_position)

snake_country_data <- purrr::pmap(snake_countries, snake_country_download) %>%
  dplyr::bind_rows()

snake_country_data <- snake_country_data %>%
  dplyr::select(country_name, country_id, snake_category = `Cat**`, snake_common_name = `Common name`, snake_species = `Species name`)

# Then save our dataset!!!
readr::write_rds(snake_country_data, "./data-raw/snake_country_data_raw.rds")


