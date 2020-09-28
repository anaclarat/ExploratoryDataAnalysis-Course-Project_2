#Plot 5 - How have emissions from motor vehicle sources changed from 1999–2008 
#in Baltimore City?

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

NEI <- subset(NEI,fips == "24510" & type == 'ON-ROAD')

ToTal_Emissions_grouped_year <- NEI %>% group_by(year) %>% 
  summarise(Emissions=(sum(Emissions)))

#Plotting
library(ggplot2)

png(filename = 'plot5.png',bg= 'transparent', width=700, height=480)

g <- ggplot(ToTal_Emissions_grouped_year, aes(x=year,y=Emissions,label=
                                                round(Emissions,2)))+ 
  geom_col() + 
  geom_label(stat ='identity',size=3,fill='white',color='black',alpha=0.8) + 
  ggtitle(label='	How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?')
print(g)

dev.off()