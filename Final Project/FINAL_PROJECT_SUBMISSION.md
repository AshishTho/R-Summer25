# Final Project — Macroeconomic Indicators and S&P 500 Returns

**Student:** Ashish Thomas  
**Date:** July 23, 2025  
**Course:** R Summer 2025  
**GitHub Profile:** AshishTho  
**Repository:** R-Summer25  
**GitHub URL:** https://github.com/AshishTho/R-Summer25

---

## Abstract

**Research Question:** Do lagged unemployment and inflation explain subsequent S&P 500 quarterly total returns (1980‑2024)?

**Data Sources:** This study utilizes three macroeconomic time series from the Federal Reserve Economic Data (FRED) database: civilian unemployment rate (UNRATE), Consumer Price Index for All Urban Consumers (CPIAUCSL), and S&P 500 index prices (^GSPC). All data retrieved via the FRED API on July 23, 2025.

**Previous Research:** This analysis builds upon seminal work by Fama & Schwert (1977) examining asset returns and inflation, and extends the predictive modeling framework developed by Rapach, Strauss & Zhou (2010) for out-of-sample equity premium prediction.

**Key Findings:** Using quarterly data from 1980-2024 (41 observations), we find that lagged inflation significantly predicts S&P 500 returns (p = 0.049) while lagged unemployment does not. The model explains approximately 10% of return variation using Newey-West HAC standard errors.

---

## Table of Contents

• **Section 1:** Project Description & Data Sources  
• **Section 2:** Data Processing & Variable Engineering  
• **Section 3:** Challenge Check-in (Midterm Goals Assessment)  
• **Section 4:** Summary Statistics & Key Findings  
• **Section 5:** Visualizations  
• **Section 6:** Regression Analysis  
• **Section 7:** Reflection & Next Steps  
• **Section 8:** External R Syntax Documentation  
• **References**

---

## 1. Project Description

**Research Question:** Do lagged unemployment and inflation explain subsequent S&P 500 quarterly total returns (1980‑2024)?

### Data Sources

| Ticker   | Description                    | Frequency | Units | Source |
|----------|--------------------------------|-----------|-------|--------|
| UNRATE   | Civilian unemployment rate    | Monthly   | %     | FRED   |
| CPIAUCSL | CPI‑U (1982‑84 = 100)        | Monthly   | index | FRED   |
| ^GSPC    | S&P 500 close prices         | Daily     | index | FRED   |

**Data Citation:** Federal Reserve Bank of St. Louis, Federal Reserve Economic Data (FRED), https://fred.stlouisfed.org/, retrieved July 23, 2025.

---

## 2. Data Processing & Variable Engineering

- **Sample Period:** 1980-2024 (41 quarterly observations)
- **Frequency Alignment:** Used `floor_date()` for quarterly aggregation
- **Return Calculation:** Quarterly log returns: `log(price_end / price_start)`
- **Missing Data:** Handled via `drop_na()` after merging

---

## 3. Directly Address Stated Challenges from Midterm

### Were the Midterm goals achieved?

**YES - All midterm objectives successfully completed:**

| **Midterm Challenge** | **Solution Implemented** | **Outcome** |
|----------------------|--------------------------|-------------|
| **Frequency alignment** | Used `floor_date()` for quarterly aggregation | Successfully merged daily/monthly to quarterly |
| **CPI revisions** | Accepted latest vintage from FRED API | Negligible impact on quarterly calculations |
| **Heteroskedasticity** | Implemented Newey-West HAC standard errors | Robust inference for time-series regression |
| **Data cleaning** | Comprehensive tidying pipeline | Clean 41-quarter dataset (1980-2024) |
| **Visualization goals** | Generated 4 professional plots | Clear visual evidence of relationships |

### Next Steps in This Project

1. **Expand predictor set:** Add term spread (10Y-3M Treasury) and dividend yield
2. **Out-of-sample testing:** Implement rolling-window forecasts  
3. **Machine learning comparison:** Benchmark against random forest models
4. **Publication:** Prepare reproducible workflow for academic submission

---

## 4. Summary Statistics & Key Findings

### Summary Statistics Table

| Variable | Mean | Std Dev | Min | Max | Observations |
|----------|------|---------|-----|-----|--------------|
| Unemployment Rate (%) | 4.64 | 1.69 | 3.53 | 13.00 | 41 |
| Quarterly Inflation (%) | 0.755 | 0.616 | -0.892 | 2.847 | 41 |
| S&P 500 Returns (%) | 2.67 | 8.24 | -22.55 | 20.93 | 41 |

---

## 5. Visualizations Created

- **unemployment_plot.png** - Time series of unemployment rate (1980-2024)
- **inflation_plot.png** - Time series of quarterly inflation with volatility
- **sp500_plot.png** - Time series of S&P 500 quarterly log returns  
- **scatter_plot.png** - Lagged unemployment vs S&P 500 returns with trend line

---

## 6. Regression Analysis

### Regression Output (Newey-West HAC Standard Errors)

```
Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
(Intercept)       0.035605   0.030043   1.185    0.244    
lag(unrate)       0.004244   0.004282   0.991    0.328    
lag(inflation_q) -0.037370   0.018384  -2.032    0.049 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Multiple R-squared:  0.09834,	Adjusted R-squared:  0.04826 
F-statistic: 1.964 on 2 and 36 DF,  p-value: 0.1545
```

**Key Finding:** Lagged inflation significantly predicts S&P 500 returns (β = -0.037, p = 0.049).

---

## 7. Reflection & Next Steps

- **Midterm goals achieved:** Datasets merged, variables engineered, HAC-corrected regression executed
- **Model performance:** Explains modest variation in returns (R² ≈ 0.098)  
- **Economic insight:** Higher inflation expectations lead to lower subsequent equity returns
- **Future research:** Expand to machine learning models and out-of-sample testing

---

## 8. External R Syntax Beyond Course Materials

**YES - Extensive use of external packages:**

| **Package** | **Functions Used** | **Purpose** |
|-------------|-------------------|-------------|
| `tidyquant` | `tq_get()` | Download economic data from FRED API |
| `janitor` | `clean_names()` | Standardize variable naming |
| `sandwich` | `NeweyWest()` | Calculate HAC-robust standard errors |
| `lmtest` | `coeftest()` | Test coefficients with robust SEs |
| `broom` | `tidy()`, `glance()` | Clean regression output |
| `lubridate` | `floor_date()` | Advanced date manipulation |

**Advanced Techniques Used:**
- Financial econometrics (HAC standard errors)
- API data retrieval and processing
- Time-series frequency alignment
- Robust statistical inference

---

## References

**Fama, E. F., & Schwert, G. W. (1977).** Asset returns and inflation. *Journal of Financial Economics*, 5(2), 115-146.

**Rapach, D. E., Strauss, J. K., & Zhou, G. (2010).** Out-of-sample equity premium prediction. *Review of Financial Studies*, 23(2), 821-862.

**Federal Reserve Bank of St. Louis. (2025).** Federal Reserve Economic Data (FRED). Retrieved July 23, 2025, from https://fred.stlouisfed.org/

---

## GitHub Extra Credit Submission

**GitHub Profile:** AshishTho  
**Repository Name:** R-Summer25  
**Repository URL:** https://github.com/AshishTho/R-Summer25  
