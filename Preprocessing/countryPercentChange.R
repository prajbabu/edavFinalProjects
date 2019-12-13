merged = merge(wdi, happy, by = c("Country Name", "Year"), all.y = TRUE)

posNegHapInd = data.frame(matrix(ncol = 4, nrow = 0))

# For each unique country we have...
for (country in unique(merged$`Country Name`)) {
  print(country)
  # Subset...
  countryData = merged[merged$`Country Name` == country,]
  # If we don't have 5 years, skip the country...
  if (dim(countryData)[1] != 5) {
    next
  }
  # Calculate correlation along years with indicators vs. happiness
  countryCor = cor(x = countryData[,3:128], y = countryData[,134])
  
  # Now we're going to subset country data based on the columns
  # that gave the highest and lowest correlations respectively.
  # Column indices are offset by 2...
  highLowCD = countryData[, c(
    which.max(countryCor[,1])[[1]] + 2,
    which.min(countryCor[,1])[[1]] + 2,
    134
  )]
  
  # Now calculate percent changes for each of the three...
  highLowPCCD = apply(highLowCD, 2, function(x) {(x / x[1] - 1) * 100})
  
  # Bind the country name and year to the left...
  finalCountryDF = cbind(`Country Name` = country, Year = 2014:2018, as.data.frame(highLowPCCD))
  # Melt it, using the country name and year as ids...
  finalCountryDF = melt(finalCountryDF, id.vars = c("Country Name", "Year"),
                        variable.name = "Indicator",
                        value.name = "Percentage Change from 2014")
  
  # Now add these rows to our big data frame...
  posNegHapInd = rbind(posNegHapInd, finalCountryDF)
}

# Write to csv!
write.table(posNegHapInd, file = "./CountryHappinessChange.csv", row.names = FALSE, sep = ',')