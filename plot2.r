library(dplyr)
setwd("C:/Users/Daniel/Desktop/Coursera/Exploratory data analysis")
par(mfrow=c(1,1))

#read data
electricpc <- read.table("household_power_consumption.txt", skip=1, sep=";", stringsAsFactors = F)
colnames(electricpc) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

#convert date column to date class
electricpc$date <- as.Date(electricpc$date,format = "%d/%m/%Y")

#subset by 2007-02-01 and 2007-02-02
subPC <- subset(electricpc, between(electricpc$date, as.Date("2007-02-01"), as.Date("2007-02-02")))

#convert time column to time class
datetime <- paste(subPC$date,subPC$time)
subPC$datetime <- as.POSIXct(datetime)

#change Global_Active_Power to numeric
subPC$global_active_power <-as.numeric(subPC$global_active_power)

#create plot
with(subPC,plot(datetime,global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

#save to png
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()

