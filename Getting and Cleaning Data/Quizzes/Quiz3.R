## Daniel Bell
## Getting and Cleaning Data
## Quiz 3

## Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file <- "community.csv"
download.file(url = url , destfile = file)
dat <- read.csv(file = "community.csv")

dat$agricultureLogical <- dat$ACR==3 & dat$AGS==6
which(dat$agricultureLogical)[1:3]


## Question 2
library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
file <- "pic.jpg"
download.file(url = url, destfile = file, mode = 'wb')
img <- readJPEG(file, native = TRUE)
quantile(img,c(0.3,0.8))


## Question 3
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file <- "C:/Data/Coursera/GettingAndCleaningData/GDP.csv"
download.file(url, file)
dtGDP <- data.table(read.csv(file, skip=4, nrows=215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
file <- "C:/Data/Coursera/GettingAndCleaningData/EDSTATS_Country.csv"
download.file(url, file)
dtEd <- data.table(read.csv(file))

dt <- merge(dtGDP, dtEd, all=TRUE, by=c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))
dt[order(rankingGDP, decreasing=TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13]


## Question 4
dt[, mean(rankingGDP, na.rm = TRUE), by = Income.Group]


## Question 5
breaks <- quantile(dt$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks = breaks)
dt[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]
