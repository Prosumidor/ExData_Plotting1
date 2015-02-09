setwd("./DATA")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="./power.zip",
              method ="curl")
unzip("./power.zip")
library(dplyr)
power <- filter((read.table("./household_power_consumption.txt", 
                            sep=";", 
                            header=T, 
                            dec=".", 
                            na.strings="?",
                            colClasses=c("character","character",
                                         "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
), 
Date=="1/2/2007" | Date=="2/2/2007")
power$DT <- paste(power$Date, power$Time)
power$DT <- as.POSIXct(strptime(power$DT, "%d/%m/%Y %H:%M:%S"))
power$Weekdays <- as.factor(weekdays(power$DT))

## Making Plot
par(mfrow = c(2,2))
with(power, {
  ##plot 1
  plot.ts(power$Global_active_power,  
          ylab="Global Active Power (kilowatts)",
          xlab=NULL,
          type="s",
          xaxt="n")
  axis(1, at=c(0,1450,2900), label=c("Thu", "Fri", "Sat"))
  ##plot 2
  plot.ts(power$Voltage,  
          ylab="Voltage",
          xlab="datetime",
          type="s",
          xaxt="n")
  axis(1, at=c(0,1450,2900), label=c("Thu", "Fri", "Sat"))
  ##plot 3
  plot.ts(power$Sub_metering_1,
          ylab="Energy sub mettering",
          xlab=NULL,
          type="s",
          xaxt="n")
  lines(power$Sub_metering_2, col="red")
  lines(power$Sub_metering_3, col="blue")
  ##legend("topright", c("Sub_mettering_1", "Sub_mettering_2", "Sub_mettering_3"),lty=1, lwd=1,col=c("black", "red", "blue"))
  axis(1, at=c(0,1450,2900), label=c("Thu", "Fri", "Sat"))
  ##plot4
  plot.ts(power$Global_reactive_power,  
          ylab="Global_reactive_power",
          xlab="datetime",
          type="s",
          xaxt="n")
  axis(1, at=c(0,1450,2900), label=c("Thu", "Fri", "Sat"))
})  

dev.copy(png, file="./plot4.png", 
         width=480,
         height=480)
dev.off()