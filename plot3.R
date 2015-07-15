
# Source data-files have been un-zipped and placed in the root-directory
# Load dataset
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

# Subset data by Baltimore's fip
Baltimore<- NEI[NEI$fips=="24510",]

# Aggregate total emissions by year, by sum
TotEmissBalt<- aggregate(Emissions ~ year, Baltimore, sum)

# Load ggplot2 library
library(ggplot2)

# ggPlot
plot<- ggplot(Baltimore, aes(x=factor(year), y=Emissions, fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(.~type) + 
  geom_jitter(alpha = 0.10) +
  labs(x="Year", y="Total PM2.5 Emission") + 
  labs(title="PM2.5: Emissions from Baltimore  City by source type")
print(plot)

# Save file .png 480x480
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
