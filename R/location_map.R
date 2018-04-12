#' Produces a google map visualization of top 5 businesses (ordered by review count)
#
#' @title location map
#' @param yelp_key a string representing the Yelp API key
#' @param category a string representing the category of the business
#' @param city a string representing a city name
#' @return a google map visualization of the top 5 business based on review counts
#' @author Linsey Yao, Apr 10
#'
#' @import ggmap
#' @import ggplot2
#' @importFrom utils head
#' @import magrittr
#' @import dplyr
#' @import httr
#'
#' @export
#'
#' @examples
#' location_map("your_yelp_key", "cafe", "Vancouver")

location_map <- function(yelp_key, category, city) {

  if (is.character(yelp_key) == FALSE) {
    stop("Error: Yelp key type is not accepted, expected a string instead")
  }
  if (is.character(category) == FALSE) {
    stop("Error: Category type is not accepted, expected a string instead")
  }
  if (is.character(city) == FALSE) {
    stop("Error: City name is not accepted, expected a string instead")
  }

  get_yelp <- GET('https://api.yelp.com/v3/businesses/search',
                  query = list(term = category, location = city, limit = 50),
                  add_headers(Authorization = paste('bearer', yelp_key)))

  if (status_code(get_yelp) == 401) {
    stop("Error: Invalid Yelp key")
  }

  tryCatch({

    result <- content(get_yelp)

    yelp_list <- lapply(result$businesses,
                        function(x) x[c('name', 'review_count', 'coordinates')])

    result_df <- data.frame(matrix(unlist(yelp_list),
                                   nrow = 50,
                                   byrow = T),
                            stringsAsFactors = FALSE)

    names(result_df) <- c('name', 'review_count', 'latitude', 'longitude')

    result_df$review_count <- as.integer(result_df$review_count)
    result_df$longitude <- as.numeric(result_df$longitude)
    result_df$latitude <- as.numeric(result_df$latitude)

    top_results <- result_df %>% dplyr::arrange(desc(review_count)) %>% head(5)

    local_map <- ggmap::get_map(location = c(lon = mean(top_results$longitude),
                                             lat = mean(top_results$latitude)),
                                zoom = 13,
                                maptype = "hybrid",
                                scale = 2)

    ggmap::ggmap(local_map) +
      ggplot2::geom_point(data = top_results,
                          aes(x = longitude, y = latitude, fill = "red", alpha = 0.9),
                          size = 4,
                          shape = 21) +
      ggplot2::guides(fill = FALSE,
                      alpha = FALSE,
                      size = FALSE)},
    error = function(e) {
      stop("Error: Something unknown went wrong in location_map")})
}
