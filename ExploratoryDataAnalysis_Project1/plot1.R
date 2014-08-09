# Plot 1 - Histogram of Global Active Power

# *** BEGIN Clean & Transform ****

library(data.table)
# Alert: The file "household_power_consumption.txt" must be in the Work Directory

# Read in the file, and subset it to only the dates being analyzed
power <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
powerDT <- power[which(power$Date %in% c("1/2/2007", "2/2/2007")),]

# Convert the Date and Time variables to a single variable called 'dateTime' of type Date
dateTime <- paste(powerDT$Date, powerDT$Time)
dateTime <- strptime(dateTime, "%d/%m/%Y %H:%M:%S")

# Convert all other variables to numeric
GAP <- as.numeric(powerDT$Global_active_power)
GRP <- as.numeric(powerDT$Global_reactive_power)
V <- as.numeric(powerDT$Voltage)
SM1 <- as.numeric(powerDT$Sub_metering_1)
SM2 <- as.numeric(powerDT$Sub_metering_2)
SM3 <- as.numeric(powerDT$Sub_metering_3)

# *** END Clean & Transform ****

# Plot the histogram
hist(GAP, breaks=12, freq=TRUE, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red", border="black")
# axis(2, at=seq(0,1200,by=200))

# Print to PNG graphic format
dev.copy(png, file = "plot1.png")
dev.off()