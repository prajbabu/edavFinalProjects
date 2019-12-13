library(readxl)
library(tidyverse)
library(httr)

if (!file.exists('./happy.csv')) {
  years = 2015:2019
  
  globalCountryColName = "Country Name"
  globalYearName = "Year"
  
  fileLinks = c(
    "https://s3.amazonaws.com/happiness-report/2015/Chapter2OnlineData_Expanded-with-Trust-and-Governance.xlsx",
    "https://s3.amazonaws.com/happiness-report/2016/Online-data-for-chapter-2-whr-2016.xlsx",
    "https://s3.amazonaws.com/happiness-report/2017/online-data-chapter-2-whr-2017.xlsx",
    "https://s3.amazonaws.com/happiness-report/2018/WHR2018Chapter2OnlineData.xls",
    "https://s3.amazonaws.com/happiness-report/2019/Chapter2OnlineData.xls"
  )
  
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
    # Download excel file to a temp file..
    # 2015-2017 reports are xlsx files,
    # while 2018 and 2019 reports are xls files
    if (i <= 3) {
      GET(fileLinks[i], write_disk(tf <- tempfile(fileext = '.xlsx')))
    } else {
      GET(fileLinks[i], write_disk(tf <- tempfile(fileext = '.xls')))
    }
    # If it's 2015, we need to skip the first 3 rows...
    if (years[i] == 2015) {
      fullFile = read_excel(tf, sheet = indicatorSheetNames[i], skip = 3)
      happyData <- read_excel(tf, sheet = happinessSheetNames[i], skip = 3)
    }
    else {
      fullFile = read_excel(tf, sheet = indicatorSheetNames[i], skip = 0)  # 0 is default but be explicit anyway
      happyData <- read_excel(tf, sheet = happinessSheetNames[i], skip = 0)
    }
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
    
    # Don't store the tempfile, unlink it so it disaapears
    unlink(tf)
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
}





