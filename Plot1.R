#Plotting Assignment 1 for Exploratory Data Analysis
#ExData_Plotting1 - Plot1
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
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#Open png device and send histogram
png(file="plot1.png",width=480,height=480)

hist (data$Global_active_power, 
      col="red", 
      main="Global Active Power", 
      xlab="Global Active Power (kilowatts)")

dev.off()