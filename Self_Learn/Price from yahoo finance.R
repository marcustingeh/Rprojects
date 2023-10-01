#Install Library
library(quantmod)
library(tidyverse)
library(tidyquant)

#get data for stock prices DBS
price=tq_get("D05.SI",get = "stock.price")

#see what data is available
tq_get_options()

#Get multiple stock prices, Visa then apple.
multipleS = tq_get(c("V","AAPL"),get = "stock.prices", from= "2023-01-01", to= "2023-07-31")
