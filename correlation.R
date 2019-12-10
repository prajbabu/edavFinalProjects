library(ggplot2)
library(plotly)
library(reshape2)
wdi <- read.table('./WDI-tidied.csv', sep = ',', header = TRUE, check.names = FALSE)
happy <- read.table('./happy.csv', sep = ',', header = TRUE, check.names = FALSE)

# For each year, subset it, merge the datasets,
# and calculate the correlation matrix...
wdiThisYear <- wdi[wdi$Year == 2018,]
happyThisYear <- happy[happy$Year == 2018,]
# Merge on country name and year (to prevent two year columns)
mergedData = merge(wdiThisYear, happyThisYear, by = c("Country Name", "Year"), all.y = TRUE)
# Happiness are the last 5 columns, excluding the happiness column...
cormat = cor(x = mergedData[,3:128], y = mergedData[,129:134], use = "complete.obs")

# Now build the plot...
meltedCor = melt(cormat)
ggCor <- ggplot(meltedCor, aes(x = Var1, y = Var2, fill = value)) + 
  geom_tile() + 
  theme(axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank()) + 
  scale_fill_continuous_diverging()
# Convert to plotly
ggplotly(ggCor)

