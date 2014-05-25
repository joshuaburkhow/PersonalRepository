setwd("L:/Files/Coursera/Exploratory Data Analysis/Project 2/")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 1
png(filename="plot1.png")
with(NEI,plot(year,Emissions))
dev.off()

## Question 2
png(filename="plot2.png")
with(subset(NEI, fips == "24510"),plot(year,Emissions))
dev.off()

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

## Question 4
##join SCC to NEI
SCC_Cols <- c("SCC","SCC.Level.Three")
subsetSCC <- SCC[,names(SCC) %in% SCC_Cols]
mergedNEI <- merge(x = NEI, y = subsetSCC, by = "SCC", all.x = TRUE) 

## create working data set
nm <- mergedNEI$SCC.Level.Three
contain_Coal <- nm[grepl("Coal",nm)]
contain_Coal <- contain_Coal[!duplicated(contain_Coal)]
coalNEI <- subset(mergedNEI, mergedNEI$"SCC.Level.Three"==contain_Coal)

## plot emmisions by year filter by coal combustion
png(filename="plot4.png")
qplot(data = coalNEI,x = SCC.Level.Three,y = Emissions)
dev.off()

## Question 5
## note: assuming "ON-ROAD" identifies motor vehicle emission
baltimoreNEI_MV <- subset(baltimoreNEI,baltimoreNEI$type=="ON-ROAD")

#plot emissions by year for Motor Vehicles
png(filename="plot5.png")
qplot(data = baltimoreNEI_MV,x = year,y = Emissions)
dev.off()

## Question 6
#create dataset
LA_BaltimoreNEI <- subset(NEI,fips=="06037"|fips=="24510")

png(filename="plot6.png")
qplot(data = LA_BaltimoreNEI,x = fips,y = Emissions)
dev.off()