# Versace Sales Analysis

This repository contains a **sales analysis project for Versace**, focused on understanding the impact of brand ambassadors on regional quarterly sales.

## Project Structure
- **`data/versaceSales.xlsx`**: Contains four sheets:
  - `VERSACE_SALES`: Yearly sales by region and simple graph
  - `QUARTERLY`: Quarterly sales by region
  - `AMBASSADORS`: Brand ambassador information (start/end dates, regions, type)
  - `Additional Info`: Some links to find brand ambassador information
- **`versaceSales.R`**: Performs the following:
  - Cleans and merges sales and ambassador datasets
  - Calculates cumulative ambassador counts and lagged ambassador metrics
  - Visualizes sales trends by region and ambassador count
  - Runs regression analyses to explore the effect of ambassadors on sales

## Data
The data can be found [here](https://www.capriholdings.com/financials/quarterly-reports/default.aspx) in the Earnings Release PDFs. Versace was sold to Capri in late 2018/early 2019 and then sold to Prada on April 10, 2025.

## Report/Blog
The report that ties along to this repository will be found [here]([https://visualizationsbyjosefina.com](https://visualizationsbyjosefina.com/2025/10/27/versace/)) once completed.

## Key Findings (Preliminary)
- EMEA consistently has higher sales than Asia or Americas.
- Ambassador counts (cumulative or lagged) do **not show a statistically significant effect** on quarterly sales in this dataset.
- Seasonal trends are minimal based on quarterly analysis.
