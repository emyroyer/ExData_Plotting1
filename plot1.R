#Download and unzip the dataset
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip", exdir="household_power_consumption")

#Read the dataset
dat <- read.table("household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

#Show the file first lines
head(dat)

#Dimension of the data.frame and other useful information
dim(dat)
str(dat)
summary(dat)
names(dat)

#Change date format from Y/m/d to d/m/Y
#Convert between character representations and objects of class "Date" representing calendar dates. 
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")

#Only take a subset od the data from 2007-02-01 to 2007-02-02
dat_sub <- subset(dat, dat$Date=="2007-02-01" | dat$Date=="2007-02-02")

#Combining Date and Time in the dat_sub$datetime variable
dat_sub$datetime <- paste(dat_sub$Date, dat_sub$Time)

#convert between character representations and objects of classes "POSIXlt" and "POSIXct" representing calendar dates and times.
dat_sub$datetime <- strptime(dat_sub$datetime, "%Y-%m-%d %H:%M:%S")
str(dat_sub$datetime)

#Convert factor to a quantitative variable
dat_sub$Global_active_power <- as.numeric(dat_sub$Global_active_power)
#Check it is numeric
is.numeric(dat_sub$Global_active_power)

#Plot the histogram
hist(dat_sub$Global_active_power, ylim=c(0,1200), xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red",bty="n")
dev.copy(png, width = 480, height = 480, file = "plot1.png")

#Close the device
dev.off()