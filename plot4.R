
data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

data_sub <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Create datetime
data_sub$DateTime <- strptime(
  paste(data_sub$Date, data_sub$Time),
  format = "%Y-%m-%d %H:%M:%S"
)

# Convert needed columns to numeric
cols <- c(
  "Global_active_power",
  "Global_reactive_power",
  "Voltage",
  "Sub_metering_1",
  "Sub_metering_2",
  "Sub_metering_3"
)
data_sub[cols] <- lapply(data_sub[cols], as.numeric)

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

# 1: Global Active Power
plot(
  data_sub$DateTime,
  data_sub$Global_active_power,
  type = "l",
  ylab = "Global Active Power",
  xlab = ""
)

# 2: Voltage
plot(
  data_sub$DateTime,
  data_sub$Voltage,
  type = "l",
  ylab = "Voltage",
  xlab = "datetime"
)

# 3: Sub metering
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
  bty = "n",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

# 4: Global Reactive Power
plot(
  data_sub$DateTime,
  data_sub$Global_reactive_power,
  type = "l",
  ylab = "Global Reactive Power",
  xlab = "datetime"
)

dev.off()
