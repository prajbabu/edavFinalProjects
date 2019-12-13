library(readxl)
library(tidyverse)

if (!file.exists('./WDI-tidied.csv')) {
  fullData <- read_xlsx('./WDIEXCEL.xlsx', sheet = "Data")
  # # Convert to factors...
  # fullData$`Country Name` <- as.factor(fullData$`Country Name`)
  # fullData$`Country Code` <- as.factor(fullData$`Country Code`)
  # fullData$`Indicator Name` <- as.factor(fullData$`Indicator Name`)
  # fullData$`Indicator Code` <- as.factor(fullData$`Indicator Code`)
  
  # Grab 2014-2018 data...
  yearSubset <- fullData[complete.cases(fullData[,59:63]),-c(5:58, 64)]
  
  # Group the data by indicators, and count how many countries/regions have it.
  groupedWDI <- yearSubset %>% group_by(`Indicator Name`) %>% summarise(n = n())
  
  # Cut down on our indicators by taking those which have at least 199 instances
  # and only counting the 'total' ones. We thought this was a safe number, as there
  # are 196 countries in the world.
  cutDownIndicators <- groupedWDI[groupedWDI$n >= 199 & 
                                    !(grepl("female", groupedWDI$`Indicator Name`) | 
                                        grepl("male", groupedWDI$`Indicator Name`)),]
  
  # Cut down on the original by the indicators that were selected.
  finalCutDown <- yearSubset[yearSubset$`Indicator Name` %in% cutDownIndicators$`Indicator Name`,]
  
  # We want the year to be a variable column. Gather works...
  tidiedData <- finalCutDown %>% gather(key = "Year", value = "Value",
                                        -`Country Name`,
                                        -`Country Code`,
                                        -`Indicator Name`,
                                        -`Indicator Code`)
  # We're not done yet though, we want to turn the indicators
  # into columns, while keeping the country name and year.
  # Now, the code is redundant. This is for correlation...
  tidiedData <- select(tidiedData, -`Indicator Code`, -`Country Code`)
  tidiedData <- spread(tidiedData, key = "Indicator Name", value = "Value")
  
  # Write to csv!
  write.table(tidiedData, file = './WDI-tidied.csv', sep = ",", row.names = FALSE)
}

