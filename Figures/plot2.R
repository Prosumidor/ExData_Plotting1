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
plot.ts(power$Global_active_power,  
        ylab="Global Active Power (kilowatts)",
        xlab=NULL,
        type="s",
        xaxt="n")
axis(1, at=c(0,1450,2900), label=c("Thu", "Fri", "Sat"))
dev.copy(png, file="./plot2.png", 
         width=480,
         height=480)
dev.off()