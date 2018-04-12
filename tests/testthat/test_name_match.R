# tests for the name_match function

library(dplyr)
library(httr)

context("Testing name_match")

API_key <- 'Q3w8J-9Vx2FccKjdzIPvVJ63qOUXNjxAnnvFMt9xlRQMVrV5nFtjGwfgz6b3__MnKCTb3NOVnfAViSfgJREcDyxPX0pfY5iuH2BbgzDqMgQ3ZeOyeMrQ6VjkdSjNWnYx'

test_that("name_match() returns name, phone, location and postal code of a business that is the best match based on the name provided", {

  # test expected outputs

  expect_equal(typeof(name_match(API_key, "Starbucks", "Burnaby", "BC", "CA")), "list")

  expect_equal(typeof(name_match(API_key, "Starbucks", "Burnaby", "BC", "CA")$Name), "character")

  expect_equal(typeof(name_match(API_key, "Starbucks", "Burnaby", "BC", "CA")$Phone), "character")

  expect_equal(typeof(name_match(API_key, "Starbucks", "Burnaby", "BC", "CA")$Location), "character")

  expect_equal(typeof(name_match(API_key, "Starbucks", "Burnaby", "BC", "CA")$`Postal Code`), "character")

  # expect_errors

  # test if the key is a string, if not, yield an error
  expect_error(name_match(list(API_key), "Starbucks", "Burnaby", "BC", "CA"), "Error: Yelp key type is not accepted, expected a string instead")

  # test if business name is a string, if not, yield an error
  expect_error(name_match(API_key, 666, "Burnaby", "BC", "CA"), "Error: Name of the business is not accepted, expected a string instead")

  # test if city is a string, if not, yield an error
  expect_error(name_match(API_key, "Starbucks", list("Burnaby"), "BC", "CA"), "Error: City name is not accepted, expected a string instead")

  # test if state is a string, if not, yield an error
  expect_error(name_match(API_key, "Starbucks", "Burnaby", 666, "CA"), "Error: State name is not accepted, expected a string instead")

  # test if country is a string, if not, yield an error
  expect_error(name_match(API_key, "Starbucks", "Burnaby", "BC", 666), "Error: Country name is not accepted, expected a string instead")

  # test if yelp key can access the yelp api
  expect_error(name_match("hsFiGl9euSoE1xBAx", "Starbucks", "Burnaby", "BC", "CA"), "Error: Invalid Yelp key")

})

