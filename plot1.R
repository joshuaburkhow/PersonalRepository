setwd("L:/Files/Coursera/Exploratory Data Analysis/Project 2/")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 1
png(filename="plot1.png")
with(NEI,plot(year,Emissions))
dev.off()