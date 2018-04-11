


name_match <- function(key, name, city, state, country) {
  
  if (is.character(key) == FALSE) {
    stop("Error: Yelp key type is not accepted, expected a string instead")
  }
  if (is.character(name) == FALSE) {
    stop("Error: Name of the business is not accepted, expected a string instead")
  }
  if (is.character(city) == FALSE) {
    stop("Error: City name is not accepted, expected a string instead")
  }
  if (is.character(state) == FALSE) {
    stop("Error: State name is not accepted, expected a string instead")
  }
  if (is.character(country) == FALSE) {
    stop("Error: Country name is not accepted, expected a string instead")
  }
  
  get_yelp <- GET('https://api.yelp.com/v3/businesses/matches/best', query = list(name = name, city = city, state = state, country = country), add_headers(Authorization = paste('bearer', key)))
  
  if (status_code(get_yelp) == 401) {
    stop("Error: Invalid Yelp key")
  }
  
  tryCatch({
    
    result <- content(get_yelp)
    
    yelp_list <- lapply(result$businesses, function(x) x[c('name', 'phone', 'location')])
    
    result_df <- data.frame(matrix(unlist(yelp_list), nrow = 1, byrow = T), stringsAsFactors = FALSE)
    result_df <- result_df %>% 
      select(X1, X2, X10, X7) 
    names(result_df) <- c('Name', 'Phone', 'Location', 'Postal Code')
    
    return(result_df)},
    
    error = function(e) {
      stop("Error: Something unknown went wrong in the function.")})
}