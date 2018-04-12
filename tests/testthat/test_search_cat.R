require(dplyr)
require(httr)

context("testing search_cat")

test_that("test input", {

  # check that the produced output is a data frame
  expect_equal(
    is.data.frame(
      search_cat(Sys.getenv("yelp_key"),
                   'cafe',
                   'Vancouver')),
    TRUE)

  # expected errors
  expect_error(search_cat(list('dniwufowwfw'),
                            'cafe',
                            'Vancouver'),
               "Error: Yelp key type is not accepted, expected a string instead")
  expect_error(search_cat(Sys.getenv("yelp_key"),
                            2,
                            'Vancouver'),
               "Error: Category type is not accepted, expected a string instead")
  expect_error(search_cat(Sys.getenv("yelp_key"),
                            'cafe',
                            list('Kelowna')),
               "Error: City name is not accepted, expected a string instead")
  expect_error(search_cat('MMhy9cdkwK7WnYx',
                            'cafe',
                            'Kelowna'),
               "Error: Invalid Yelp key")
})
