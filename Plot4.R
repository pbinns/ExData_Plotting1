## This is the code for project 1 in the EDA course.   It 
## reads a portion of a large data file, looks at a small subset
## of it and produces four designated plots found in the project
## description.

## This function plots the 4th plot, a group of four graphs

Plot4 <- function(){
  
  ## A zip file containing the data was manually downloaded from
  ## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
  ## to "this" directory (defined to be the working directory), then extracted
  ## into the subdirectory exdata_data_household_power_consumption
  
  ## The data file, household_power_consumption.txt has missing values denoted by ?s 
  ## (question marks) rather than NAs.  That is not the only R incompatibility.
  ## For example, line 1312426 among others did not have nine elements in them.
  ## 
  ## A search found the data for date = 1/2/2007 = Feb 1, 2007
  ## to be on lines 66638 through 68077
  ## Similarly, the data for date = 2/2/2007 = February 2, 2007
  ## was found to be on lines 68078 through 69517
  
  ## To keep the column names, we read row 1 through row 69517,
  ## then delete all but the last 2280 rows of data which corresponds to
  ## February 1 and 2 data in year 2007.
  
  ## To check our calculations for the complete data set, there are 1440 samples
  ## per day = 60 min/hour * 24 hour/day = 1440 min/day which is the specified 
  ## sampling rate.
  
  data_dir <- "exdata_data_household_power_consumption"
  data_file <- paste0(data_dir, "/household_power_consumption_wNA.txt")
  
  
  # Date and Time are read in as character classes, then combined and
  # converted to ordered dates and times using function strptime.
  
  # define the column classes
  
  cclasses <- c("character", "character", rep("numeric",7))
  

  pwr_data <- read.table(data_file, header = TRUE, sep = ";",
                  stringsAsFactors = FALSE, nrows = 66636 + 2880, 
                  colClasses = cclasses) 
  
  # select the subset of data corresponding to days Feb 1 and 2, 2007
  # pwr_data will have 2880 rows and nine columns.
  
  feb2end <- length(pwr_data[,1])
  feb1start <- feb2end - 2880 + 1
  pwr_data <- pwr_data[feb1start:feb2end,]
  
  # convert the character strings for data and time to a POSIXlt type
  
  dates <- pwr_data[,1]   # first col contains dates
  times <- pwr_data[,2]   # second col contains times
  dt <- paste(dates, times)  # dates concatenated with times
  datetimes <- strptime(dt, "%d/%m/%Y %H:%M:%S")  # array of class POSIXlt
   
  ## --- print plot 4, a set of four different plots
  
  # set the display to 2x2 for the four plots, also adjust the font size
  par(mfrow = c(2,2), mar = c(4.3,4.3,1.1,1.1), cex = .6)
  
  
  # Plot in position (1,1) is the same as Plot 2
  
  plot(datetimes, pwr_data$Global_active_power, type = "l",
       ylab = "Global Active Power (kilowatts)", xlab = "")
  
  # Plot in position (1,2) is next in row major order, voltage vs time
  
  plot(datetimes, pwr_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  # Plot in position (2,1) is the same as Plot 3
  
  plot(datetimes, pwr_data$Sub_metering_1, type = "l",
       ylab = "Energy sub metering", xlab = "")
  lines(datetimes, pwr_data$Sub_metering_2, col = "red")
  lines(datetimes, pwr_data$Sub_metering_3, col = "blue")
  # see comments in Plot3 about text.width and cex settings.
  legend("topright", col = c("black", "red", "blue"), 
         text.width = strwidth("Sub_metering_3"), cex = .9, lwd = rep(1,3),
         bty = "n",  # note there is no visible legend box
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  # Plot in position (2,2) is Global reactive power vs. time
  
  with(pwr_data, plot(datetimes, Global_reactive_power, type = 'l', xlab = "datetime"))
  
  dev.copy(png, "plot4.png")
  dev.off()
  
  return(TRUE) 
  
}
