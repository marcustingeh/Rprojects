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

#Create line graph for DBS
DBSlinegraph = DBS%>% ggplot(aes(x=date,y=close))+
  geom_line()+labs(title= "DBS Line Chart", y="Closing Price",x="")+theme_tq()

#Print DBS graph
DBSgraph

#Create bar graph for DBS
DBSbargraph = DBS >%> ggplot(aes(x=date,y=close))+
  geom_barchart(aes(open=open,high=high,low=low,high=high,close=close))+
  labs(title = "DBS Bar Chart",y="Closing Price")

