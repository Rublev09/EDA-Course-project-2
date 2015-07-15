
# Source data-files have been un-zipped and placed in the root-directory
# Load dataset
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

# Subset data by Baltimore's fip
Baltimore<- NEI[NEI$fips=="24510",]

# Aggregate total emissions by year, by sum
TotEmissBalt<- aggregate(Emissions ~ year, Baltimore, sum)

# Barplot
barplot(TotEmissBalt$Emissions, names.arg=TotEmissBalt$year, 
        col = rainbow(20, start = 0, end = 1),
        xlab="Year", ylab="PM2.5 Emissions",
        main="Total PM2.5: Emission from Baltimore City sources")

# Save file .png 480x480
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
