#Download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip", exdir="household_power_consumption")

#Read data
dat <- read.table("household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

#Change date format and combine date and time
#And select a subset
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat_sub <- subset(dat, dat$Date=="2007-02-01" | dat$Date=="2007-02-02")
dat_sub$datetime <- paste(dat_sub$Date, dat_sub$Time)
dat_sub$datetime <- strptime(dat_sub$datetime, "%Y-%m-%d %H:%M:%S")

#Convert factor to quatitative variable
dat_sub$Global_active_power <- as.numeric(dat_sub$Global_active_power)

#Plot data
#Type l is for line
#xlab is empty. Can someone tell me how do I get the day of the week there?
plot(dat_sub$datetime, dat_sub$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, width = 480, height = 480, file = "plot2.png")

#close device
dev.off()