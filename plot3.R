#using dplyr library
library(dplyr)

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
png("plot3.png", width=480, height=480)

#create empty plot
with(febData, plot(Sub_metering_1 ~ datetime,  type = "n",
     ylab="Energy sub metering", xlab=""))

#add Sub_metering_1
lines(febData$datetime, febData$Sub_metering_1, col="black")
#add Sub_metering_2
lines(febData$datetime, febData$Sub_metering_2, col="red")
#add Sub_metering_3
lines(febData$datetime, febData$Sub_metering_3, col="blue")

#add Legend for the plot
legend("topright", lty=c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#close PNG device
dev.off()