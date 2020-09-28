#Plot 4 - 4. Across the United States, how have emissions from coal 
#combustion-related sources changed from 1999–2008?

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
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)


SCC <- SCC[,c(1,4)]

Merged_DF <- merge(NEI,SCC,by='SCC')

Comb_Coal <- grepl('Fuel Comb.*Coal',Merged_DF$EI.Sector)
sub_Comb <- Merged_DF[Comb_Coal,]

ToTal_Emissions_grouped_year <- sub_Comb %>% group_by(year) %>% 
  summarise(Emissions=(sum(Emissions)/1000))


#Plotting
library(ggplot2)

png(filename = 'plot4.png',bg= 'transparent', width=700, height=480)

g <- ggplot(ToTal_Emissions_grouped_year, aes(x=year,y=Emissions,label=
                                                round(Emissions,2)))+ 
geom_col() + 
ylab(expression("Total PM"[2.5]*" emissions in kilotons"))+
geom_label(stat ='identity',size=3,fill='white',color='black',alpha=0.8) + 
ggtitle(label='	Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?')
print(g)

dev.off()