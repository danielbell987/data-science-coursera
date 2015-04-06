## Daniel Bell
## Getting and Cleaning Data
## Quiz 2


## Question 1

## ANSWER: 2013-11-07T13:25:07Z


## Question 2
library(sqldf)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
file <- "C:/Data/Coursera/GettingAndCleaningData/communities.csv"
download.file(url = url, destfile = file)
acs <- read.csv(file = file)
sqldf("select pwgtp1 from acs where AGEP < 50")


## Question 3
sqldf("select distinct AGEP from acs")


## Question 4
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
data <- readLines(url)
a <- c(10,20,30,100)
nchar(data[a])


## Question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
file <- "C:/Data/Coursera/GettingAndCleaningData/data.for"
download.file(url = url, destfile = file)
data <- read.fwf(file = file, skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(data$V4)
