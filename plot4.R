# Construction of the `plot4.png` plot

## Download dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
unzip(temp, "household_power_consumption.txt")
unlink(temp)

## Read table
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## Convert time and date formats
data$Time <- format(strptime(data$Time, "%H:%M:%S"), "%H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Select dates between 2007-02-01 and 2007-02-02
selected_data <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02", ]
selected_data <- mutate(selected_data, Date = as.POSIXct(paste(selected_data$Date, selected_data$Time))) %>%
        select(- Time)

## Construct the plot
png("plot4.png")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

with(selected_data, plot(Date, Global_active_power, type = "l",xlab = "", ylab = "Global Active Power (kilowatts)"))

with(selected_data, plot(Date, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

with(selected_data, {
        plot(Sub_metering_1~Date, type = "l", xlab = "", ylab = "Energy sub metering")
        points(Sub_metering_2~Date,col="red", type = "l")
        points(Sub_metering_3~Date,col="blue", type = "l")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")
})

with(selected_data, plot(Date, Global_reactive_power, type = "l", xlab = "datetime"))



## Create PNG file
dev.off()
