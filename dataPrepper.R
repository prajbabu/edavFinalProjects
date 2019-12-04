library(readxl)
fullData <- read_xlsx('./WDIEXCEL.xlsx', sheet = "Data")
# Convert to factors...
fullData$`Country Name` <- as.factor(fullData$`Country Name`)
fullData$`Country Code` <- as.factor(fullData$`Country Code`)
fullData$`Indicator Name` <- as.factor(fullData$`Indicator Name`)
fullData$`Indicator Code` <- as.factor(fullData$`Indicator Code`)
# Read in happiness, change column names...
happiness <- read_xls('./WHR2018Chapter2OnlineData.xls', sheet = "Figure2.2")
# Need to change country column name (it's lowercase...)
colnames(happiness)[1] <- "Country Name"
# Convert to factor...
happiness$`Country Name` <- as.factor(happiness$`Country Name`)
# Weird artifcats showed up....
happiness <- happiness[, -c(12:24)]

# Grab all the variables we want...
# (I'm reading these from the google doc)
variablesNeeded <- c(
  "SH.STA.SUIC.P5",     # Suicide Mortality Rate (per 100k)
  "SL.UEM.TOTL.ZS",     # Unemployment, total (% of total labor force) (modeled ILO estimate)
  "IQ.CPA.DEBT.XQ",     # CPIA Debt Policy Rating (1=low, 6=high)
  "EN.ATM.PM25.MC.ZS",  # PM2.5 air pollution, population exposed to levels exceeding WHO guideline value (% of total)
  "VC.PKP.TOTL.UN",     # Presence of peace keepers
  "MS.MIL.XPND.GD.ZS",  # Military expenditure (% of GDP)
  "VC.IDP.TOCV",        # Internally displaced persons, total displaced by conflict and violence (number of people)
  "SH.DTH.COMM.ZS",     # Cause of death, by communicable diseases and maternal, prenatal and nutrition conditions (% of total)
  "SH.H2O.SMDW.ZS",     # People using safely managed drinking water services (% of population)
  "EG.ELC.ACCS.ZS",     # Access to electricity
  "SP.DYN.AMRT.FE",     # Mortality rate, adult, female (per 1,000 female adults)
  "SP.DYN.AMRT.MA",     # Mortality rate, adult, male (per 1,000 male adults)
  "SE.ADT.LITR.ZS",     # Literacy rate, adult total (% of people ages 15 and above)
  "IQ.CPA.PROP.XQ"      # CPIA property rights and rule-based governance rating (1=low to 6=high)
)

# Filter!
filteredData <- fullData[fullData$`Indicator Code` %in% variablesNeeded,]

# Now, we want to right join with the happiness data, so any countries that
# are not in the happiness list disappear. 
# merged <- merge(x = filteredData, y = happiness, by = "Country Name", all.y = TRUE)

# Delete later...
# merged <- merged[-c(1933:1951),]

# Write to csv!
# write.csv(merged, file = "WDI+Happy.csv", row.names = FALSE, sep = ",")

