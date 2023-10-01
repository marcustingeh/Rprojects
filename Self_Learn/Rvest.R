library(rvest)

url="https://lol.fandom.com/wiki/SK_Telecom_T1"

FromerPlayerSKT = url %>% read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/div[2]/table[3]') %>% html_table(fill=TRUE)

FromerPlayerSKT = FromerPlayerSKT[[1]]
head(FromerPlayerSKT)
