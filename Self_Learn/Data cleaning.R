library(MASS) #get data sets from R
data()
data(airquality)

??airquality #details of R in helppages
str(airquality) 
head(airquality)

aq = na.omit(airquality) #remove all rows with NA in data
head(aq)
summary(aq)

#replace NA with 0
aq2 = airquality
aq2[is.na(aq2)] = 0
head(aq2)

#replace NA with mean
meanOzone=mean(airquality$Ozone,na.rm = T) #rm=T means that remove NA before computing
aq2.fix=ifelse(is.na(airquality$Ozone),meanOzone,airquality$Ozone)
summary(aq2.fix)

#visualisation of NA
library(mice)
md.pattern(airquality) #showing # of rows that have NA or no NA

library(VIM)
mp = aggr(airquality, col=c('navyblue','yellow'),
          numbers = TRUE,sortvars = TRUE,
          labels=names(airquality),cex.axis=.7,
          gap = 3,ylab=c("Missing Data","Pattern"))
