library(readxl)
library(tidyverse)

years = 2015:2019

globalCountryColName = "Country"
globalYearName = "Year"

# Country column name..
countryColName = "country"
yearColName = "year"
indicatorNames = c(
  "Social support",
  "Healthy life expectancy at birth",
  "Freedom to make life choices",
  "Generosity",
  "Perceptions of corruption"
)

# Sheet names that hold values
# for indicators...
indicatorSheetNames = c(
  "Data for Table 2.1",
  "Data for Table2.1",
  "Data behind Table 2.1 WHR 2017",
  "Table2.1",
  "Table2.1"
)

# List to hold each year's data frames...
happyDFs <- list()

# filename = './2019HappyReport.xlsx'
# fullFile = read_xlsx(filename, sheet = "Table2.1")
# fullFile = select(fullFile, c(countryColName, yearColName, indicatorNames))

for (i in 1:5) {
  print(years[i])
  # Get filename
  filename = paste('./', years[i], 'HappyReport.xlsx', sep = "")
  # Read in the proper sheet...
  fullFile = read_xlsx(filename, sheet = indicatorSheetNames[i])
  # The 2019 dataset's country and year column names are
  # different.
  if (years[i] == 2019) {
    countryColName = "Country name"
    yearColName = "Year"
  }
  # Now, it's read in, but we just want the indicator columns...
  fullFile = select(fullFile, c(countryColName, yearColName, indicatorNames))
  # Rename the country column name...
  colnames(fullFile)[1:2] <- c(globalCountryColName, globalYearName)
  
  # The sheet has all the years, but we're only interested in
  # Append...
  # happyDFs <- append(happyDFs, list(fullFile))
  
  yearData = fullFile[fullFile[,2] == years[i] - 1,]
  happyDFs <- append(happyDFs, list(yearData))
}

# Okay, so we have the actual indicator values, now we need to 
# grab the happiness scores, and merge them. These are in another sheet...

countryColName = "Country"
happinessColName = "Happiness score"

happinessSheetNames = c(
  "Data for Figure2.2",
  "Figure2.2",
  "Figure2.2 WHR 2017",
  "Figure2.2",
  "Figure2.6"
)

for (i in 1:5) {
  filename = paste('./', years[i], 'HappyReport.xlsx', sep = "")
  if (years[i] == 2015) {
    countryColName = "country"
    happinessColName = "Ladder score"
  } else {
    countryColName = "Country"
    happinessColName = "Happiness score"
  }
  # Read in the sheet...
  happyData <- read_xlsx(filename, sheet = happinessSheetNames[i])
  # Select the country and happiness columns...
  happyData <- select(happyData, c(countryColName, happinessColName))
  # Rename the country name...
  colnames(happyData)[1] <- globalCountryColName
  View(happyData)
  
  # print(head(happyDFs[i]))
  # print(head(happyData))

  # Now merge them on country.
  happyDFs[[i]] <- merge(happyDFs[[i]], happyData, by = "Country", all.y = TRUE)
}

