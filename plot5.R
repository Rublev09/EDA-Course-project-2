
# Source data-files have been un-zipped and placed in the root-directory
# Load dataset
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

# Subset vehicles related NEI data
vehicles<- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC<- SCC[vehicles,]$SCC
vehiclesNEI<- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
BaltimoreVehiclesNEI<- vehiclesNEI[vehiclesNEI$fips=="24510",]

# Load ggplot2 library
library(ggplot2)

# ggPlot
plot<- ggplot(BaltimoreVehiclesNEI, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  geom_jitter(alpha = 0.10) +
  labs(x="Year", y="Total PM2.5 Emission") + 
  labs(title="PM2.5: Vehicles emissions from Baltimore City source")
print(plot)

# Save file .png 480x480
dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()
