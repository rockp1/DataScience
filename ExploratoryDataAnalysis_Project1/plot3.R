# Plot 3 - Overlay Plot of Sub-metering 1, 2 & 3

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

png(filename = "plot3.png")  # Plot on the png graphic device instead of StdOut, to make sure it fits
plot(SM1, xlab = "", xaxt='n', ylab="Energy sub metering", type='l', col="black")
lines(SM2, type="l", col="red")
lines(SM3, type="l", col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(1, c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

# dev.copy(png, file = "plot3.png")  # Copying from StdOut to the png device is not necessary
dev.off()