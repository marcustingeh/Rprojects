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

DBS_macd = DBS %>% tq_mutate(select = close,
                             mutate_fun = MACD,
                             nFast = 12,
                             nSlow = 26,
                             nSig = 9,
                             maType=SMA) %>%
  mutate(diff=macd-signal) %>% select(-(open:volume))

DBS_macd %>%
  ggplot(aes(x=date)) +
  geom_hline(yintercept = 0, colour = palette_light()[[1]])+
  geom_line(aes(y=macd,col=symbol))+
  geom_line(aes(y=signal), colour = "blue",linetype =2)+
  geom_bar(aes(y=diff),stat="identity",color=palette_light()[[1]])+
  facet_wrap(~ symbol,ncol = 2,scale = "free_y")+
  labs(title = 'DBS:Moving Average Convergence Divergence',
       y = 'MACD', x='',colour='')+
  theme_tq()+scale_color_tq()
