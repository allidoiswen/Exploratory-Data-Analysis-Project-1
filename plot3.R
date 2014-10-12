### Coursera: Exploratory Data Analysis - Course Project 1  ###
### Plotting the Household Power Consumption                ###
### Data Source: http://archive.ics.uci.edu/ml/             ###
### Data Set: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

### Description: Measurements of electric power consumption ###
### in one household with a one-minute sampling rate over a ###
### period of almost 4 years. Different electrical          ###
### quantities and some sub-metering values are available.  ###


## Instruction

## Loading the data

## When loading the dataset into R, please consider the following:

## The dataset has 2,075,259 rows and 9 columns. First calculate a rough 
## estimate of how much memory the dataset will require in memory before 
## reading into R. Make sure your computer has enough memory (most modern 
## computers should be fine).

# Write a function for estimating the potential memory consumption

est.mem <- function(nrow, ncol)
{
  total <- nrow * ncol * 8 # Assume 8 bytes/numeric
  total <- total / (2^20)  # Convert bytes to MB
  print(total)
}

est.mem(2075258, 9)

## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## One alternative is to read the data from just those dates rather than 
## reading in the entire dataset and subsetting to those dates.
### You may find it useful to convert the Date and Time variables to Date/Time 
### classes in R using the strptime() and as.Date() functions.
### Note that in this dataset missing values are coded as ?.

# Set Working directory

setwd("C:/Users/Austin/Google Drive/Education/Exploratory Data Analysis/Projects/Project 1/")

data <- read.table("household_power_consumption.txt", 
                   sep =";", 
                   header = T,
                   colClasses = c("character", "character", rep("numeric",7)),
                   na.strings ="?"
)

# Change the date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")



data <- subset(data, subset = (Date >= as.Date("2007-02-01") & 
                                 Date <= as.Date("2007-02-02")
)
)

# Combine Date and Time

Date.Time <- paste(as.Date(data$Date), data$Time)

Date.Time <- strptime(Date.Time, "%Y-%m-%d %H:%M:%S")

data$Date.Time <- as.POSIXct(Date.Time)

## !! Note: Research how to reach only certain rows  !! ##

### Plot 3 #################################################################

# Plot the first one
plot(data$Sub_metering_1~data$Date.Time, 
     col = "BLACK",
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)", 
)

# Add the 2nd and 3rd lines
lines(data$Sub_metering_2~data$Date.Time,col='RED')
lines(data$Sub_metering_3~data$Date.Time,col='BLUE')

legend("topright", legend = c("Sub_mertering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("BLACK", "RED", "BLUE"), lty = 1
)

### Save Plot 3 ###

dev.copy(png, file="plot3.png", width = 800, height = 500)
dev.off()
