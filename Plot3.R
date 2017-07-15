#Reading, Naming and Subsetting Household power consumption data 
#(Additionaly set the correct working directory to read the household_power_consumption.txt file)

library(dplyr)
library(lubridate)
data<- read.table("household_power_consumption.txt", skip=1, sep=";")
names(data)<- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
                "Sub_metering_1","Sub_metering_2","Sub_metering_3")

subdata<- subset(data, data$Date=="1/2/2007"| data$Date=="2/2/2007")

#Transforming the variables into relevant classes

subdata<- subdata %>% mutate(Date= as.POSIXct(dmy_hms(as.character(paste(Date, Time)))), 
                             Sub_metering_1= as.numeric(as.character(Sub_metering_1)),
                             Sub_metering_2= as.numeric(as.character(Sub_metering_2)),
                             Sub_metering_3= as.numeric(as.character(Sub_metering_3))) %>% 
  select(Date, Sub_metering_1, Sub_metering_2, Sub_metering_3)

#Creating plot
with(subdata, plot(Date,Sub_metering_1, type="n", xlab = "", ylab = "Energy Sub Metering"))
with(subdata, points(Date,Sub_metering_1, col="black", type="l"))
with(subdata, points(Date,Sub_metering_2, col="red", type="l"))
with(subdata, points(Date,Sub_metering_3, col="blue", type="l"))
legend("topright", lty=1, col = c("black", "red", "blue"), 
       legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))