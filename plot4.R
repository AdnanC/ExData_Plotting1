#using dplyr library
library(dplyr)

#if the data doesn't exist already import
#just to cut down on loading same data each time
if(!exists("powerData"))
    powerData <- read.table("household_power_consumption.txt", header = TRUE,
                        sep=";", na.strings="?")

#first filter data by date so we have a smaller dataset
febData <- filter(powerData, Date == "1/2/2007" | Date == "2/2/2007")

#merge date time as we need to show power consumption per hour.
#mutate doesn't support POSIXlt so using as.POSIXct
febData <- mutate(febData, datetime = as.POSIXct(strptime(paste(Date, Time), 
                                                          "%d/%m/%Y %H:%M:%S")))

#open device for a PNG file
png("plot4.png", width=480, height=480)

par( mfrow = c(2,2))

#draw plot at 1,1
plot(febData$datetime, febData$Global_active_power,type="l",
     ylab="Global Active Power (kilowatts)",xlab="")

#draw plot at 1,2
plot(febData$datetime, febData$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")

#draw plot at 2,1
with(febData, plot(Sub_metering_1 ~ datetime,  type = "n",
                   ylab="Energy sub metering", xlab=""))
lines(febData$datetime, febData$Sub_metering_1, col="black")
lines(febData$datetime, febData$Sub_metering_2, col="red")
lines(febData$datetime, febData$Sub_metering_3, col="blue")
legend("topright", lty=c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#draw plot at 2,2
plot (febData$datetime, febData$Global_reactive_power, type="l", 
      xlab="datetime", ylab="Global_reactive_power")

#close PNG device
dev.off()