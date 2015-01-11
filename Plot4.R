#Plotting Assignment 1 for Exploratory Data Analysis
#ExData_Plotting1 - Plot4
#==========================

#Install required packages
#downloader for wrapper for download.file
#data.table package for fread function
#lubridate for dates
install.packages(c("downloader", "lubridate", "data.table"))

#Load required packages 
library (data.table)
library (grDevices)
library (downloader)
library (lubridate)

#Download zipped data resource from URL, unzip; "curl" needed for https & mac
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
         dest="dataset.zip") 
unzip ("dataset.zip")
unlink ("dataset.zip")

#Extract data for 2007-02-01 & 2007-02-02
#[12] is either day 1 or day 2
data <- fread(paste("grep ^[12]/2/2007", "household_power_consumption.txt"),
              na.strings = c("?", ""))

#Set column names & format Date column
setnames(data, colnames(fread("household_power_consumption.txt", nrows=0)))

#Merge date and time columns using lubridate
data$DateTime <- paste (data$Date, data$Time, sep=" ")
data$DateTime <- dmy_hms(data$DateTime)

#Open png device and send histogram
png(file="plot4.png",width=480,height=480)

par(mfrow=c(2,2))

#Top Left Plot
plot(round_date(data$DateTime, "minute"), data$Global_active_power, 
     type = "l", 
     xlab = NA, 
     ylab = "Global Active Power")

#Top RIght Plot
plot(round_date(data$DateTime, "minute"), data$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

#Bottom Left Plot
plot(round_date(data$DateTime, "minute"), data$Sub_metering_1, 
     type = "l", 
     xlab = NA, 
     ylab = "Energy sub metering")

lines(round_date(data$DateTime, "minute"), data$Sub_metering_2, col="red")
lines(round_date(data$DateTime, "minute"), data$Sub_metering_3, col="blue")

legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1, 1, 1), 
       col=c("black", "red", "blue"), 
       bty="n")

#Bottom Right Plot
plot(round_date(data$DateTime, "minute"), data$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off()
