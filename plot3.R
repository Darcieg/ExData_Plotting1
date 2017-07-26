# Read data into table
electric<-read.table("household_power_consumption.txt", sep=";")

## Rename columns to be the strings that are in the first row, so that we have
## meaningful column names, instead of "V1," "V2", etc
colnames(electric)<-c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")
# Now remove the first row of the table, since it will be captured in the column names
electric<-electric[-1,]

# Now subset the dataframe to just rows where the date is Feb 1 or Feb 2, 2007
electric<-subset(electric, Date == "1/2/2007" | Date == "2/2/2007")

# Create a new column called Timestamp that combines date and time so we can construct the x-axis of our plot
library(lubridate)
electric$Timestamp <- dmy_hms(paste(electric$Date, electric$Time))

# Set up the plot to write directly to a png file
png("plot3.png", 480, 480)
par(mar=c(4,4,2,1))

# Plot the line graph
plot(electric$Timestamp, as.numeric(as.character(electric$SubMetering1)), type = "l", xlab = "", ylab = "Energy sub metering")
lines(electric$Timestamp, as.numeric(as.character(electric$SubMetering2)), type="l", col="red")
lines(electric$Timestamp, as.numeric(as.character(electric$SubMetering3)), type="l", col="blue")

# Add legend
legend("topright", col = c("black", "red", "blue"), lty = 1, legend= c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lty = 1)

dev.off()