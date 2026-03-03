# plot3.R
data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Convert Date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset required dates
data_sub <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Create datetime
data_sub$DateTime <- strptime(
  paste(data_sub$Date, data_sub$Time),
  format = "%Y-%m-%d %H:%M:%S"
)

# Convert sub metering columns to numeric
data_sub$Sub_metering_1 <- as.numeric(data_sub$Sub_metering_1)
data_sub$Sub_metering_2 <- as.numeric(data_sub$Sub_metering_2)
data_sub$Sub_metering_3 <- as.numeric(data_sub$Sub_metering_3)

# Plot
png("plot3.png", width = 480, height = 480)

plot(
  data_sub$DateTime,
  data_sub$Sub_metering_1,
  type = "l",
  ylab = "Energy sub metering",
  xlab = ""
)

lines(data_sub$DateTime, data_sub$Sub_metering_2, col = "red")
lines(data_sub$DateTime, data_sub$Sub_metering_3, col = "blue")

legend(
  "topright",
  col = c("black", "red", "blue"),
  lty = 1,
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

dev.off()
