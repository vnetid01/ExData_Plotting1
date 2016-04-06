#use dplyr package for code convenience

library(dplyr)
library(tidyr)

# find the parent directory location
getwd()

# downloading archive from UCI Irvine website
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","url_file.zip")

unzip(paste("./","url_file.zip",sep = ""),exdir="UCI files")

# set working directory to project location
setwd(paste("./","UCI files",sep=""))
dir()
#determine file size extracted

file.size("household_power_consumption.txt")

db<-data.frame(read.table("household_power_consumption.txt",header=T,sep=";",na.strings = "?"))


# select required dates for base plots
db<-db[db$Date=="1/2/2007"|db$Date=="2/2/2007",]
head(db)
nrow(db)
object.size(db)


# initiate new date/time variable in data frame by using strptime
db$datetime<-strptime(paste(db$Date," ",db$Time),"%d/%m/%Y %T")

#Base plotting exercises

#plot 4
par(mfrow = c(2, 2))

# plot 1 (NW)
plot(db$new, db$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")


# plot 2 (NE)
plot(db$new, db$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

# plot 3 (SW)
plot(db$new,db$Sub_metering_1,type="l",xlab="",ylab="Energy Sub metering")
points(db$new,db$Sub_metering_2,col="red",type="l",xlab="",ylab="Energy Sub metering")
points(db$new,db$Sub_metering_3,col="blue",type="l",xlab="",ylab="Energy Sub metering")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot 4 (SE)
plot(db$new, db$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0, 0.5))

#print to graphic device :PNG
dev.copy(png,"plot4.png")
dev.off()

