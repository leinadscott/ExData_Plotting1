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

#change sub_metering_1-3 to numeric
subPC$sub_metering_1 <-as.numeric(subPC$sub_metering_1)
subPC$sub_metering_2 <-as.numeric(subPC$sub_metering_2)
subPC$sub_metering_3 <-as.numeric(subPC$sub_metering_3)

#--------------------------------

#set par
par(mfrow = c(2,2))

#create top left chart (same as plot2)
with(subPC,plot(datetime,global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

#create top right chart
#convert voltage to numeric
subPC$voltage <-as.numeric(subPC$voltage)
with(subPC,plot(datetime, voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

#create bottom left chart, same as plot3
with(subPC,plot(datetime, sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
with(subPC,lines(datetime, sub_metering_1, type = "l"))
with(subPC,lines(datetime, sub_metering_2, type = "l", col = "red"))
with(subPC,lines(datetime, sub_metering_3, type = "l", col = "blue"))

#add the legend
legend("topright", bty = "n", lty = 1, cex = 0.7, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#create bottom right chart
#convert global reactive power to numeric
subPC$global_reactive_power <-as.numeric(subPC$global_reactive_power)
with(subPC, plot(datetime, global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

#save to png
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

