# Check if the data file is present in the current working directory. 
# If not save a message to notify the user the it needs to be downloaded.
# This could be done programmatically however I am using Linux and did not 
# implement this step out of compatibility considerations and unability to 
# test on other platforms.
if(!file.exists("household_power_consumption.txt")) {
    msg <- "Data file not present in current working directory. 
         Please download the data from: 
         https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
} else {
    msg <- paste("Your plot file was saved in",getwd())
}

# Read table, first row headers, ';' is used for a separator, '?' is  
# assigned to NA values. All values as strings
data <- read.table("household_power_consumption.txt",header = T, sep = ";",
                   as.is=T,na.strings = "?")

# Change date to Date class and all readings to class 'numeric'
# Subset the data being used
data$Date <- as.Date(data$Date,"%d/%m/%Y")
data <- data[data$Date == '2007-02-01' | data$Date == '2007-02-02',]
for(i in 3:9) data[,i] <- as.numeric(data[,i])

# Open a PNG device, draw plot4 and close device saving the file with the plot.
# Note that the default size of the PNG device (480x480) matches the 
# requirements the assignment
# Date and Time columns were combined to create a continuous Date/Time x-axis.
png("plot2.png")
with(data,plot(strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S"),
               Global_active_power, type='l',xlab="",
               ylab = 'Global Active Power (kilowatts)'))
dev.off()

# Result of the operations
message(msg)