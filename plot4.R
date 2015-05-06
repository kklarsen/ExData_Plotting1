# Exploratory Data Analysis - exdata-014
# Author: Kim K Larsen
# Project 1 - Creating Plot 4

# save_png is a function that writes the resulting Plot to filename n in director d.

save_png <- function(n,d) {
          
          setwd(d)
          
          dev.copy(png,n)
          dev.off()
          
          setwd("../")
}


# function creating of plot2-4.png

myPlot <- function(df,xa, ya, a = TRUE, cc = "black", ymn, ymx, tit = "" , xlabel = "", ylabel = "") {
          
          par(ps = 12, cex = 1, cex.main = 1)
          
          g <- with(df, plot(xa, ya,
                             axes = a,
                             type = "l",
                             col  = cc,
                             ylim = c(ymn,ymx),
                             main = tit,
                             xlab = xlabel,
                             ylab = ylabel))
          
}


#CREATE DATASET DIRECTORY
## Creates directory and extract from the zip file the orinal data which should
## is then stored here.

DataDir <- "./dataset" #this is the directory where original data is to be found
DataSet <- "household_power_consumption.txt"

## Unless the DataDir already exists, create DataDir and unzip the datafile into it.

if (file.exists(DataDir) == FALSE) {
          
          dir.create(DataDir)
          setwd(DataDir)
          
          t <- tempfile()
          fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
          
          download.file(fileUrl, t, mode = "wb")
          
          unzip(t)
          unlink(t)
          
          setwd("../")
}


## Check that the dataset is indeed included in the DataDir, if not unzip and add to DataDir.

setwd(DataDir)

if (file.exists(DataSet) == FALSE) {
          
          t <- tempfile()
          fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
          
          download.file(fileUrl, t, mode = "wb")
          
          unzip(t)
          unlink(t)
          
}

setwd("../")

#RESULTS DIRECTORY
##Create a directory "results" where resulting files can be stored 

resultsDir <- "./results"
if (file.exists(resultsDir) == FALSE) dir.create(resultsDir)

dataFile <- file.path(DataDir, "household_power_consumption.txt")

# check whether the dataframe, read from the dataFile, exists.
# if it exist it does not re-read it.

l <- ifelse(any(ls() %in% "dataPEC"), is.data.frame(get("dataPEC")),FALSE)

if (l == FALSE) { dataPEC <- read.table(dataFile, header = TRUE, sep = ";",na.strings = "?", 
                                        colClasses = c("factor",
                                                       "factor",
                                                       "numeric",
                                                       "numeric",
                                                       "numeric",
                                                       "numeric",
                                                       "numeric",
                                                       "numeric",
                                                       "numeric"))
                  
                  dataPEC$Date <- as.Date(dataPEC$Date,"%d/%m/%Y")
                  
                  #defining the range of interest and limiting the dataset to that
                  dmin <- "2007-02-01"
                  dmax <- "2007-02-02"
                  
                  dataPECsub <- subset(dataPEC, Date >= dmin)
                  dataPECsub <- subset(dataPECsub, Date <= dmax) #final dataset of interest
                  
                  dataPECsub$Date <- paste(dataPECsub$Date,dataPECsub$Time)
                  dataPECsub$Date <- strptime(dataPECsub$Date, "%Y-%m-%d %H:%M:%S")
                  
}

# creation of plot4.png

par(mfrow = c(2,2))

tit = "Global Active Power versus Day & Time"
xl = "Day-Time"
yl = "Global active power in kilo-Watts"

ymax <- 2*round(max(dataPECsub$Global_active_power)/2, digits = 0)

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Global_active_power,TRUE,"black", 0,ymax, tit, xl, yl )

tit = "Voltage versus Day & Time"
xl = "Day-Time"
yl = "Global active power in kilo-Watts"

ymax <- 2*round(max(dataPECsub$Voltage)/2, digits = 0)
ymin <- 2*round(min(dataPECsub$Voltage)/2, digits = 0)

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Voltage,TRUE,"black", ymin, ymax, tit, xl, yl )

ymax1 <- max(dataPECsub$Sub_metering_1)
ymax2 <- max(dataPECsub$Sub_metering_2)
ymax3 <- max(dataPECsub$Sub_metering_3)

ymax <- 10*round(max(ymax1,ymax2,ymax3)/10, digits = 0)

tit = "Energy sub-metering versus Day & Time"
xl = "Day-Time"
yl = "Energy sub-metering in Watts-hour"

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Sub_metering_1,TRUE,"black", 0, ymax, tit, xl, yl )

par(new = TRUE)

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Sub_metering_2,FALSE,"red", 0, ymax, "","", "") 

par(new = TRUE)

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Sub_metering_3,FALSE,"blue", 0, ymax, "","", "") 

par(new = FALSE)
par (cex = 0.64)

legend("topright",c("Energy sub-meter 1","Energy sub-meter 2","Energy sub-meter 3"), 
       lty =1,
       col = c("black","red","blue"),
       bty = "n")

tit = "Global Reactive Power versus Day & Time"
xl = "Day-Time"
yl = "Global reactive power in kilo-Watts"

ymax <- 2*round(max(dataPECsub$Global_reactive_power)/2, digits = 2)

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Global_reactive_power,TRUE,"black", 0, ymax, tit, xl, yl )

save_png("plot4.png",resultsDir)