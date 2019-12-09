library(readxl)
library(tidyverse)

years = 2015:2019

globalCountryColName = "Country Name"
globalYearName = "Year"

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

countryColName = "Country"
happinessColName = "Happiness score"

happinessSheetNames = c(
  "Data for Figure2.2",
  "Figure2.2",
  "Figure2.2 WHR 2017",
  "Figure2.2",
  "Figure2.6"
)

# Create empty data frame
happyDF = data.frame(matrix(ncol = 8, nrow = 0))
colnames(happyDF) <- c(globalCountryColName, globalYearName, indicatorNames, "Happiness score")

for (i in 1:5) {
  print(years[i])
  filename = paste('./', years[i], 'HappyReport.xlsx', sep = "")
  # Read in the proper sheet...
  fullFile = read_xlsx(filename, sheet = indicatorSheetNames[i])
  # The 2019 dataset's country and year column names are
  # different.
  if (years[i] == 2019) {
    countryColName = "Country name"
    yearColName = "Year"
  }
  else {
    countryColName = "country"
    yearColName = "year"
  }
  # Now, it's read in, but we just want the indicator columns...
  fullFile = select(fullFile, c(countryColName, yearColName, indicatorNames))
  # Rename the country column name...
  colnames(fullFile)[1:2] <- c(globalCountryColName, globalYearName)
  yearData = fullFile[fullFile[,2] == years[i] - 1,]
  
  # Now we want to read in the happiness scores...
  if (years[i] == 2015) {
    countryColName = "country"
    happinessColName = "Ladder score"
  } else {
    countryColName = "Country"
    happinessColName = "Happiness score"
  }
  happyData <- read_xlsx(filename, sheet = happinessSheetNames[i])
  # Select the country and happiness columns...
  happyData <- select(happyData, c(countryColName, happinessColName))
  # Rename the country name...
  colnames(happyData)[1] <- globalCountryColName
  
  
  # Now merge them on country.
  combinedData <- merge(yearData, happyData, by = globalCountryColName, all.y = TRUE)
  # Countries that have no raw indicator values, will end up as NAs,
  # BUT, the year will disappear, so we need to put it back...
  combinedData[,2] <- years[i] - 1
  if (years[i] == 2015) {
    colnames(combinedData)[8] <- "Happiness score"
  }
  # Now we do rbind on the full happiness data frame
  happyDF <- rbind(happyDF, combinedData)
}


# Now, we need to change the country names to those that match the
# world development indicators dataset...
happCountryNames <- c(
  "Congo (Brazzaville)",
  "Congo (Kinshasa)",
  "Egypt",
  "Gambia",
  "Hong Kong",
  "Hong Kong S.A.R., China",
  "Hong Kong S.A.R. of China",
  "Iran",
  "Ivory Coast",
  "Kyrgyzstan",
  "Laos",
  "Macedonia",
  "North Cyprus",
  "Northern Cyprus",
  "Palestinian Territories",
  "Russia",
  "Slovakia",
  "South Korea",
  "Swaziland",
  "Syria",
  "Venezuela",
  "Trinidad & Tobago",
  "Yemen"
)

WDICountryNames <- c(
  "Congo, Rep.",
  "Congo, Dem. Rep.",
  "Egypt, Arab Rep.",
  "Gambia, The",
  "Hong Kong SAR, China",
  "Hong Kong SAR, China",
  "Hong Kong SAR, China",
  "Iran, Islamic Rep.",
  "Cote d'Ivoire",
  "Kyrgyz Republic",
  "Lao PDR",
  "North Macedonia",
  "Cyprus",
  "Cyprus",
  "West Bank and Gaza",
  "Russian Federation",
  "Slovak Republic",
  "Korea, Rep.",
  "Eswatini",
  "Syrian Arab Republic",
  "Venezuela, RB",
  "Trinidad and Tobago",
  "Yemen, Rep."
)

# Make a data frame
hapToWDI <- data.frame("Happy Name" = happCountryNames, "WDI Name" = WDICountryNames, stringsAsFactors = FALSE)

changeName <- function(countryName) {
  if (countryName %in% hapToWDI$Happy.Name) {
    return (hapToWDI[hapToWDI$Happy.Name == countryName,2])
  } else {
    return (countryName)
  }
}

# Apply to the Country Name column.
happyDF$`Country Name` <- sapply(happyDF$`Country Name`, changeName)

# # Write to csv
write.table(happyDF, file = './happy.csv', sep = ',', row.names = FALSE)





