#' Produces a table of 50 businesses 
#
#' @title search
#' @param yelp_key a string representing the Yelp API key
#' @param category a string representing the category of the business
#' @param city a string representing a city name
#' @return a dataframe
#'
#' @import dplyr
#' @import httr
#'
#' @export
#'
#' @examples
#' search("your_yelp_key", "cafe", "Vancouver")
 
search <- function(yelp_key, category, city) {
  
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
                        function(x) x[c('name','rating','review_count')])
    
    result_df <- data.frame(matrix(unlist(yelp_list),
                                   nrow = 50,
                                   byrow = T),
                            stringsAsFactors = FALSE)
  })
  names(result_df)<-c('name','rating','review_count')
  print(result_df)
}