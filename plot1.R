# Plot 1
# Histogram of Global Active Power

# Read data
data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Convert Date to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset for required dates
data_sub <- subset(
  data,
  Date == "2007-02-01" | Date == "2007-02-02"
)

# Convert Global_active_power to numeric
data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power)

# Create PNG
png("plot1.png", width = 480, height = 480)

hist(
  data_sub$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)

dev.off()
