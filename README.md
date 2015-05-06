# Project 1
## Exploratory Data Analysis (exdata-014)
### May 2015.

## INTRO
Plotting Assignment 1 for Exploratory Data Analysis (exdata-014).

The assignment and project expectations have been described by Dr. Peng [`Readme_old.md`](https://github.com/kklarsen/ExData_Plotting1/blob/master/README_old.md).

The Dataset used in this assignment comes from [UC Irvine Machine Learning Repository (UCIMLR) ](http://archive.ics.uci.edu/ml/) and concerns the electrical power consumption of individual households.

The dataset contains 9 variable with following descriptions from the [UCIMLR web site](https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption) (note: numbering below follows the order of the columns in the resulting dataset):

1. **Date**: Date in format dd/mm/yyyy
2. **Time**: time in format hh:mm:ss
3. **Global _ active _ power**: household global minute-averaged active power (in kilowatt)
4. **Global _ reactive _ power**: household global minute-averaged reactive power (in kilowatt)
5. **Voltage**: minute-averaged voltage (in volt)
6. **Global _ intensity**: household global minute-averaged current intensity (in ampere)
7. **Sub _ metering _ 1**: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). 
8. **Sub _ metering _ 2**: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
9. **Sub _ metering _ 3**: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

This analysis require only two days worth of data, equivalent to 48 hours.

## THIS CODE
As per requirement you will find an R file for each of the 4 plots required for this assignment;

* `plot1.R`: Creates a histogram of the **Global Active Power** (in kilo-Watts)
* `plot2.R`: Creates x-y graph of **Global Active Power** versus day & time (i.e., 1 single data series)
* `plot3.R`: Creates x-y graph of the three **Energy sub-metering** measurements versus day & time (i.e., 3 data series)
* `plot4.R`: Creates a 4 charts on graphics display;
	* **Global Active Power** versus day & time (i.e., this is similar to `plot2.R`)
	* **Voltage** versus day & time (i.e., new plot)
	* **Energy sub-metering** from the 3 sources versus day & time (i.e., this is similar to 'plot3.R'
	* **Global Reactive Power** versus day & time.
	* Note: that the first two sub-plots as well as the last have the same structure in the sense of being single series data representations.

I have also included the full R code (`projec1.R`) that creates all 4 plot assignments within the same code.

You will also see that I am creating two directories in your working directory;

* `"./dataset/"`: this directory contains the unzipped dataset (i.e., `"household_power_consumption.txt"`). The code will ensure that the text file is included here.
* `"./results/"`: this directory contains the 4 required plots (and in principle any other resulting analysis that might have been required). Here you will find the following files;
	* `"plot1.png"`
	* `"plot2.png"`
	* `"plot3.png"`
	* `"plot4.png"`

I prefer to keep my original data and resulting analysis separated and also not have it "floating" around my working directory (which is a bit like my desk .. kind of messy).

My coding strategy has been to try to avoid unnecessary unzip's and read's as you run each of the 4 R-plot codes, as this can be time consuming and should really only be done once. The various steps and rational is commented throughout the code.

On high-level my code does the following;

1. Checks whether `DataDir` (i.e., defined as `"./dataset"` and is the directory where you will find the **UCIMLR dataset** that needs to be analyzed) exists.
	* If not it will create a directory named `dataset` and connect to/download the [zipped dataset](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip), unzip the the file and add the dataset `"household_power_consumption.txt"` to the directory.
	* If the directory `"./dataset"` exist, the code will resume.
1. Checks whether `"household_power_consumption.txt"`exist in the `dataset` directory. If not it will connect, download & unzip the UCIMLR dataset. **Note**: this might seem a bit redundant given the first step. However, there might be situations where the dataset have been deleted (e.g., GitHub has a limitation on the size that can be uploaded and this file is pretty big).
2. After making sure that the UCIMLR dataset is indeed available, the code creates a `"./results"` directory where the output of the analysis will be written to. If the directory already exist in your work folder the code continues.
3. Next step is that the code checks whether the data frame `dataPEC` (i.e., PEC = **P**ower **E**lectric **C**onsumption), read from the `"household_power_consumption.txt"`, exist in the `Global Environmet` of R. If the data frame already exist, the code will not attempt to re-read the data frame as this is a time-costly process.
4. In the process of preparing the read data frame (i.e., `dataPEC`) for further processing, I convert the Date column (i.e.,`dataPEC$Date`) to the R date standard.
5. After transforming the Date column to the right format, the code extract a subset of the larger dataframe; `dataPECsub` corresponding to 48 hours between "2007-02-01" and "2007-02-01".
6. Final data frame transformation of the date column (` dataPECsub$Date`) is to pase the Date and Time column and then apply `strptime()` function ensuring conformity to R format.

All the above steps 1- 7 are common for all the plot 1-4 codes. Once you have run either of the plot codes, the following will execute faster and not repeat the time-consuming steps of downloading and reading the UCIMLR dataset.

After the above points the data frame `dataPECsub` is ready for analysis. In this case plotting various data from the dataset.

Apart from the histogram plot (i.e., Plot1), the other plots 2 to 4 can easily be reconciled by calling the function `myPlot`, which is a straightforward extension of R's basic plot functionality.

I do a bit of analysis on the y-axis limits, which is passed on to the `myPlot()` function, to ensure that the graphical representation of the data is as clear as possible.

`save_png()` function saves the "active" plot displayed on the screen to the `"./results" directory. This directory as well as the 4 png plots are also seen here in the GitHub repository.

## RESULTS

![](http://i.imgur.com/fxLMb1s.png)

The above plot represents the first plot `plot1.png` (i.e., also found in `"./results` directory) of the Project 1. This plot has been generated by `plot1.R`.

![](http://i.imgur.com/T8zgNy1.png)

The above plot represents the second plot `plot2.png` (i.e., also found in `"./results` directory) of the Project 1.This plot has been generated by `plot2.R`.

![](http://i.imgur.com/88ZYYMO.png)

The above plot represents the third plot `plot3.png` (i.e., also found in `"./results` directory) of the Project 1. This plot has been generated by `plot3.R`.

![](http://i.imgur.com/9wXpbvz.png)

The above plot represents the third plot `plot4.png` (i.e., also found in `"./results` directory) of the Project 1. This plot has been generated by `plot4.R`.

**Note**: All the above plots can also be generated by the single code `project1.R` 

### Aknowledgement
Source of the data: Georges HÃ©brail (georges.hebrail '@' edf.fr), Senior Researcher, EDF R&D, Clamart, France 
Alice BÃ©rard, TELECOM ParisTech Master of Engineering Internship at EDF R&D, Clamart, France.
