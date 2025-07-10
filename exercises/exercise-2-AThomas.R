# Author: Ashish Thomas
# Date: 2025-07-02
# Title: Exercise 2 – Basic vector operations, subsetting, and simple stats in R
# Description: Creates weight & height vectors for 10 children, derives summary
#   statistics, subsets data, computes BMI, and orders vectors as required by
#   Exercise 2 instructions.

# ---------------------------------------------------------------------------
# 1. Weight vector -----------------------------------------------------------
weight <- c(69, 62, 57, 59, 59, 64, 56, 66, 67, 66)

# 2. Descriptive statistics on weight ----------------------------------------
wt_mean   <- mean(weight)
wt_var    <- var(weight)          # sample variance
wt_sd     <- sd(weight)
wt_range  <- range(weight)        # returns c(min, max)
wt_length <- length(weight)

# 3. First‑five weights ------------------------------------------------------
first_five <- weight[1:5]

# 4. Height vector -----------------------------------------------------------
height <- c(112, 102, 83, 84, 99, 90, 77, 112, 133, 112)

# Summary of height data
height_summary <- summary(height) # prints in console

# 5. Selective height subsets -----------------------------------------------
some_child     <- height[c(2, 3, 9, 10)]      # 2nd, 3rd, 9th, 10th
shorter_child  <- height[height <= 99]        # heights ≤ 99 cm

# 6. BMI calculation ---------------------------------------------------------
height_m <- height / 100                     # convert cm → m
bmi      <- weight / (height_m ^ 2)

# 7. Sorted height vector ----------------------------------------------------
height_sorted <- sort(height)               # ascending order

# 8. Child names and ordering ------------------------------------------------
child_name <- c("Alfred", "Barbara", "James", "Jane", "John",
                "Judy", "Louise", "Mary", "Ronald", "William")

# Order indices from shortest to tallest
height_ordered <- order(height)              # gives positions
names_sort     <- child_name[height_ordered] # names in ascending height

# 9. Names ordered by descending weight --------------------------------------
# Option A: use 'order' with decreasing = TRUE
weight_rev <- child_name[order(weight, decreasing = TRUE)]
# (Option B: weight_rev <- child_name[rev(order(weight))] )

# ---------------------------------------------------------------------------
# RESULTS (for reference) ----------------------------------------------------
# Weight – mean: 62.5 kg
# Weight – variance: 20.722
# Weight – SD: 4.552
# Weight – range: 56 – 69 kg
# Number of children: 10
#
# first_five weights: 69 62 57 59 59
#
# Height summary (cm):
#   Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
#   77       85.5      100.5      100.4     112        133
#
# some_child heights (cm): 102 83 133 112
# shorter_child heights (cm ≤99): 83 84 99 90 77
#
# BMI (kg/m²) vector:
#   55.01 59.59 82.74 83.62 60.20 79.01 94.45 52.61 37.88 52.61
#
# Shortest child:  Louise  (77 cm)
# Tallest child :  Ronald  (133 cm)
#
# Heaviest child:  Alfred  (69 kg)
# Lightest child:  Louise  (56 kg)
#
# Objects created (check with ls()):
#   bmi, child_name, first_five, height, height_m, height_ordered,
#   height_sorted, height_summary, some_child, shorter_child,
#   names_sort, weight, weight_rev, wt_mean, wt_var, wt_sd, wt_range,
#   wt_length
#
# ---------------------------------------------------------------------------
# END OF SCRIPT --------------------------------------------------------------
