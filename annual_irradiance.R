# Load libraries for data manipulation and graphing

install.packages("dplyr")
install.packages("ggplot2")
install.packages("reshape")
install.packages("lubridate")

library(ggplot2)
library(dplyr)
library(reshape)
library(lubridate)

# Load data and define with as PARdata

PARdata <- read.csv("Daily_PAR_dates_fixed.csv")

# Goal 1: Annual average PAR per day

PARdataframe <- data.frame(PARdata)

PARdataframe

# convert date column to date class
PARdataframe$DATE_TIME <- as.Date(PARdataframe$DATE_TIME,
                                      format = "%m/%d/%y")

# subset to 2012 (sampling year)
PAR2012 <- PARdataframe[PARdataframe$DATE_TIME > as.Date("2011-07-01") &
                          PARdataframe$DATE_TIME < as.Date("2012-07-01"),]

# subset to columns of interest (average PAR, min PAR, max PAR)

wantedVariables <- c("DATE_TIME", "AVG_PAR", "MIN_PAR", "MAX_PAR")
PARMinMax2012 <- PAR2012[wantedVariables]

# reshape data
PARMinMax2012long <- melt(PARMinMax2012, id = "DATE_TIME", measure = c("AVG_PAR", "MIN_PAR", "MAX_PAR"))

# make plot


# working code

myPlot <- ggplot(PARMinMax2012long, aes(DATE_TIME, value, colour = variable)) + geom_line() + theme_bw() +
  scale_x_date(limit=c(as.Date("2011-07-01"),as.Date("2012-07-01")), date_labels = "%B %Y",date_breaks ="1 month") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.01))) +
  theme(axis.text.x=element_text(angle=70, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  labs(y="Photosynthetically Active Radiation (PAR)", x = "Month") +
  scale_colour_discrete(name="PAR Measurement", labels=c("Average PAR", "Minimum PAR", "Maximum PAR")) +
  ggtitle("Irradiance in Lake Vanda July 2011 - July 2012")

myPlot


### adding new column based on season and date. This will be used to annotate seasons

# new column
PARMinMax2012long$season <- "Value"


# fill season values, change the dates and season for each command. Data is from 2011-07 to 2012-06, so dates are a bit confusing.

PARMinMax2012long$season[PARMinMax2012long$DATE_TIME > as.Date("2011-10-14") & PARMinMax2012long$DATE_TIME < as.Date("2012-02-15")] <- "summer"
PARMinMax2012long$season[PARMinMax2012long$DATE_TIME > as.Date("2012-02-14") & PARMinMax2012long$DATE_TIME < as.Date("2012-04-15")] <- "fall"
PARMinMax2012long$season[PARMinMax2012long$DATE_TIME > as.Date("2012-04-14") & PARMinMax2012long$DATE_TIME <= as.Date("2012-06-30")] <- "winter"
PARMinMax2012long$season[PARMinMax2012long$DATE_TIME > as.Date("2011-07-01") & PARMinMax2012long$DATE_TIME < as.Date("2011-08-15")] <- "winter"
PARMinMax2012long$season[PARMinMax2012long$DATE_TIME > as.Date("2011-08-14") & PARMinMax2012long$DATE_TIME < as.Date("2011-10-15")] <- "spring"
