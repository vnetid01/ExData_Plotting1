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


#Plot 3

plot(db$datetime,db$Sub_metering_1,type="l",xlab="",ylab="Energy Sub metering")
#new plots nested in the present plot
points(db$datetime,db$Sub_metering_2,col="red",type="l",xlab="",ylab="Energy Sub metering")
points(db$datetime,db$Sub_metering_3,col="blue",type="l",xlab="",ylab="Energy Sub metering")

#define legend for the plot along with position, colors and labels for each plot added
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#print to graphic device :PNG
dev.copy(png,"plot3.png")
dev.off()


