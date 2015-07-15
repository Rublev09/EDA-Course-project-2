
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

# Subset the vehicles NEI data to Los Angeles County fip
LAVehiclesNEI<- vehiclesNEI[vehiclesNEI$fips=="06037",]

# Merge the data in one dataset
BaltimoreVehiclesNEI$city <- "Baltimore City"
LAVehiclesNEI$city <- "Los Angeles County"
twoCityNEI<- rbind(BaltimoreVehiclesNEI,LAVehiclesNEI)

# Load ggplot2 library
library(ggplot2)

# ggPlot
plot<- ggplot(twoCityNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(stat="identity") +
  facet_grid(.~city) +
  geom_jitter(alpha = 0.10) +
  labs(x="Year", y="Total PM2.5 Emission") + 
  labs(title="PM2.5: Vehicles emissions from Baltimore City & LA sources")
print(plot)

# Save file .png 480x480
dev.copy(png, file="plot6.png", width=480, height=480)
dev.off()
