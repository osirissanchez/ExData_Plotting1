#Load the data to R
data<-read.table("household_power_consumption.txt",sep=";",header = TRUE)


#Filters the dates of Feb 1 nad Feb2
data2<-data[data$Date %in% c("2/2/2007","1/2/2007"), ]
#Converts the values to numeric 
data2$Global_active_power<-as.numeric(data2$Global_active_power)
data2$Sub_metering_1<-as.numeric(data2$Sub_metering_1)
data2$Sub_metering_2<-as.numeric(data2$Sub_metering_2)
data2$Sub_metering_3<-as.numeric(data2$Sub_metering_3)
data2$Global_reactive_power<-as.numeric(data2$Global_reactive_power)
#Convert the value to date
data2$Date<-as.Date(data2$Date, "%d/%m/%Y")
#Put the format in YYYY-MM-DD
data2$Date<-format(data2$Date,"%Y/%m/%d")
#Converts the time to character
data2$Time<-as.character(data2$Time)
#Create a DateTime value
data2$datetime<-as.POSIXct(paste(data2$Date, data2$Time), format="%Y/%m/%d %H:%M:%S")



#Open the file to write the fourth graph
png(filename="D:/Osiris/DataAnalisis/Modulo4/Week1/Assigment1/plot4.png", height=480, width=480, bg="white")
#Making the graph 2 by 2
par(mfrow = c(2, 2))
# Graph 1 Global Active Power is placed on the first row first column
plot(data2$datetime,data2$Global_active_power,type="l",
ylab= "Global Active Power (kilowttas)",xlab='')

# Graph 2 Voltage is placed on the first row second column
plot(data2$datetime,data2$Voltage ,type="l",
ylab= "Voltage",xlab='datetime')

#Graph 3 Energy Sub Metering is placed on the second row first column
plot(data2$datetime,data2$Sub_metering_1,type="l",
ylab= "Energy sub metering",xlab='',ylim=c(0,40))
lines(data2$datetime,data2$Sub_metering_2/3, type="l",  col="red")
lines(data2$datetime,data2$Sub_metering_3, type="l",  col="blue")
legend("topright" ,c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,
 lty=c(1,1,1),col=c("black","red","blue"),bty="n")

#Graph 4 Global_Reactive_Powe is placed on the second row second column
plot(data2$datetime,data2$Global_reactive_power/500 ,type="l",ylim=c(0,0.5),
ylab= "Global_Reactive_Power",xlab='datetime')
#Close the png file
dev.off()
