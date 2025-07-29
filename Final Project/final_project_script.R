# Final Project Script - Macroeconomic Indicators and S&P 500 Returns
# Author: Ashish Thomas
# Date: July 22, 2025

# Load required libraries
cat("Loading libraries...\n")
library(tidyverse)
library(tidyquant)
library(lubridate)
library(janitor)
library(sandwich)
library(broom)
library(lmtest)  # for coeftest function

cat("\n=== FINAL PROJECT: MACROECONOMIC INDICATORS AND S&P 500 RETURNS ===\n")
cat("Author: Ashish Thomas\n")
cat("Date:", as.character(Sys.Date()), "\n\n")

# 1. Project Description
cat("1. PROJECT DESCRIPTION\n")
cat("Research question: Do lagged unemployment and inflation explain subsequent S&P 500 quarterly total returns (1980-2024)?\n\n")

cat("Data sources:\n")
cat("- UNRATE: Civilian unemployment rate (Monthly, %)\n")
cat("- CPIAUCSL: CPI-U (1982-84 = 100) (Monthly, index)\n")
cat("- ^GSPC: S&P 500 close (Daily, index)\n\n")

# 2. Data Download
cat("2. DATA DOWNLOAD & INITIAL TIDYING\n")
cat("Downloading data from FRED...\n")

unrate <- tq_get("UNRATE", get = "economic.data") |> clean_names()
cpi    <- tq_get("CPIAUCSL", get = "economic.data") |> clean_names()
sp500  <- tq_get("^GSPC", from = "1980-01-01") |> clean_names()

cat("UNRATE observations:", nrow(unrate), "\n")
cat("CPI observations:", nrow(cpi), "\n") 
cat("S&P 500 observations:", nrow(sp500), "\n\n")

# 3. Data Cleaning & Engineering
cat("3. CLEANING & ENGINEERING\n")

# Create quarterly S&P 500 log returns
sp500_clean <- sp500 |>
  select(date, adjusted) |>
  arrange(date) |>
  drop_na()

sp500_q <- sp500_clean |>
  mutate(quarter = floor_date(date, "quarter")) |>
  group_by(quarter) |>
  summarise(
    price_start = first(adjusted),
    price_end = last(adjusted),
    .groups = "drop"
  ) |>
  mutate(return_q = log(price_end / price_start)) |>
  select(quarter, return_q)

# Quarterly unemployment averages
unrate_q <- unrate |>
  mutate(quarter = floor_date(date, "quarter")) |>
  group_by(quarter) |>
  summarise(unrate = mean(price, na.rm = TRUE), .groups = "drop")

# Quarterly CPI and inflation calculation
cpi_q <- cpi |>
  mutate(quarter = floor_date(date, "quarter")) |>
  group_by(quarter) |>
  summarise(cpi = mean(price, na.rm = TRUE), .groups = "drop") |>
  arrange(quarter) |>
  mutate(inflation_q = 100 * (log(cpi) - lag(log(cpi))))

# Merge datasets and restrict to 1980+
dat <- sp500_q |>
  left_join(unrate_q, by = "quarter") |>
  left_join(cpi_q, by = "quarter") |>
  filter(quarter >= "1980-01-01") |>
  drop_na()

cat("Final dataset observations:", nrow(dat), "\n")
cat("Date range:", min(dat$quarter), "to", max(dat$quarter), "\n\n")

# 4. Summary Statistics
cat("4. SUMMARY STATISTICS\n")
summary_tbl <- dat |>
  summarise(
    across(c(unrate, inflation_q, return_q),
           list(Mean = ~mean(.x, na.rm=TRUE), 
                SD = ~sd(.x, na.rm=TRUE), 
                Min = ~min(.x, na.rm=TRUE), 
                Max = ~max(.x, na.rm=TRUE)),
           .names = "{.col}_{.fn}")
  )

print(summary_tbl)
cat("\n")

# 5. Visualizations
cat("5. VISUALIZATIONS\n")
cat("Creating time series plots...\n")

# Time series plots
p1 <- ggplot(dat, aes(quarter, unrate)) + 
  geom_line(color = "blue") + 
  labs(title = "Unemployment Rate", 
       x = "Quarter", 
       y = "Unemployment Rate (%)") +
  theme_minimal()

p2 <- ggplot(dat, aes(quarter, inflation_q)) + 
  geom_line(color = "red") + 
  labs(title = "Inflation QoQ (%)", 
       x = "Quarter", 
       y = "Quarterly Inflation (%)") +
  theme_minimal()

p3 <- ggplot(dat, aes(quarter, return_q)) + 
  geom_line(color = "green") + 
  labs(title = "S&P 500 Return (%)", 
       x = "Quarter", 
       y = "Quarterly Return") +
  theme_minimal()

# Save plots
ggsave("unemployment_plot.png", p1, width = 10, height = 6)
ggsave("inflation_plot.png", p2, width = 10, height = 6)
ggsave("sp500_plot.png", p3, width = 10, height = 6)

# Scatter plot
p4 <- ggplot(dat, aes(lag(unrate), return_q)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = "Lagged Unemployment vs S&P 500 Returns",
       x = "Unemployment Rate (t-1, %)", 
       y = "S&P 500 Quarterly Return") +
  theme_minimal()

ggsave("scatter_plot.png", p4, width = 10, height = 6)
cat("Plots saved as PNG files\n\n")

# 6. Regression Analysis
cat("6. REGRESSION ANALYSIS\n")
model <- lm(return_q ~ lag(unrate) + lag(inflation_q), data = dat)

# Get Newey-West standard errors
nw_se <- NeweyWest(model, lag = 4, prewhite = FALSE)
coefs <- coeftest(model, vcov = nw_se)

cat("Regression Results with Newey-West Standard Errors:\n")
print(coefs)

cat("\nModel Summary:\n")
cat("R-squared:", round(summary(model)$r.squared, 3), "\n")
cat("Adjusted R-squared:", round(summary(model)$adj.r.squared, 3), "\n\n")

# 7. Reflection & Next Steps
cat("7. REFLECTION & NEXT STEPS\n")
cat("Midterm goals achieved? Yes—datasets merged, engineered variables created, HAC-corrected regression executed.\n\n")

cat("Key findings:\n")
cat("- Lagged unemployment shows relationship with S&P 500 returns\n")
cat("- Inflation effects are less consistent\n")
cat("- Model explains modest variation in returns (R² ≈", round(summary(model)$r.squared, 3), ")\n\n")

cat("Next steps:\n")
cat("1. Add term spread & dividend yield as additional predictors\n")
cat("2. Compare linear model to random-forest regressors\n")
cat("3. Implement rolling-window out-of-sample forecasts\n")
cat("4. Publish workflow on GitHub with renv lockfile for full reproducibility\n\n")

# 8. External R Syntax
cat("8. USE OF EXTERNAL R SYNTAX\n")
cat("Beyond course materials, the project uses:\n")
cat("- tidyquant: FRED data download\n")
cat("- janitor: Clean variable names\n")
cat("- sandwich: Newey-West HAC SEs\n")
cat("- broom: Tidy regression output\n\n")

cat("=== ANALYSIS COMPLETE ===\n")
cat("All outputs saved. Check working directory for plot files.\n")
cat("GitHub repository: https://github.com/AshishTho/R-Summer25\n")
