#Plot 6 - Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in Los Angeles County, California
#(fips == "06037"). Which city has seen greater changes over time in motor 
#vehicle emissions?

#Setting working directory
setwd('D:/DataScienceSpecialization/4-Exploratory_Data_Analysis/Week4/Assignment/ExploratoryDataAnalysis-Course-Project_2')

#Downloading data
if (!file.exists('./data'))
{dir.create('./data')}

if (!file.exists('./data/data.zip')){
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
  download.file(url,destfile = './data/data.zip',method = 'curl')
  rm(url)}

#Unzip data
if (!file.exists('./data/exdata_data_NEI_data'))
{unzip('./data/data.zip',exdir = './data')}

#Reading data,subsetting and manipulating it
NEI <- readRDS("./data/summarySCC_PM25.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

NEI <- subset(NEI, type == 'ON-ROAD' & (fips == "24510"|fips == "06037"))
NEI$fips <- gsub('24510','Baltimore',NEI_t$fips)
NEI$fips <- gsub('06037','LA',NEI_t$fips)
names(NEI) <- c("City","SCC","Pollutant","Emissions","type","year" ) 

ToTal_Emissions_grouped_year <- NEI %>% group_by(year,City) %>% 
  summarise(Emissions=(sum(Emissions)))

#Plotting
library(ggplot2)

png(filename = 'plot6.png',bg= 'transparent', width=700, height=480)

g <- ggplot(ToTal_Emissions_grouped_year, aes(x=year,y=Emissions,label=
                                                round(Emissions,2),color=City,fill=City))+ 
  geom_col() + 
  facet_grid(.~City)+
  geom_label(stat ='identity',size=3,fill='white',color='black',alpha=0.8) + 
  ggtitle(label='Which city has seen greater changes over time in motor vehicle emissions?')
print(g)

dev.off()