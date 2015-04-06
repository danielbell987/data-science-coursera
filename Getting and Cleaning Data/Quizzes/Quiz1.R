## Daniel Bell
## Getting and Cleaning Data
## Quiz 1


## Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file <- "C:/Data/Coursera/GettingAndCleaningData/communities.csv"
download.file(url = url, destfile = file)
communityData <- read.csv(file = file)
length(which(communityData$VAL == 24))

## Question 2

## ANSWER: Tidy data has one variable per column.



## Question 3
library(xlsx)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
file <- "C:/Data/Coursera/GettingAndCleaningData/gas.xlsx"
download.file(url = url, destfile = file)
dat <- read.xlsx(file = file,sheetIndex = 1,rowIndex = 18:23,colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)


## Question 4
library(XML)
library(RCurl)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xData <- getURL(url)
doc <- xmlParse(xData, useInternal=TRUE)

## Question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
file <- "C:/Data/Coursera/GettingAndCleaningData/communities2.csv"
download.file(url = url, destfile = file)
DT <- read.csv(file = file)

system.time(replicate(1000, tapply(DT$pwgtp15,DT$SEX,mean)))
system.time(replicate(1000, mean(DT[DT$SEX==1,]$pwgtp15); 
            mean(DT[DT$SEX==2,]$pwgtp15)))
system.time(replicate(1000, sapply(split(DT$pwgtp15,DT$SEX),mean)))
system.time(replicate(1000, mean(DT$pwgtp15,by=DT$SEX)))
system.time(replicate(1000, DT[,mean(pwgtp15),by=SEX]))
system.time(replicate(1000, (rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])))