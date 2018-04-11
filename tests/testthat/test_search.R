require(dplyr)
require(httr)

context("testing search")

test_that("test input", {

  # expected errors
  expect_error(location_map(list('dniwufowwfw'),
                            'cafe',
                            'Vancouver'),
               "Error: Yelp key type is not accepted, expected a string instead")
  expect_error(location_map('hzKLMV3efwrnQNdID0ivQ4JonOFIoaJzXuOEDsGbst7PIMAZv5bYBa7Kh_rfZiLlw7iyDFXeFkY2RhsFiGl9euSoE1xBAxSLpQhXJpGlRiEtegzEHMMhy9cdkwK7WnYx',
                            2,
                            'Vancouver'),
               "Error: Category type is not accepted, expected a string instead")
  expect_error(location_map('hzKLMV3efwrnQNdID0ivQ4JonOFIoaJzXuOEDsGbst7PIMAZv5bYBa7Kh_rfZiLlw7iyDFXeFkY2RhsFiGl9euSoE1xBAxSLpQhXJpGlRiEtegzEHMMhy9cdkwK7WnYx',
                            'cafe',
                            list('Kelowna')),
               "Error: City name is not accepted, expected a string instead")
  expect_error(location_map('MMhy9cdkwK7WnYx',
                            'cafe',
                            'Kelowna'),
               "Error: Invalid Yelp key")
})