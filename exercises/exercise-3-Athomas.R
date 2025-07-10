# exercise-3-Athomas.R
# Title: Seasonal investment in somatic and reproductive tissues – Loligo forbesii
# Description: Reads, cleans, explores and visualises the squid dataset for Exercise 3.
# Author: A. Thomas
# Date created: 2025‑07‑09
# ------------------------------------------------------------------------------

# --------- Workspace set‑up ----------------------------------------------------
rm(list = ls())        # Start with a clean slate

# Load (and install if necessary) packages
req_pkgs <- c("dplyr", "ggplot2")
new_pkgs <- req_pkgs[!(req_pkgs %in% rownames(installed.packages()))]
if (length(new_pkgs)) install.packages(new_pkgs)

lapply(req_pkgs, library, character.only = TRUE)

# --------- Data import ---------------------------------------------------------
# Assumes project structure:
# ├── data/squid1.txt   (tab‑delimited file you saved from Excel)
# └── output/           (directory for saved graphics)

data_path <- "data/squid1.txt"
squid <- read.table(data_path, header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Quick look at the raw data
str(squid)
summary(squid)
cat("\nRows :", nrow(squid), "\nCols :", ncol(squid), "\n")

# --------- Recode integers as factors -----------------------------------------
squid <- squid %>%
  mutate(
    Fyear     = factor(year),
    Fmonth    = factor(month,
                       levels = 1:12,
                       labels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                                  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")),
    Fmaturity = factor(maturity.stage,
                       levels = 1:5,
                       labels = c("1 Immature", "2 Early", "3 Developing",
                                  "4 Late", "5 Mature"))
  )

str(squid[, c("Fyear", "Fmonth", "Fmaturity")])

# --------- How many observations per year × month? ----------------------------
ym_table <- table(squid$Fyear, squid$Fmonth)
print(ym_table)

# --------- Correct the nid.length typo ----------------------------------------
wrong_idx <- which(squid$nid.length > 400)   # should return 11
cat("\nIndex with nid.length > 400:", wrong_idx, "\n")
cat("Value before fix:", squid$nid.length[wrong_idx], "\n")

# Replace 430.2 with 43.2
squid$nid.length[wrong_idx] <- 43.2
cat("Value after  fix:", squid$nid.length[wrong_idx], "\n")

# --------- Create output directory if it’s missing ----------------------------
if (!dir.exists("output")) dir.create("output")

# --------- Figure 1 : DML vs total weight -------------------------------------
png("output/DML-Weight-Scatter.png", width = 1800, height = 1200, res = 300)
plot(weight ~ DML, data = squid,
     pch = 20, cex = 0.7,
     xlab = "Dorsal mantle length (mm)",
     ylab = "Total weight (g)",
     main = "Relationship between DML and Weight")
abline(lm(weight ~ DML, data = squid), lwd = 2, lty = 2)
dev.off()

# --------- Figure 2 : pairs plot ---------------------------------------------
vars <- c("DML", "weight", "eviscerate.weight", "ovary.weight",
          "nid.length", "nid.weight")
png("output/Pairs.png", width = 2000, height = 2000, res = 300)
pairs(squid[vars], pch = 20, cex = 0.6)
dev.off()

# --------- Figure 3 : ggplot DML vs sqrt(ovary weight) ------------------------
plt3 <- ggplot(squid, aes(x = DML, y = sqrt(ovary.weight), colour = Fmaturity)) +
  geom_point(size = 2) +
  labs(x = "Dorsal mantle length (mm)",
       y = expression(sqrt("Ovary weight (g)")),
       colour = "Stage of Maturity") +
  theme_classic()

ggsave("output/DML-OvaryWeight-Scatter.png", plt3,
       width = 6, height = 4, dpi = 300)

# --------- End ----------------------------------------------------------------