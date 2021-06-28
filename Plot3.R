Plot03 <- function(){
    # Overview function
    # 1. Read data from power text file
    # 2. Convert data into data, time, numeric
    # 3. Plot the data
    
    # Detailed source code
    # 1. Read data from power text file, load only 2880 rows
    # from 1/2/2007 to 2/2/2007 skip 66637 rows
    powerDt <- data.table::fread("./Data_week1/household_power_consumption.txt"
                                 , skip = 66637
                                 , nrows = 2880
                                 , sep = ";"
                                 , col.names = c("Date","Time","Global_active_power"
                                                 ,"Global_reactive_power","Voltage"
                                                 ,"Global_intensity","Sub_metering_1"
                                                 ,"Sub_metering_2","Sub_metering_3"))
    
    # 2. Convert data into data, time, numeric
    FullDateTime <- strptime(paste(powerDt$Date, powerDt$Time, sep=" "), 
                             "%d/%m/%Y %H:%M:%S")
    powerDt <- cbind(powerDt, FullDateTime)
    
    powerDt$Date <- as.Date(powerDt$Date,format="%d/%m/%y")
    powerDt$Time <- format(powerDt$Time, format="%H:%M:%S")
    powerDt$Global_active_power <- as.numeric(powerDt$Global_active_power)
    powerDt$Global_reactive_power <- as.numeric(powerDt$Global_reactive_power)
    powerDt$Voltage <- as.numeric(powerDt$Voltage)
    powerDt$Global_intensity <- as.numeric(powerDt$Global_intensity)
    powerDt$Sub_metering_1 <- as.numeric(powerDt$Sub_metering_1)
    powerDt$Sub_metering_2 <- as.numeric(powerDt$Sub_metering_2)
    powerDt$Sub_metering_3 <- as.numeric(powerDt$Sub_metering_3)
    
    
    # 3. Plot the data Global Active Power
    png("plot3.png")
    with(powerDt, plot(FullDateTime, Sub_metering_1, type="l", xlab="Day", 
                          ylab="Energy sub metering"))
    lines(powerDt$FullDateTime, powerDt$Sub_metering_2,type="l", col= "red")
    lines(powerDt$FullDateTime, powerDt$Sub_metering_3,type="l", col= "blue")
    legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", 
                            "Sub_metering_3"), lty= 1, lwd=2, 
           col = c("black", "red", "blue"))
    dev.off()
    return()
}