#Plot 3 - 3.	Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources have 
#seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen 
#increases in emissions from 1999–2008? Use the ggplot2 plotting system to make
#a plot answer this question.

#Setting working directory
setwd('D:/DataScienceSpecialization/4-Exploratory_Data_Analysis/Week4/Assignment/ExploratoryDataAnalysis-Course-Project_2')

#Downloading data
if (!file.exists('./data'))
{dir.create('./data')}

url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(url,destfile = './data/data.zip',method = 'curl')
rm(url)

#Unzip data
if (!file.exists('./data/exdata_data_NEI_data'))
{unzip('./data/data.zip',exdir = './data')}

#Reading data,subsetting and manipulating it
NEI <- readRDS("./data/summarySCC_PM25.rds")
#SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI <- subset(NEI,fips == "24510")
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

ToTal_Emissions_grouped_year_type <- NEI %>% group_by(year,type) %>% 
  summarise(Emissions=(sum(Emissions)))


#Plotting
library(ggplot2)

png(filename = 'plot3.png',bg= 'transparent', width=700, height=480)

g <- ggplot(ToTal_Emissions_grouped_year_type, aes(x=year,y=Emissions,fill=type,label=round(Emissions,2)))+ geom_col() + facet_grid(.~type)+ geom_label(stat ='identity',size=3,fill='white',alpha=0.8) + ggtitle(label='	Of the four types of sources indicated by the type variable, which of these four sources have 
seen decreases in emissions from 1999–2008 for Baltimore City?')
print(g)

dev.off()