#Install Library
library(quantmod)
library(tidyverse)
library(tidyquant)
library(lubridate)

#Get current date
Now1 = Sys.Date()
Now2 = Now1 %m-% days(1)

#Subtract 365 days from current date
TTM = Now2 %m-% days(365)

#Get DBS stock price between today and 365 days ago
DBS = tq_get("D05.SI", get = "stock.price", from = TTM, to = Now1)

#remove all NAs
DBS = na.omit(DBS) #remove all rows with NA in data

#Create new colums for SMA 50 and 200. Renaming it
DBS %>% 
  tq_mutate_xy(x = close, mutate_fun = SMA, n = 50) %>%
  rename(SMA.50 = SMA) %>%
  tq_mutate_xy(x = close, mutate_fun = SMA, n = 200) %>%
  rename(SMA.200 =SMA)

DBS <- DBS %>%
  tq_mutate_xy(x = close, mutate_fun = SMA, n = 50) %>%
  rename(SMA.50 = SMA) %>%
  tq_mutate_xy(x = close, mutate_fun = SMA, n = 200) %>%
  rename(SMA.200 = SMA)


DBS %>% select(date, close, SMA.50, SMA.200) %>%
  gather(key = type, value = price, close:SMA.200)


my_palette <- c("black", "blue", "red")
DBS %>%
  select(date, close, SMA.50, SMA.200) %>%
  gather(key = type, value = price, close:SMA.200) %>%
  ggplot(aes(x = date, y = price, col = type)) +
  geom_line() +
  scale_colour_manual(values = my_palette) + 
  theme(legend.position="bottom") +
  ggtitle("Simple Moving Averages of DBS") +
  xlab("") + 
  ylab("Stock Price")
