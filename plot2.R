
data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Convert Date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset dates
data_sub <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Create datetime
data_sub$DateTime <- strptime(
  paste(data_sub$Date, data_sub$Time),
  format = "%Y-%m-%d %H:%M:%S"
)

# Convert power to numeric
data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power)

# Plot
png("plot2.png", width = 480, height = 480)
plot(
  data_sub$DateTime,
  data_sub$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)
dev.off()
