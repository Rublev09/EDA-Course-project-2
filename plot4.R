
# Source data-files have been un-zipped and placed in the root-directory
# Load dataset
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

# Subset coal & combustion related NEI data
comb<- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal<- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalcomb <- (comb & coal)
coalcombSCC<- SCC[coalcomb,]$SCC
coalcombNEI<- NEI[NEI$SCC %in% coalcombSCC,]

# Load ggplot2 library
library(ggplot2)

# ggPlot
plot<- ggplot(coalcombNEI, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  geom_jitter(alpha = 0.10) +
  labs(x="Year", y="Total PM2.5 Emission") + 
  labs(title="PM2.5: Coal Combustion from all US sources")
print(plot)

# Save file .png 480x480
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

