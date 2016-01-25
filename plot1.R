data = read.table("household_power_consumption.txt",
                  header = TRUE, sep = ";",
                  na.strings = "?")

newdata <- data[
    (as.Date(data$Date, "%d/%m/%Y") <= "2007-02-02") 
    & (as.Date(data$Date, "%d/%m/%Y") >= "2007-02-01"),]

hist(newdata$Global_active_power, 
     col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()