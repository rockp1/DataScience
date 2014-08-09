# Plot 2 - Line graph of Global Active Power over the two-day period

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

# X-axis has no label (xlab = ""), no ticks (xaxt='n'). Will add with axis() function
plot(GAP, xlab = "", xaxt='n', ylab="Global Active Power (kilowatts)", type='l')  
axis(1, at=c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))
dev.copy(png, file = "plot2.png")
dev.off()