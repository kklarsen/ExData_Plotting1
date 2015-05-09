# Exploratory Data Analysis - exdata-014
# Author: Kim K Larsen
# Project 1 - Creating Plot 3

# LIBRARY USED

### Including the `png` library that enables me to display the saved png file on R device window
### The code checks whether the packages has already been installed, if so it will continue to load the library

if("png" %in% rownames(installed.packages()) == FALSE) {install.packages("png")}
library(png)

# FUNCTIONS

save_png <- function(n,d) {
          
### save_png is a function that writes the resulting Plot to filename n in director d.

        setwd(d)
          
          png(n)
          
          setwd("../")
}

myPlot <- function(df,xa, ya, a = TRUE, cc = "black", ymn, ymx, tit = "" , xlabel = "", ylabel = "") {
          
### function creating of plot2-4.png

        par(ps = 11, cex = 1, cex.main = 1)
          
          g <- with(df, plot(xa, ya,
                             axes = a,
                             type = "l",
                             col  = cc,
                             ylim = c(ymn,ymx),
                             main = tit,
                             xlab = xlabel,
                             ylab = ylabel))
          
}


# MAIN PART OF CODE

## CREATE DATASET DIRECTORY
### Creates directory and extract from the zip file the orinal data which should
### is then stored here.

DataDir <- "./dataset" #this is the directory where original data is to be found
DataSet <- "household_power_consumption.txt"

### Unless the DataDir already exists, create DataDir and unzip the datafile into it.

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


### Check that the dataset is indeed included in the DataDir, if not unzip and add to DataDir.

setwd(DataDir)

if (file.exists(DataSet) == FALSE) {
          
          t <- tempfile()
          fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
          
          download.file(fileUrl, t, mode = "wb")
          
          unzip(t)
          unlink(t)
          
}

setwd("../")

## RESULTS DIRECTORY
### Create a directory "results" where resulting files can be stored 

resultsDir <- "./results"
if (file.exists(resultsDir) == FALSE) dir.create(resultsDir)

dataFile <- file.path(DataDir, DataSet)

### check whether the dataframe, read from the dataFile, exists.
### if it exist it does not re-read it.

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

## Plot3: Creation of plot3.png

save_png("plot3.png",resultsDir)  

ymax1 <- max(dataPECsub$Sub_metering_1)
ymax2 <- max(dataPECsub$Sub_metering_2)
ymax3 <- max(dataPECsub$Sub_metering_3)

ymax <- 10*round(max(ymax1,ymax2,ymax3)/10, digits = 0)

tit = "Energy sub-metering vs Day-Time"
xl = "Day-Time"
yl = "Energy sub-metering in Watts-hour"

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Sub_metering_1,TRUE,"black", 0, ymax, tit, xl, yl )

par(new = TRUE)

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Sub_metering_2,FALSE,"red", 0, ymax, "","", "") 

par(new = TRUE)

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Sub_metering_3,FALSE,"blue", 0, ymax, "","", "") 

legend("topright",c("Energy sub-metering 1","Energy sub-metering 2","Energy sub-metering 3"), 
       lty =1,
       col = c("black","red","blue"),
       bty = "y",
       cex = 0.80)

par(new = FALSE)

dev.off()

### Displaying the png file on R device window

img <- readPNG("./results/plot3.png")
grid::grid.raster(img)
