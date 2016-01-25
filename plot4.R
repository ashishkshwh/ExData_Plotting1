data = read.table("household_power_consumption.txt",
                  header = TRUE, sep = ";",
                  na.strings = "?")

newdata <- data[
    (as.Date(data$Date, "%d/%m/%Y") <= "2007-02-02") 
    & (as.Date(data$Date, "%d/%m/%Y") >= "2007-02-01"),]

tidy_dat3 <- data.frame(
    strptime(
        paste(newdata$Date,newdata$Time), "%d/%m/%Y %H:%M:%S"),
    newdata$Sub_metering_1,
    newdata$Sub_metering_2,
    newdata$Sub_metering_3,
    newdata$Global_active_power,
    newdata$Voltage,
    newdata$Global_reactive_power)

names(tidy_dat3) <- c("MDYHMS",
                      "Sub_metering_1",
                      "Sub_metering_2",
                      "Sub_metering_3",
                      "Global_active_power",
                      "Voltage",
                      "Global_reactive_power")


png(file = "plot4.png", width = 480, height = 480)
old_mfrow = par("mfrow") #default
old_mar = par("mar") #default
par(mfrow = c(2,2), mar = c(5, 5, 1, 1))

#Plot 1
with(tidy_dat3, plot(MDYHMS, Global_active_power, type = "n",
                     xlab = "",
                     ylab = "Global Active Power"))
with(tidy_dat3, lines(MDYHMS, Global_active_power,
                      col = "black"))
#Plot 2
with(tidy_dat3, plot(MDYHMS, Voltage, type = "n",
                     xlab = "datetime",
                     ylab = "Voltage"))
with(tidy_dat3, lines(MDYHMS, Voltage,
                      col = "black"))

#Plot 3
with(tidy_dat3, plot(MDYHMS, Sub_metering_1, type = "n",
                     xlab = "",
                     ylab = "Global Active Power"))
with(tidy_dat3, lines(MDYHMS, Sub_metering_1,
                      col = "black"))
with(tidy_dat2, lines(MDYHMS, Sub_metering_2,
                      col = "red"))
with(tidy_dat2, lines(MDYHMS, Sub_metering_3,
                      col = "blue"))

legend("topright", lty = 1,
       col = c("black", "red", "blue"),
       legend = names(tidy_dat2)[2:4], bty = "n")

#Plot 4
with(tidy_dat3, plot(MDYHMS, Global_reactive_power, 
                     type = "n",
                     xlab = "datetime",
                     ylab = "Global_reactive_power"))
with(tidy_dat3, lines(MDYHMS, Global_reactive_power,
                      col = "black"))

dev.off()

#resetting the default values
par(mfrow = old_mfrow, mar = old_mar)