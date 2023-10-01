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

#Get DBS stock price between today and 365 days ago
DBS = tq_get("D05.SI", get = "stock.price")#, from = TTM, to = Now1)

#remove all NAs
DBS = na.omit(DBS) #remove all rows with NA in data

#Get annual stock returns
get_annual_returns = function(stock.returns) {
  stock.returns %>%
    tq_transmute(select = adjusted,
                 mutate_fun = periodReturn,
                 type = "log",
                 period = "yearly")
}
DBS_annual_log_returns = get_annual_returns(DBS)
DBS_annual_log_returns

#graph
DBS_annual_log_returns %>%
  ggplot(aes(x=year(date),y=yearly.returns))+
  geom_hline(yintercept = 0, color = palette_light()[[1]])+
  geom_point(size = 2 ,color = palette_light()[[3]])+
  geom_line(size=1,color = palette_light()[[3]])+
  geom_smooth(method = 'y~x' ,se = FALSE)+
  labs(title = 'DBS: Visualizing Trends in Annual Returns',
       y = 'Annual Returns', x='',colour='')+
  theme_tq()
