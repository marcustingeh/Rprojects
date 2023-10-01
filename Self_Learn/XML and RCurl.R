#Tutorial how to read table in website using XML and RCurl
library(XML)
library(RCurl)

#website that is interested
url="https://en.wikipedia.org/wiki/2016_Summer_Olympics#Medal_table"

urldata = getURL(url)

data = readHTMLTable(urldata,
                     stringAsFactors = FALSE)

names(data)
head(data)

x=data$'2016 Summer Olympics medal table'

head(x)
