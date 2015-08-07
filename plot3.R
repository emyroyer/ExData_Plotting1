#Download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip", exdir="household_power_consumption")

#Read data
dat <- read.table("household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

#Change date format, select a subset and
#combine date and time in one variable
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat_sub <- subset(dat, dat$Date=="2007-02-01" | dat$Date=="2007-02-02")
dat_sub$datetime <- paste(dat_sub$Date, dat_sub$Time)
dat_sub$datetime <- strptime(dat_sub$datetime, "%Y-%m-%d %H:%M:%S")

#Convert factor in quantitative variable
dat_sub$Global_active_power <- as.numeric(dat_sub$Global_active_power)
dat_sub$Sub_metering_1 <- as.numeric(dat_sub$Sub_metering_1)
dat_sub$Sub_metering_2 <- as.numeric(dat_sub$Sub_metering_2)
dat_sub$Sub_metering_3 <- as.numeric(dat_sub$Sub_metering_3)

#Plot data
#How do I get the name of the weekdays here? xlab is ""
#cannot figure out how the weekdays are stored in dat_sub$datetime
png(width=480,height=480,file="plot3.png")
par(bg='transparent')
plot(dat_sub$datetime, dat_sub$Sub_metering_1, ylab="Energy sub metering", xlab=NA, type="l")
lines(dat_sub$datetime,dat_sub$Sub_metering_2,col="red")
lines(dat_sub$datetime,dat_sub$Sub_metering_3,col="blue")

#legend(mean(dat_sub$datetime),max(dat_sub$Sub_metering_1), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"),cex=0.7)
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering1","Sub_metering2","Sub_metering3"),lwd=1,cex=0.7)
#dev.copy(png, width = 480, height = 480, file = "plot3.png")
dev.off()
