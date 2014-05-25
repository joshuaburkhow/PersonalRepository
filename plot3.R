setwd("L:/Files/Coursera/Exploratory Data Analysis/Project 2/")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 3
library(ggplot2)
##Subset data
baltimoreNEI <- subset(NEI,fips=="24510")
##take out the outlier
baltimoreNEI <- subset(baltimoreNEI, Emissions<1000)

##plot by type
png(filename="plot3.png")
qplot(year,Emissions,data=baltimoreNEI,facets=.~type) + geom_smooth()
dev.off()