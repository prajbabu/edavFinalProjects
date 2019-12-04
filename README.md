Potential Variables:
- Population
- GDP (per capita)
- all exports and imports (by region) - this would be the interactive visualization 


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

| Happiness Country Name | WDI Country |
|------------------------|-------------|
| Taiwan Province of China | N/A |
| Trinidad & Tobago | Trinidad and Tobago |
| Slovakia | Slovak Republic |
| South Korea | Korea, Rep. |
| Northern Cyprus | Cyprus |
| Russia | Russian Federation |
| Macedonia | North Macedonia |
| Kyrgyzstan | Kyrgyz Republic |
| Venezuela | Venezuela, RB |
| Palestinian Territories | West Bank and Gaza |
| Iran | Iran, Islamic Rep. |
| Ivory Coast | Côte d'Ivoire |
| Laos | Lao PDR |
| Congo (Brazzaville) | Congo, Rep. |
| Congo (Kinshasa) | Congo, Dem. Rep. |
| Egypt | Egypt, Arab Rep. |
| Syria | Syrian Arab Republic |
| Yemen | Yemen, Rep. |
