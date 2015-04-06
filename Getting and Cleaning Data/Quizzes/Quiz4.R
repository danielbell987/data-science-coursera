## Daniel Bell
## Getting and Cleaning Data
## Quiz 4

## Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file <- "C:/Data/Coursera/GettingAndCleaningData/communityData.csv"
download.file(url = url, destfile = file)
community <- read.csv(file = file)
community <- data.table(community)

split <- strsplit(names(community), "wgtp")
split[[123]]

## Question 2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
file <- "C:/Data/Coursera/GettingAndCleaningData/GDPdata.csv"
download.file(url = url, destfile = file)

dtGDP <- data.table(read.csv(file, skip=4, nrows=215, stringsAsFactors=FALSE))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", dtGDP$gdp))
mean(gdp, na.rm=TRUE)


## Question 3
isUnited <- grepl("^United", dtGDP$Long.Name)
summary(isUnited)


## Question 4
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
file <- "C:/Data/Coursera/GettingAndCleaningData/EDSTATS_Country.csv")
download.file(url, file)
dtEd <- data.table(read.csv(file))

dt <- merge(dtGDP, dtEd, all=TRUE, by=c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)


## Question 5
library(quantmod) 
amzn = getSymbols("AMZN",auto.assign=FALSE) 
sampleTimes = index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))