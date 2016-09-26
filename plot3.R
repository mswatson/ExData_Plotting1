setwd("C:/Users/mswatson/Documents/COURSERA/")
if(!file.exists("./exploratory_data_analysis")) {dir.create("./exploratory_data_analysis")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip?accessType=DOWNLOAD"

##1. Download zip file and unzip
download.file(fileUrl,destfile="./exploratory_data_analysis/exdata_data_household_power_consumption.zip", mode = 'wb')
file <- unzip("./exploratory_data_analysis/exdata_data_household_power_consumption.zip", exdir="./exploratory_data_analysis")

##2 read the file
powerName <- unlist(read.table(file, nrows = 1, sep=";"))
powerDb <- read.table(text = grep("^[1,2]/2/2007", readLines(file), value=TRUE),
                      col.names = powerName,
                      sep = ";", header=TRUE)
powerDb$Date <- as.Date(powerDb$Date, format="%d/%m/%Y")
DateTime <- paste(as.Date(powerDb$Date), powerDb$Time)
powerDb$DateTime <- as.POSIXct(DateTime)

##3 plot 3
with(powerDb, {
    plot(Sub_metering_1 ~ DateTime, type="l", ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2 ~ DateTime, col="red")
    lines(Sub_metering_3 ~ DateTime, col="blue")
})
legend("topright", col=c("black","red", "blue"), lty=1, lwd=1,
       cex=0.7, x.intersp = 1, y.intersp = 1, inset=0.05, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()