data = read.table("household_power_consumption.txt",
                  header = TRUE, sep = ";",
                  na.strings = "?")

newdata <- data[
    (as.Date(data$Date, "%d/%m/%Y") <= "2007-02-02") 
    & (as.Date(data$Date, "%d/%m/%Y") >= "2007-02-01"),]

tidy_dat2 <- data.frame(
    strptime(
        paste(newdata$Date,newdata$Time), "%d/%m/%Y %H:%M:%S"),
    newdata$Sub_metering_1,
    newdata$Sub_metering_2,
    newdata$Sub_metering_3)

names(tidy_dat2) <- c("MDYHMS",
                      "Sub_metering_1",
                      "Sub_metering_2",
                      "Sub_metering_3")

png(file = "plot3.png", width = 480, height = 480)

with(tidy_dat2, plot(MDYHMS, Sub_metering_1, type = "n",
     xlab = "",
     ylab = "Energy sub metering"))
with(tidy_dat2, lines(MDYHMS, Sub_metering_1,
                      col = "black"))
with(tidy_dat2, lines(MDYHMS, Sub_metering_2,
                      col = "red"))
with(tidy_dat2, lines(MDYHMS, Sub_metering_3,
                      col = "blue"))
legend("topright", lty = 1,
       col = c("black", "red", "blue"),
       legend = names(tidy_dat2)[2:4])

dev.off()