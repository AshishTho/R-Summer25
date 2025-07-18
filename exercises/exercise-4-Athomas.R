################################################################################
#  Exercise 4 – Custom helper functions & variance check
#  Author:  Ashish Thomas
#  Date:    18‑Jul‑2025
#  Course:  ECON 4001
#  Purpose: • Wrap several repeated code snippets from Lecture 7 into reusable  
#             functions written with tidyverse / dplyr style  
#           • Write our own sample‑variance function and benchmark it against
#             base‐R var() using the real‑world *car_values.csv* data set
##################################################################################################################################################

# ──────────────────────────────────────────────────────────────────────────────
#  1.  Set‑up ------------------------------------------------------------------
# ──────────────────────────────────────────────────────────────────────────────
library(tidyverse)   # loads dplyr, readr, ggplot2, etc.

# ──────────────────────────────────────────────────────────────────────────────
#  2.  Helper functions --------------------------------------------------------
# ──────────────────────────────────────────────────────────────────────────────

## 2.1 Proportion of missing values -------------------------------------------
prop_missing <- function(vec) {
  # Returns the share (0–1) of NA values in `vec`
  mean(is.na(vec))
}

## 2.2 Proportion of each element relative to vector sum (values 0–1) ----------
prop_share <- function(vec, na_rm = TRUE) {
  vec / sum(vec, na.rm = na_rm)
}

## 2.3 Percentage of each element relative to vector sum -----------------------
prop_percent <- function(vec, digits = 1, na_rm = TRUE) {
  round(prop_share(vec, na_rm = na_rm) * 100, digits = digits)
}

## 2.4 Sample variance (unbiased, n – 1 in denominator) ------------------------
my_variance <- function(vec, na_rm = TRUE) {
  # Remove NAs if requested
  if (na_rm) vec <- vec[!is.na(vec)]
  
  n <- length(vec)
  mu <- mean(vec)
  sum((vec - mu)^2) / (n - 1)
}

# ──────────────────────────────────────────────────────────────────────────────
#  3.  Quick sanity checks with fake toy vectors -------------------------------
# ──────────────────────────────────────────────────────────────────────────────

## Create dummy test vectors mimicking x, y, z from the prompt
set.seed(7)
x <- c(sample(1:10, 6), NA, NA)    # inject NAs to mimic lecture demo
y <- c(sample(5:15, 8))
z <- c(NA, sample(2:12, 7))

# Confirm that our functions replicate the snippets (identical() must be TRUE)
stopifnot(
  identical(prop_missing(x), mean(is.na(x))),
  identical(prop_missing(y), mean(is.na(y))),
  identical(prop_missing(z), mean(is.na(z))),
  
  identical(prop_share(x), x / sum(x, na.rm = TRUE)),
  identical(prop_share(y), y / sum(y, na.rm = TRUE)),
  identical(prop_share(z), z / sum(z, na.rm = TRUE)),
  
  identical(prop_percent(x), round(x / sum(x, na.rm = TRUE) * 100, 1)),
  identical(prop_percent(y), round(y / sum(y, na.rm = TRUE) * 100, 1)),
  identical(prop_percent(z), round(z / sum(z, na.rm = TRUE) * 100, 1))
)

# ──────────────────────────────────────────────────────────────────────────────
#  4.  Load real data and verify variances -------------------------------------
# ──────────────────────────────────────────────────────────────────────────────

car_values <- read_csv("data/car_values.csv")  # CSV is in data/ subdirectory

## Pull columns of interest
price_vec   <- car_values$Price
mileage_vec <- car_values$Mileage

## Compute & compare
price_var_my <- my_variance(price_vec)
price_var_R  <- var(price_vec)            # var() uses na.rm = FALSE by default,
                                          # but there are no NAs in Price column

mileage_var_my <- my_variance(mileage_vec)
mileage_var_R  <- var(mileage_vec)

## Display verification in console
cat("\n--- Variance checks ---------------------------------------\n")
cat(sprintf("Price   : my_variance = %0.2f | base var() = %0.2f\n",
            price_var_my, price_var_R))
cat(sprintf("Mileage : my_variance = %0.2f | base var() = %0.2f\n",
            mileage_var_my, mileage_var_R))

# (Expected values with the provided dataset:)
# Price   : ~  97,710,314.86
# Mileage : ~  67,179,656.74

stopifnot(all.equal(price_var_my,  price_var_R,  tol = 1e-10),
          all.equal(mileage_var_my, mileage_var_R, tol = 1e-10))

cat("\nAll tests passed ✔️\n")

# ──────────────────────────────────────────────────────────────────────────────
#  5.  End of script -----------------------------------------------------------
################################################################################
