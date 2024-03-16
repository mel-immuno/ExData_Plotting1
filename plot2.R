# Construction of the `plot2.png` plot

## Download dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
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
par(mar=c(2, 4, 1, 1))
with(selected_data, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))

## Create PNG file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
