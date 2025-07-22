# R Summer 2025 - Learning Exercises & Final Project

## Overview
This repository contains R programming exercises and data analysis projects completed during Summer 2025, including a comprehensive final project analyzing macroeconomic indicators and S&P 500 returns.

## Author
**Ashish Thomas** (pronounced uh-SHEESH TAH-muhs)

## Project Structure

```
R-Summer25/
├── data/
│   ├── squid.xlsx          # Original Excel dataset
│   ├── squid1.txt          # Tab-delimited version of squid data
│   └── car_values.csv      # Car sales dataset for statistical analysis
├── exercises/
│   ├── exercise-1-AThomas.R    # Basic R fundamentals
│   ├── exercise-2-AThomas.R    # Vector operations and statistics
│   ├── exercise-3-Athomas.R    # Data import and visualization
│   └── exercise-4-Athomas.R    # Custom functions and variance validation
├── output/
│   ├── DML-OvaryWeight-Scatter.png
│   ├── DML-Weight-Scatter.png
│   └── Pairs.png
├── scripts/
├── final_project.Rmd       # Final project R Markdown file
├── references.bib          # Bibliography for final project
└── README.md
```

## Final Project: Macroeconomic Indicators and S&P 500 Returns

### Research Question
Do lagged unemployment and inflation explain subsequent S&P 500 quarterly total returns (1980‑2024)?

### Data Sources
- **UNRATE**: Civilian unemployment rate (Monthly, %)
- **CPIAUCSL**: Consumer Price Index (Monthly, index)
- **^GSPC**: S&P 500 close prices (Daily, index)

All data retrieved from Federal Reserve Economic Data (FRED) API.

### Key Features
- Automated data download from FRED API
- Quarterly data aggregation and alignment
- Newey-West heteroskedasticity-corrected standard errors
- Professional visualizations and statistical analysis
- Complete reproducible workflow

### How to Run Final Project
1. Open `final_project.Rmd` in RStudio
2. Click "Knit" → "Knit to PDF"
3. The analysis will automatically download data and generate the PDF report

## Exercise Descriptions

### Exercise 1: R Fundamentals (exercise-1-AThomas.R)
**Date**: 2025-06-28  
**Focus**: Basic R syntax and operations
- Variable creation and manipulation
- Sequence generation (ascending/descending)
- Basic descriptive statistics (mean, variance, standard deviation)
- Environment management (creating and removing objects)

### Exercise 2: Vector Operations (exercise-2-AThomas.R)
**Date**: 2025-07-02  
**Focus**: Working with vectors and basic statistics
- Created weight and height vectors for 10 children
- Computed descriptive statistics (mean, variance, range, etc.)
- Data subsetting and filtering
- BMI calculations
- Vector sorting and ordering operations
- Named data manipulation

**Key Concepts Covered**:
- Vector indexing and subsetting
- Conditional filtering
- Data transformation (unit conversion)
- Ordering and sorting algorithms

### Exercise 3: Biological Data Analysis (exercise-3-Athomas.R)
**Date**: 2025-07-09  
**Focus**: Real-world data analysis with squid dataset
- **Dataset**: *Loligo forbesii* (squid) seasonal investment data
- Data import from tab-delimited files
- Data cleaning and factor recoding
- Exploratory data analysis
- Data visualization with ggplot2

**Analysis Components**:
- Seasonal patterns in somatic and reproductive tissues
- Factor conversion (year, month, maturity stages)
- Cross-tabulation analysis
- Scatter plot visualizations
- Package management and dependencies

### Exercise 4: Custom Functions & Statistical Validation (exercise-4-Athomas.R)
**Date**: 2025-07-18  
**Focus**: Function development and statistical method validation
- **Dataset**: Real-world car sales data (*car_values.csv*)
- Custom helper function development
- Tidyverse-style function implementation
- Statistical method verification and benchmarking

**Key Components**:
- **Helper Functions**:
  - `prop_missing()`: Calculate proportion of missing values
  - `prop_share()`: Compute relative proportions (0-1 scale)
  - `prop_percent()`: Convert to percentage format
  - `my_variance()`: Custom sample variance function
- **Validation Testing**: Compare custom variance function against base R `var()`
- **Real Data Application**: Analysis of car price and mileage variance
- **Automated Testing**: `stopifnot()` assertions for quality assurance

**Statistical Verification Results**:
- Price variance: ~97,710,314.86
- Mileage variance: ~67,179,656.74
- All custom functions validated against base R equivalents

## Dataset Information

### Car Sales Dataset (*car_values.csv*)
A comprehensive automotive dataset containing:
- **Price**: Vehicle sale prices (USD)
- **Mileage**: Vehicle odometer readings
- **Additional Features**: Cylinder count, doors, cruise control, sound system, leather, etc.
- **Sample Size**: 804 vehicle records
- **Purpose**: Statistical function validation and real-world data analysis

### Squid Dataset (*Loligo forbesii*)
The primary dataset contains biological measurements from squid specimens, focusing on:
- **Temporal variables**: Year and month of collection
- **Biological measurements**: Weight, length measurements
- **Reproductive data**: Maturity stages, ovary weight
- **Morphometric data**: Dorsal mantle length (DML)

**Data Files**:
- `squid.xlsx`: Original Excel format
- `squid1.txt`: Tab-delimited version for R import

## Generated Outputs

The analysis produces several visualization files:
- **DML-OvaryWeight-Scatter.png**: Relationship between dorsal mantle length and ovary weight
- **DML-Weight-Scatter.png**: Dorsal mantle length vs total weight correlation
- **Pairs.png**: Multi-variable correlation matrix visualization

## Dependencies

### Required R Packages:
- `dplyr`: Data manipulation and transformation
- `ggplot2`: Advanced data visualization  
- `tidyverse`: Comprehensive data science package collection (includes dplyr, ggplot2, readr, etc.)

The scripts include automatic package installation if packages are not already present.

## Learning Progression

1. **Weeks 1-2**: Basic R syntax, variables, and simple operations
2. **Weeks 3-4**: Vector manipulation, statistical functions, and data subsetting
3. **Weeks 5-6**: Real dataset analysis, visualization, and biological interpretation
4. **Weeks 7-8**: Custom function development, code reusability, and statistical validation

## Usage Instructions

1. Ensure R and RStudio are installed
2. Set the working directory to the project root
3. Run exercises in order (1 → 2 → 3 → 4) to follow the learning progression
4. Required packages will be automatically installed when running Exercise 3 and 4

## Key Learning Outcomes

- Fundamental R programming concepts
- Statistical data analysis workflows
- Biological data interpretation
- Data visualization best practices
- Custom function development and testing
- Statistical method validation
- Reproducible research principles

---

*This repository represents a comprehensive introduction to R programming with applications in biological data analysis.*
