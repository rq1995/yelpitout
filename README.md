# Yelp API   


### Project contributors:

1. [Yinghua Guan](https://github.com/vinverguan)
2. [Ying Dong](http://github.com/yvonnedy)
3. [Ruoqi Xu](https://github.com/rq1995)
4. [Longlingzi Yao](https://github.com/yllz)

### Introduction

Our package intends to explore ...

### To install please execute the following in `R`:

`devtools::load_all()`

`devtools::install_github("vinverguan/yelpitout")`

### How to use:

Usage: `search(category, location)`  
Input: 

- `category`: a string representing the category of business
- `location`: a city name

Output: a data frame containing names, ratings and price levels

Example:

```
search("Chinese", "Vancouver")
```

--

Usage: `phone_number(business)`  
Input: 

- `business`: a string representing the name of the business

Output: a string of the phone number

Example:

```
> phone_number("Soirette")
"(604)558-3308"
```

--

Usage: `location_map(yelp_key, category, city)`  
Input:   

- `yelp_key`: a string representing a Yelp API key
- `category`: a string representing the category of business
- `city`: a city name

Output:  a google map including locations of the top 5 businesses (ordered by review count)

Example:

```
> my_key <- 'hzKLMV3efwrnQNdID0ivQ4JonOFIoaJzXuOEDsGbst7PIMAZv5bYBa7Kh_rfZiLlw7iyDFXeFkY2RhsFiGl9euSoE1xBAxSLpQhXJpGlRiEtegzEHMMhy9cdkwK7WnYx'
> location_map(my_key, "cafe", "Vancouver")
```
![](image/function3_output.png)
--
