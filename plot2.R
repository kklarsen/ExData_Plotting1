# Exploratory Data Analysis - exdata-014
# Author: Kim K Larsen
# Project 1 - Creating Plot 2

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

### Plot 2: creation of plot2.png

save_png("plot2.png",resultsDir)

tit = "Global active power vs Day-Time"
xl = "Day-Time"
yl = "Global active power in kilo-Watts"

ymax <- 2*round(max(dataPECsub$Global_active_power)/2, digits = 0)

myPlot(dataPECsub,dataPECsub$Date,dataPECsub$Global_active_power,TRUE,"black", 0, ymax, tit, xl, yl )

dev.off()

### Displaying the png file on R device window

img <- readPNG("./results/plot2.png")
grid::grid.raster(img)
