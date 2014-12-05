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

# Plotting data - Plot 2 -------------------------------------------------------
# backgound transparent as in https://github.com/rdpeng/ExData_Plotting1

png(file="plot2.png",width=480,height=480,bg="transparent")

plot(dt$datetime,dt$global_active_power,type="l",
     xlab="",ylab="Global Active Power (kilowatts)")

dev.off()




