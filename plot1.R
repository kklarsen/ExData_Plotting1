# Exploratory Data Analysis - exdata-014
# Author: Kim K Larsen
# Project 1 - Creating Plot 1

# save_png is a function that writes the resulting Plot to filename n in director d.

save_png <- function(n,d) {
          
          setwd(d)
          
          dev.copy(png,n)
          dev.off()
          
          setwd("../")
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

dataFile <- file.path(DataDir, DataSet)

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


# creation of plot1.png

g <- hist(dataPECsub$Global_active_power, col = "red", 
          main = " Histogram of Global Active Power", 
          xlab = "Global active power in kilo-Watts")

save_png("plot1.png",resultsDir)
