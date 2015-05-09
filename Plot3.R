## This is the code for project 1 in the EDA course.   It 
## reads a portion of a large data file, looks at a small subset
## of it and produces four designated plots found in the project
## description.

# This function produces the 3rd plot, a set of three overlaid line graphs
# of Energy Sub_metering vs datetimes.   A legend and colors are used.

Plot3 <- function(){
  
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
   
  
  ## set figure count and margins and to their defaults, font size slightly smaller 
  
  par(mfrow = c(1,1), mar = c(5, 4, 4, 2)+.1, cex = .8)
  
  ## -- print plot 3, three overlaid x-y line plots of sub_metering measurements
  ## --  vs datetimes with a legend and different color
 
  plot(datetimes, pwr_data$Sub_metering_1, type = "l",
       ylab = "Energy sub metering", xlab = "")
  lines(datetimes, pwr_data$Sub_metering_2, col = "red")
  lines(datetimes, pwr_data$Sub_metering_3, col = "blue")
  
  # Although fine in the window plot, in the .png file plot the legend text was slid
  # right so _1, _2, and _3 were cut off.
  # We set the text.width and cex parameters to slightly rescale the font so
  # the full legend was legible in the .png file.
  
  legend("topright", col = c("black", "red", "blue"), 
         text.width = strwidth("Sub_metering_3"),
         cex = .80, lwd = rep(1,3), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  dev.copy(png, "plot3.png")
  dev.off()
  
  return(TRUE)
  
  
}
