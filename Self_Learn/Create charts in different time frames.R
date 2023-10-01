#Install Library
library(quantmod)
library(tidyverse)
library(tidyquant)
library(lubridate)

#I think it changes the FANG database
FANG %>% group_by(symbol) %>% tq_transmute(
  select = open:volume,mutate_fun = to.period,
  period = 'months')

#group FANG by symbols?
FANG_daily = FANG %>% group_by(symbol)

#Daily chart
FANG_daily %>% ggplot(aes(x=date,y=adjusted,colour = symbol))+
  geom_line()+
  labs(title="Daily Stock Prices",
       x="",y="Adjusted Prices", color = "")+
facet_wrap(~ symbol,ncol=2,scales="free_y")+
  scale_y_continuous(labels=scales::dollar)+
  theme_tq()+
  scale_color_tq()

#Get monthly data
FANG_monthly = FANG %>%
  group_by(symbol) %>%
  tq_transmute(select=adjusted,
               mutate_fun = to.period,
               period = "months")

#Get monthly chart
FANG_monthly %>% ggplot(aes(x=date,y=adjusted,colour = symbol))+
  geom_line()+
  labs(title="Monthly Stock Prices",
       x="",y="Adjusted Prices", color = "")+
  facet_wrap(~ symbol,ncol=2,scales="free_y")+
  scale_y_continuous(labels=scales::dollar)+
  theme_tq()+
  scale_color_tq()
