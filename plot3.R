## Read household power consumption data
alldata <- readLines('Data/household_power_consumption.txt')
names = alldata[1]

## Extract lines for 1/2/2007 and 2/2/2007. Concatenate them. 
data01 <- grep("^1/2/2007", alldata, value = TRUE)
data02 <- grep("^2/2/2007", alldata, value = TRUE)
data = c(data01, data02)

## Split the character strings of each entry of 'data' into character strings corresponding to the 9 variables of the UCI data set.
## These will be character vectors of length 9. 'dataList' will have length equal to that of 'data'
dataList = strsplit(data, split = ";")

## Convert to matrix and then to dataframe 
M = matrix(unlist(dataList), nrow = length(dataList), byrow = TRUE)
colnames(M) = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
householdPCo = as.data.frame(M, stringsAsFactors = FALSE)

## Format Date and Time
householdPCo$Date = as.Date(householdPCo$Date, "%d/%m/%Y")
householdPCo$Time = strptime(householdPCo$Time, "%H:%M:%S", tz = "UTC")
householdPCo$Time = format(householdPCo$Time, "%H:%M:%S")
householdPCo$Time = as.factor(householdPCo$Time)


## Format power, intensity, and metering
householdPCo$Global_active_power = as.numeric(householdPCo$Global_active_power)
householdPCo$Global_reactive_power = as.numeric(householdPCo$Global_reactive_power)
householdPCo$Voltage = as.numeric(householdPCo$Voltage)
householdPCo$Global_intensity = as.numeric(householdPCo$Global_intensity)
householdPCo$Sub_metering_1 = as.numeric(householdPCo$Sub_metering_1)
householdPCo$Sub_metering_2 = as.numeric(householdPCo$Sub_metering_2)
householdPCo$Sub_metering_3 = as.numeric(householdPCo$Sub_metering_3)

##Create .png file
png("rplot3.png", width = 480, height = 480)
plot(xy.coords(householdPCo$Sub_metering_1), type = "l",  xlab = "", ylab = "Energy sub metering", 
          xlim = c(0, 3000), ylim = c(0,40), xaxt = "n", yaxt = "n")
 axis(1, at = c(0, 1500, 3000), labels = c("Thu", "Fri", "Sat"))
 axis(2, c(0,10,20,30))
 lines(householdPCo$Sub_metering_2, type = "l", col = "red")
 lines(householdPCo$Sub_metering_3, type = "l", col = "blue")
 legend(1950, 41.58, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()





