#Plot 2 - 2.2.	Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to 
#make a plot answering this question.

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
#SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI <- subset(NEI,fips == "24510")

ToTal_Emissions_grouped_year <- NEI %>% group_by(year) %>% 
  summarise(Emissions=sum(Emissions)/1000)

#Plotting
png(filename = 'plot2.png',bg= 'transparent', width=700, height=480)

plot(ToTal_Emissions_grouped_year,xlab = "Years",
     ylab = expression('PM'[2.5]*' Emissions in kilotons'),type='b',col= 'black',
     ylim=c(min(ToTal_Emissions_grouped_year$Emissions-1),
            max(ToTal_Emissions_grouped_year$Emissions)+1),
     xlim=c(1998,2008))

text(x=c(1999,2002,2005,2008), y = round(ToTal_Emissions_grouped_year$Emissions,2), 
     label = round(ToTal_Emissions_grouped_year$Emissions,2), pos=3,
     cex = .8, col = "red")
mtext(expression('Have total emissions from PM'[2.5]*' decreased in the Baltimore City,Maryland from 1999 to 2008?'),
      cex=1.2)

dev.off()