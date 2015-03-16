## Import Data
data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

## Convert Date columns to correct class
data[1] <- lapply(data[1], function(x) as.Date(x,format="%d/%m/%Y"))

## Remove all data that doesn't have correct dates
data <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02",]

## Convert variable Global_reactive_power to numeric class
data[3] <- as.numeric(as.character(data[,3]))

## Plot histogram of Global_reactive_power
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, breaks=16, ylim=c(0, 1200), xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()