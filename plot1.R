#using dplyr library
library(dplyr)

#just to cut down on loading same data each time
if(!exists("powerData"))
    powerData <- read.table("household_power_consumption.txt", header = TRUE,
                            sep=";", na.strings="?")


#filter data by date. 
#Don't need time since we are looking for all data in the two days
febData <- filter(powerData, Date == "1/2/2007" | Date == "2/2/2007")

#open device for a PNG file
png("plot1.png", width=480, height=480)

#draw hist to file
with(febData, hist(Global_active_power, xlab="Global Active Power (kilowatts)", 
                   main="Global Active Power", c="red"))

#close PNG device
dev.off()