# Read data into table
electric<-read.table("household_power_consumption.txt", sep=";")

## Rename columns to be the strings that are in the first row, so that we have
## meaningful column names, instead of "V1," "V2", etc
colnames(electric)<-c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")

# Now remove the first row of the table, since it will be captured in the column names
electric<-electric[-1,]

# Now subset the dataframe to just rows where the date is Feb 1 or Feb 2, 2007
electric<-subset(electric, Date == "1/2/2007" | Date == "2/2/2007")

# Set up the plot to write directly to png file and have the range of the y axis be 0 to 1200
png("plot1.png", 480, 480)
par(mar=c(4,4,2,1))
par(yaxp  = c(0, 1200, 1))

# Plot the histogram
hist(as.numeric(as.character(electric$GlobalActivePower)), col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()