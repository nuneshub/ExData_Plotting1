################################################################################
# Exploratory Data Analysis
# Course Project 1
################################################################################
# Preparing data set for all plots ---------------------------------------------
# download data from source and unzip to R working directory

Url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- file.path(getwd(), "edaproject1.zip")
download.file(Url, destfile=file, mode="wb")
unzip(file)

# reading data into R

file <- file.path(getwd(), "household_power_consumption.txt")
c <- "character"; n <- "numeric"
colclasses <- c(c,c,n,n,n,n,n,n,n)
dt <- read.table(file=file,header=TRUE,sep=";",quote="",na.strings="?",
                 colClasses=colclasses,nrows=2075259,stringsAsFactors=FALSE)
names(dt) <- tolower(names(dt))

# subset for days: 1/2/2007 and 2/2/2007

dt <- subset(dt, dt$date=="1/2/2007" | dt$date=="2/2/2007")

# creates column "datetime" and formats it to as.POSIXct

dt$datetime <- paste(dt$date,dt$time,sep=" ")
dt$datetime <- as.POSIXct(strptime(dt$datetime, format="%d/%m/%Y %H:%M:%S"))

# Plotting data - Plot 4 -------------------------------------------------------
# backgound transparent as in https://github.com/rdpeng/ExData_Plotting1

png(file="plot4.png",width=480,height=480,bg="transparent")

par(mfcol=c(2,2))

plot(dt$datetime,dt$global_active_power,type="l",
     xlab="",ylab="Global Active Power")

plot(dt$datetime,dt$sub_metering_1,type="l",
     xlab="",ylab="Energy sub metering")
lines(dt$datetime,dt$sub_metering_2,col="red")
lines(dt$datetime,dt$sub_metering_3,col="blue")
legtxt <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legcol <- c("black","red","blue")
legend("topright",lty=1,legend=legtxt,col=legcol,bty="n")

plot(dt$datetime,dt$voltage,type="l",
     xlab="datetime",ylab="Voltage")

plot(dt$datetime,dt$global_reactive_power,type="l",
     xlab="datetime",ylab="Global_reactive_power")

dev.off()




