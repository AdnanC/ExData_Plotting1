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

#can also use the following to get datetime.
# febData$DateTime <- strptime(paste(febData$Date,febData$Time),
#                                                       "%d/%m/%Y %H:%M:%S")

#open device for a PNG file
png("plot2.png", width=480, height=480)

#plot to file
plot(febData$datetime, febData$Global_active_power,type="l",
     ylab="Global Active Power (kilowatts)",xlab="")

#close PNG device
dev.off()