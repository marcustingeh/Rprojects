#Install Library
library(quantmod)
library(tidyverse)
library(tidyquant)
library(lubridate)

#Get current date
Now1 = Sys.Date()
Now2 = Now1 %m-% days(1)

#Subtract 365 days from current date
#TTM = Now2 %m-% days(365)

#Get DBS stock price 
DBS = tq_get("D05.SI", get = "stock.price", from = "2010-01-01",to = Now1) 

#Take DBS daily prices for monthly returns quarterly
DBS_monthly = DBS %>%
  tq_transmute(select = adjusted,
               mutate_fun = periodReturn,
               period = "monthly",
               col_rename = "Ra")

DBS_monthly %>% ggplot(aes(x=date, y=Ra))+
  geom_line()


#density plot
DBS_monthly %>%
  ggplot(aes(x = Ra,fill= date))+
  geom_density(alpha=0.3)
