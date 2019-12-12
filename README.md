LINK TO BLOCKBUILDER:

https://bl.ocks.org/prajbabu/raw/64632ce0480ca5bdfdc03ebe55189d20/12a274ef2c6317be19034e950be307cfcd3b3d35/

Potential Variables:

| Variable Name                                                                                         | Variable Code     |
|-------------------------------------------------------------------------------------------------------|-------------------|
| Suicide Mortality Rate (per 100k)                                                                     | SH.STA.SUIC.P5    |
| Unemployment, total (% of total labor force) (modeled ILO estimate)                                   | SL.UEM.TOTL.ZS    |
| CPIA Debt Policy Rating (1=low, 6=high)                                                               | IQ.CPA.DEBT.XQ    |
| PM2.5 air pollution, population exposed to levels exceeding WHO guideline value (% of total)          | EN.ATM.PM25.MC.ZS |
| Presence of peace keepers                                                                             | VC.PKP.TOTL.UN    |
| Military expenditure (% of GDP)                                                                       | MS.MIL.XPND.GD.ZS |
| Internally displaced persons, total displaced by conflict and violence (number of people)             | VC.IDP.TOCV       |
| Cause of death, by communicable diseases and maternal, prenatal and nutrition conditions (% of total) | SH.DTH.COMM.ZS    |
| People using safely managed drinking water services (% of population)                                 | SH.H2O.SMDW.ZS    |
| Access to electricity                                                                                 | EG.ELC.ACCS.ZS    |
| Mortality rate, adult, female (per 1,000 female adults)                                               | SP.DYN.AMRT.FE    |
| Mortality rate, adult, male (per 1,000 male adults)                                                   | SP.DYN.AMRT.MA    |
| Literacy rate, adult total (% of people ages 15 and above)                                            | SE.ADT.LITR.ZS    |
| CPIA property rights and rule-based governance rating (1=low to 6=high)                               | IQ.CPA.PROP.XQ    |


Imports:
1. Merchandise imports from low- and middle-income economies in East Asia & Pacific (% of total merchandise imports)
2. Merchandise imports from low- and middle-income economies in Europe & Central Asia (% of total merchandise imports)
3. Merchandise imports from low- and middle-income economies in Latin America & the Caribbean (% of total merchandise imports)
4. Merchandise imports from low- and middle-income economies in Middle East & North Africa (% of total merchandise imports)
5. Merchandise imports from low- and middle-income economies in South Asia (% of total merchandise imports)
6. Merchandise imports from low- and middle-income economies in Sub-Saharan Africa (% of total merchandise imports)

7. Merchandise imports from low- and middle-income economies outside region (% of total merchandise imports)
8. Merchandise imports from low- and middle-income economies within region (% of total merchandise imports)


## Data Preparation
Read in both happiness data and world development indicators data separately. Subset on the indicators. Merge the two datasets on the country names. However, the following countries in the happiness data go by different names (sometimes offical) in the WDI data: There are only 18 of them, so it is easy enough to do a hard-code replacement. **Taiwan** is not in the WDI dataset.

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

## Question 1: Which specific indicators correlate strongly for and against the indicators used in the 2019 Happiness Report?
See `correlation.R` for the code used to accomplish this.
### Correlate For (Top 3 Distinct*)
| Happiness Report Indicator | WDI Indicators which strongly correlate for |
|----------------------------|---------------------------------------------|
| Social support             | Wage and salaried workers (0.88)<br>Employment in services<br>Urban population |
| Healthy Life Expectancy at Birth | Wage and salaried workers (0.88)<br>Fixed broadband subscriptions<br>Population ages 65 and above |
| Freedom to make life choices | Depth of credit information (0.39)<br>Immunization of measles infants<br>Private credit bureau coverage |
| Generosity | \# of Tax payments (0.41)<br>Urban population growth<br>Population growth<br> |
| Perceptions of Corruption | Procedures to build a warehouse (0.36)<br>Time required to start a business<br>Foreign direct investment |

### Correlate Against (Top 3 Distinct*)
| Happiness Report Indicator | WDI Indicators which strongly correlate for |
|----------------------------|---------------------------------------------|
| Social support             | Vulnerable Employment (-0.88)<br>Self-employed<br>Infant mortality rate |
| Healthy life expectancy at birth | Infant mortality rate (-0.93)<br>Age Dependency Ratio of young to working-age population<br>Population of ages 0-14 |
| Freedom to make life choices | Refugee population by country of origin (-0.42)<br>Cost to import documentary compliance<br>Time required to get electricity |
| Generosity | Labor tax and contributions as % of commercial profits (-0.42)<br>Population of ages 65 and above<br>Unemployment of total labor force |
| Perceptions of corruption | Proportion of seats held by women in parliament (-0.46)<br>GNI per capita<br>Labor force participation of ages 15-24 |

\*Distinct in the sense that if we had 3 closely linked indicators i.e. "Infant mortality rate, Under 5 mortality rate", the one with the most extreme correlation was chosen.
