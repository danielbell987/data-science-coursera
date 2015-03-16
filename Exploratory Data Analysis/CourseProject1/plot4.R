## Import Data
data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

## Convert Date columns to correct class
data[1] <- lapply(data[1], function(x) as.Date(x,format="%d/%m/%Y"))

## Remove all data that doesn't have correct dates
data <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02",]

## Convert time variable to correct class
data[2] <- as.POSIXct(paste(data$Date, as.character(data$Time)))

## Convert variable Global_reactive_power to numeric class
data[3] <- as.numeric(as.character(data[,3]))
data[4] <- as.numeric(as.character(data[,4]))
data[5] <- as.numeric(as.character(data[,5]))

## Convert sub_metering varables to numeric class
data[,7] <- as.numeric(as.character(data[,7]))
data[,8] <- as.numeric(as.character(data[,8]))
data[,9] <- as.numeric(as.character(data[,9]))

## Plot the four graphs and save as png file
png("plot4.png", width = 480, height = 480)

## Seperate the plot into 4 sections
par(mfrow=c(2,2))

## Plot the GAP timeseries graph in the top left (see plot1)
plot(x=data$Time, y=data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## Plot the voltage timeseries graph in the top right
plot(x=data$Time, y=data$Voltage, type="l", xlab="datetime", ylab="Voltage")

## Plot the sub_metering timeseries graph in bottom left (see plot3)
plot(x=data$Time, y=data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x=data$Time, y=data$Sub_metering_2, type="l", col="red")
lines(x=data$Time, y=data$Sub_metering_3, type="l", col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1),      
       lwd=c(2,2),        
       col=c("black","red","blue"))

## Plot GRP timeseries graph in bottom right
plot(x=data$Time, y=data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()