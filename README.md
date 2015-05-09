## Introduction

This is Project 1 of the Data Science course Exploratory Data Analysis.   This README file has been forked from Roger Peng's Github repo [https://github.com/rdpeng/ExData_Plotting1](https://github.com/rdpeng/ExData_Plotting1).

A few portions of this description are verbatim (i.e. unchanged), and not always explicitly quoted beyond this initial reference.  These verbatim portions largely describe the data sources.  The portions which explain the selected approaches to various aspects of the assignment are different.  Comments are also included in the R source code files to document detailed decisions.

### Downloading Instructions

This assignment uses data from
the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>, a popular repository for machine learning
datasets. This project uses the "Individual household
electric power consumption Data Set" which was available on
the course web site as a zip file, which must be manually downloaded from:


* <b>Dataset Location</b>: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 

Once downloaded to the working directory, the datafile needs to be unzipped.  The resultant text file to be read relative to the working directory is found at <b>exdata_household_power_consumption/household_power_consumption.txt</b> and is about 20Mb.  

### Dataset Description 

The description of the text file follows (mostly verbatim from Roger's repo):

* <b>Dataset Description</b>: Measurements of electric power consumption in
one household with a one-minute sampling rate over a period of almost
4 years. Different electrical quantities and some sub-metering values
are available.


The following descriptions of the 9 variables in the dataset are taken
from
the <a href="https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption">UCI
web site</a>:

<ol>
<li><b>Date</b>: Date in format dd/mm/yyyy </li>
<li><b>Time</b>: time in format hh:mm:ss </li>
<li><b>Global_active_power</b>: household global minute-averaged active power (in kilowatt) </li>
<li><b>Global_reactive_power</b>: household global minute-averaged reactive power (in kilowatt) </li>
<li><b>Voltage</b>: minute-averaged voltage (in volt) </li>
<li><b>Global_intensity</b>: household global minute-averaged current intensity (in ampere) </li>
<li><b>Sub_metering_1</b>: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). </li>
<li><b>Sub_metering_2</b>: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. </li>
<li><b>Sub_metering_3</b>: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.</li>
</ol>

## Reading the data into R code

* The dataset has 2,075,259 rows and most rows have 9 columns. 

* Only data from the dates 2007-02-01 (February 1, 2007) and
2007-02-02 (Februrary 2, 2007) are used. 

* The data set is not entirely "clean" from an R formatting perspective.   For instance, missing data is denoted by a question mark (?) rather than NA.   Also, not all rows have nine entries.   For example, line 1312426 among others did not have nine elements in them.

* Fortunately, missing data and incomplete rows first appeared chronologically after data for Februrary 2, 2007.   Consequently, the code inputs only the first 69517 rows which is the last row of data for the two dates of interest.

* The data for date = 1/2/2007 = Feb 1, 2007 is in rows 66638 through 68077
  
* The data for date = 2/2/2007 = February 2, 2007 is in rows 68078 through 69517
  
* To keep the column names, the code inputs row 1 (with column names) through row 69517.  All but the last 2280 rows of data is then deleted from the input dataframe, which leaves only data corresponds to February 1 and 2 data in year 2007 to be used when plotting.
  
* To check our calculations for the complete data set, there are 1440 samples per day = 60 min/hour * 24 hour/day = 1440 min/day which is the specified sampling rate.

* Columns 3 through 9 are numeric, corresponding to the values of the sensor energy use measurements as described above. 

* Date (column 1) and Time (column 2) are read in as character classes, then combined using the R "c" concatenation operator and converted to ordered dates and times using the R function strptime.

* Comments are included in the R code where these steps are being performed.
  
* Each plotting routine uses the exact same R code to input the data before making a plot, making the plot reproducible. 


## Plot Generation

Four plots and four R files have been uploaded to this Github repo. 
* Plot1.R produces plot1.png.
* Plot2.R produces plot2.png.
* Plot3.R produces plot3.png and 
* Plot4.R produces plot4.png.

Each plot is a PNG file with a width of 480 pixels and a height of 480 pixels (which turned out to be the default size in my Windows system).

Each code file is an R function which returns a boolean value.   From the working directory, to produce the PNG file, enter:

> Bool <- Plotx()

where x = 1, 2, 3 or 4, depending on the plot desired.   Assuming the data file has been downloaded and unzipped as described above, Bool will receive the value TRUE, and file plotx.png will appear in your working directory.


The four constructed plots are described belown.   References to the plots copied from Roger Peng's repo have not been deleted, which might help to make comparisons.


### Plot 1

The first plot contained in <b>plot1.png</b> is a (color) red histogram of Global Active Power. It contains a main title (main), an x and y label (xlab, ylab), 12 bars in the histogram (breaks = 12) and a slightly reduced font size (cex = .8 in the par function).  See also the code.

The course uploaded file for Plot 1 is shown here:
![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


### Plot 2

The second plot contained in <b>plot2.png</b> is a line plot (type = "l") of (ylab = ) "Global Active Power (kilowatts)" versus datetimes (there is no x label so xlab = "").   There is no main title, no color, and the font for text was again made a little smaller (cex = .8 in the par function).


The course uploaded file for Plot 2 is shown here:
![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


### Plot 3

The second plot contained in <b>plot3.png</b> consists of three line (type = 'l') plots, all overlaid on the same set of axes.  The x-axis is date and time, listed by default as day of the week (using xlab = "").   The y-axis is labelled (ylab = ) "Energy sub metering".  Sub_metering_1 (column 7) is plotted in black in the original plot call.  Sub_metering_2 (column 8) is plotted in red using a subsequent "lines" call.  Sub_metering_3 (column 9) is plotted in blue using another "lines" call.   Finally, a legend is added using the legend command.  The global font size was reduced via cex in the par function.  We also needed to use "cex" within the legend function because the _1, _2, and _3 were being truncated in the .png file even though they were visible on the windows display.  See also comments in the code.

The course uploaded file for Plot 3 is shown here:
![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


### Plot 4

The second plot contained in <b>plot4.png</b> consists of four separate plots in a 2x2 format.   This was set using the par function.  Experimentation led us to the margin settings and font size adjustments specified in the par parameters.


The plot in position (1,1) used essentially the same plotting code that produced in plot2.png having been resized by the pars command.  

The plot in position (1,2) is voltage versus datatime.  Because a "with" format was not used,  the xlab and xylab values were set explicitly so as not to see pwr_data$Voltage as the y axis label.

The plot in position (2,1) used plotting code that is close, but not identical to the code plot of four graphs produced in plot3.png.  One (perhaps not immediately) noticable difference is that there is no visible box around the legend.   Please see comments in the code for more details.
 
The plot in position (2,2) is a plot of Voltage vs datetime.  Because the "with" format was used, the default ylab is Voltage.  Our x variable name is datetimes (with an s at the end), so ylab = "datetime" was set explicitly.  

The course uploaded file for Plot 4 is shown here:
![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

