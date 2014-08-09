# Plot 4 - Four plots in One

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

# Open & Plot directly on a PNG Graphic Device.
# There will be no distortions due to doing dev.copy() from the Screen Device
png(filename = "plot4.png")
par(mfrow=c(2,2))

# Plot(1,1)
plot(GAP, xlab = "", xaxt='n', ylab="Global Active Power (kilowatts)", type='l')  
axis(1, at=c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

# Plot(1,2)
plot(V, xaxt='n', xlab="datetime", ylab="Voltage", type='l')  
axis(1, at=c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

# Plot(2,1)
plot(SM1, xlab = "", xaxt='n', ylab="Energy sub metering", type='l', col="black")
lines(SM2, type="l", col="red")
lines(SM3, type="l", col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(1, c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

# Plot(2,2)
plot(GRP, xaxt='n', xlab="datetime", ylab="Global_reactive_power", type='l')  
axis(1, at=c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

dev.off()