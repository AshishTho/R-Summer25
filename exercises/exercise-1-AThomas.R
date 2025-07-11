# Author: Ashish Thomas
# Date: 2025-06-28
# Purpose: Exercise 1 – practice creating/removing variables, sequences, and basic stats.

# PART 4 – variables ---------------------------------------------------------

# Create a string variable with my name and pronunciation
who_am_i <- "Ashish Thomas pronounced uh-SHEESH TAH-muhs"

# Create numeric variables
one_hundred     <- 100
one_hundred_1   <- 101

# Sum the two numbers
sum <- one_hundred + one_hundred_1

# Remove the numeric variables created above
rm(one_hundred, one_hundred_1, sum)


# PART 5 – sequences & stats -------------------------------------------------

# a) Descending sequence from 10 to 1
sequence1 <- seq(from = 10, to = 1, by = -1)

# b) Re‑assign: ascending sequence from 1 to 5 in 0.5 steps
sequence1 <- seq(from = 1, to = 5, by = 0.5)

# c) Basic descriptive statistics
seq_mean    <- mean(sequence1)
seq_var     <- var(sequence1)
seq_sd      <- sd(sequence1)
seq_length  <- length(sequence1)

# d) Results (for your reference)
# Mean              : 3
# Variance (sample) : 1.875
# Standard deviation: 1.369306
# Length            : 9


# PART 6 – list objects ------------------------------------------------------

# List all objects currently in the Environment
ls()

# END OF SCRIPT --------------------------------------------------------------
