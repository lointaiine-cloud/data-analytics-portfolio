# Climate Intelligence & Environmental Risk Analytics

## Project Overview

An interactive Power BI project focused on analyzing historical climate anomalies and environmental patterns across European regions.

The project uses climate data from the Copernicus Climate Data Store to explore long-term changes in temperature, heat extremes, precipitation, and drought conditions. Regional analysis is performed at the NUTS2 level, allowing comparisons across European territories.

The dashboard combines historical trend analysis, regional rankings, KPI indicators, and an interactive geographic map to identify spatial and temporal patterns in climate anomalies.

## Business Objectives

- Analyze long-term climate anomaly trends across Europe.
- Identify regions experiencing the highest positive and negative climate anomalies.
- Compare different climate indicators across European regions.
- Explore geographical patterns in temperature, precipitation, and drought-related anomalies.
- Provide an interactive analytical tool for exploring regional climate data.

## Dataset

**Source:** Copernicus Climate Data Store — Aggregated climate indicators for Europe.

**Geographic level:** NUTS2 regions.

**Historical coverage:** 1940–2025.

**Dataset size:** 574,480 records.

**Geographic coverage:** 334 NUTS2 regions.

**Reference periods:** 1981–2010 and 1991–2020.

### Climate Indicators

The analysis includes 10 indicators:

1. Mean Temperature Anomaly
2. Hot Days Anomaly (30°C)
3. Hot Days Anomaly (35°C)
4. Hot Days Anomaly (40°C)
5. Climatological Heatwave Days Anomaly
6. Total Precipitation Anomaly
7. Extreme Precipitation Total Anomaly
8. Frequency of Extreme Precipitation Anomaly
9. Consecutive Dry Days Anomaly
10. Duration of Meteorological Droughts Anomaly

All indicators represent anomalies relative to their corresponding reference climatological periods rather than absolute climate observations.

## Tools & Technologies

- **Power BI** — Interactive dashboard development and data visualization.
- **DAX** — Measures and analytical calculations.
- **Power Query** — Data transformation, cleaning, and preparation.
- **Copernicus Climate Data Store** — Primary climate data source.
- **Eurostat GISCO** — NUTS2 geographic boundaries and regional identification.

## Data Preparation & Analysis

The project involved an end-to-end analytical workflow:

- Imported and prepared climate datasets.
- Standardized data types and regional identifiers.
- Combined multiple climate indicators into a unified analytical dataset.
- Integrated NUTS2 geographic identifiers with regional names.
- Created a calendar table for historical trend analysis.
- Established relationships between calendar and climate fact tables.
- Developed DAX measures for average, maximum, and minimum climate anomalies.
- Configured dynamic filtering by climate indicator and reference period.

## Dashboard Features

### 1. Historical Climate Trends

An interactive line chart displaying annual climate anomaly dynamics across European regions from 1940 to 2025.

Users can select individual climate indicators to explore their historical patterns.

### 2. Regional Comparison

Two Top 10 rankings identify:

- Regions with the highest positive climate anomalies.
- Regions with the lowest negative climate anomalies.

This allows comparison of regional differences for the selected indicator.

### 3. Climate Anomaly KPIs

The dashboard includes four key performance indicators:

- Regions Analyzed
- Historical Coverage
- Maximum Climate Anomaly
- Minimum Climate Anomaly

### 4. European Climate Anomaly Map

An interactive choropleth map based on European NUTS2 geographic boundaries.

The map visualizes regional climate anomalies using a diverging color scale:

- Blue — Negative anomalies
- Neutral — Values around zero
- Orange/Brown — Positive anomalies

Hovering over individual regions displays their NUTS2 codes, names, and corresponding anomaly values.

### 5. Interactive Filtering

The dashboard allows users to explore different climate indicators through interactive filters, with visualizations updating dynamically.

## Key Analytical Outcomes

The project provides:

- Historical analysis of 10 climate indicators across 334 European NUTS2 regions.
- Identification of regions with the highest positive and negative anomalies.
- Comparison of climate patterns across different geographical areas.
- Visualization of regional climate differences through an interactive European map.
- A unified analytical environment for exploring long-term climate anomaly patterns.


**Project Type:** Climate Data Analytics | Environmental Analytics | Geographic Data Visualization

**Developed using:** Power BI, DAX, Power Query, Copernicus Climate Data, Eurostat GISCO.
