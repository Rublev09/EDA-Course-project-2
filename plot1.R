
# Source data-files have been un-zipped and placed in the root-directory
# Load dataset
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

# Aggregate total emissions by year, by sum
TotEmiss<- aggregate(Emissions ~ year, NEI, sum)

# Barplot
barplot(TotEmiss$Emissions, names.arg=TotEmiss$year, 
  col = rainbow(20, start = 0, end = 1),
  xlab="Year", ylab="PM2.5 Emissions",
  main="Total PM2.5: Emissions from all US sources")

# Save file .png 480x480
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

