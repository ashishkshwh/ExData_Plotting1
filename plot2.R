data = read.table("household_power_consumption.txt",
                  header = TRUE, sep = ";",
                  na.strings = "?")

newdata <- data[
    (as.Date(data$Date, "%d/%m/%Y") <= "2007-02-02") 
    & (as.Date(data$Date, "%d/%m/%Y") >= "2007-02-01"),]

tidy_dat <- data.frame(
    strptime(
        paste(newdata$Date,newdata$Time), "%d/%m/%Y %H:%M:%S"),
    newdata$Global_active_power
    )

names(tidy_dat) <- c("MDYHMS","Global_Active_Power")
plot(tidy_dat$MDYHMS, tidy_dat$Global_Active_Power,"n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

lines(tidy_dat$MDYHMS, tidy_dat$Global_Active_Power)

dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()