# Happiness vs. World Development Indicators
This repository holds the report which examines happiness values and a swath of development indicators for countries around the world. This report was also submitted as a final project in the Exploratory Data Analysis and Visualization class at Columbia University in Fall 2019.

## Usage
First, due to the size of the initial World Bank dataset, we will not house the original. Instead, follow these steps to reproduce the report:

1. Clone this repo into a folder.
2. Download the full World Bank Indicator set (~64 MB) [here](http://databank.worldbank.org/data/download/WDI_excel.zip)
3. Extract the sole Excel file inside to the repo folder.
4. Open RStudio, and knit the `FinalReport.Rmd` to HTML. The requisite transformed datasets will get generated, as the happiness data is pulled from online. That said, please ensure you have an internet connection if you are running for the first time. As long as the transformed file exists, the transformation scripts will not be run.
5. Enjoy!

### Interactivity
We also produced an interactive visualization house [here](https://bl.ocks.org/prajbabu/raw/64632ce0480ca5bdfdc03ebe55189d20/12a274ef2c6317be19034e950be307cfcd3b3d35/).

## Mismatched countries
the following countries in the happiness data go by different names (sometimes offical) in the WDI data: There are only 18 of them, so it is easy enough to do a hard-code replacement. **Taiwan** and **Somaliland** (a region of autonomity in upper Somalia) are not in the WDI dataset.

| Happiness Country Name   | WDI Country          |
|--------------------------|----------------------|
| Congo (Brazzaville)      | Congo, Rep.          |
| Congo (Kinshasa)         | Congo, Dem. Rep.     |
| Egypt                    | Egypt, Arab Rep.     |
| Gambia                   | Gambia, The          |
| Hong Kong<br>Hong Kong S.A.R., China<br>Hong Kong S.A.R. of China | Hong Kong SAR, China |
| Iran                     | Iran, Islamic Rep.   |
| Ivory Coast              | Côte d'Ivoire        |
| Kyrgyzstan               | Kyrgyz Republic      |
| Laos                     | Lao PDR              |
| Macedonia                | North Macedonia      |
| North Cyprus<br>Northern Cyprus          | Cyprus               |
| Palestinian Territories  | West Bank and Gaza   |
| Russia                   | Russian Federation   |
| Slovakia                 | Slovak Republic      |
| Somaliland region*       | N/A                  |
| South Korea              | Korea, Rep.          |
| Swaziland                | Eswatini             |
| Syria                    | Syrian Arab Republic |
| Taiwan<br>Taiwan Province of China* | N/A                  |
| Venezuela                | Venezuela, RB        |
| Trinidad & Tobago        | Trinidad and Tobago  |
| Yemen                    | Yemen, Rep.          |

\*Note these are not in the World Bank Indicators dataset.

#### Acknowledgements
Credit to [this](https://github.com/tholman/github-corners) Github repo for the nice corner Github link on the report.
