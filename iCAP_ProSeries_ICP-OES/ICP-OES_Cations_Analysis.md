ICP-OES_Cations_Analysis
================
Tianyin Ouyang
2026-07-08

## Install and Load All Required Packages

``` r
if (!require("XML")) install.packages("XML")
if (!require("dplyr")) install.packages("dplyr")
if (!require("writexl")) install.packages("writexl")

library(dplyr)
library(XML)
library(writexl)
source("https://raw.githubusercontent.com/touyang98/General-Data-Analysis-Codes/main/iCAP_ProSeries_ICP-OES/ICP-OES_Functions.R")
```

## Read data files from local computer

``` r
path <- "Test_Data_Ouyang.xml" ##replace with your file path

data_raw <- read_xml(path = path)
```

## Extra instrumental signal data

The extract_inst function is written to clean the spreadsheet and
extract instrumental signals of all analyzed elements from the raw data.

``` r
data_ins <- extract_inst(data = data_raw)
```

## Identify elements, construct calibration curve, and evalute concentrations individually

The extract_ion function is written to extract the interested element
from the raw data. The cal_curve is written to construct the calibration
curve of interested element. The sample_conc is written to calculate the
concentration of interested element in samples based on the calibration
curve and entered dilution fatcor.

``` r
## extract dataset that contain interested element individually 
ion <- "Ca"
data_Ca <- extract_ion(ion = ion, data = data_ins)

## construct the calibration curve individually 
std_row <- c(2:8) ## monitor the standard inputs for the best calibration curve
fit <- cal_curve(data = data_Ca, std_row = std_row, iFR_col = 2)## There are radical or axial iFR columns, choose one for analyses
```

    ## Warning in cal_curve(data = data_Ca, std_row = std_row, iFR_col = 2): NAs
    ## introduced by coercion

``` r
summary(fit)
```

    ## 
    ## Call:
    ## lm(formula = cal[, 2] ~ cal[, 1])
    ## 
    ## Residuals:
    ##     2     3     4     5     6     7 
    ## -4589  8797  2119 -1810 -2164 -2353 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)   2473.4     2718.3    0.91    0.414    
    ## cal[, 1]     61803.3      593.1  104.19 5.09e-08 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 5395 on 4 degrees of freedom
    ##   (1 observation deleted due to missingness)
    ## Multiple R-squared:  0.9996, Adjusted R-squared:  0.9995 
    ## F-statistic: 1.086e+04 on 1 and 4 DF,  p-value: 5.087e-08

``` r
## evaluate concentrations 
dilution_factor <- 200
data_Ca$conc <- sample_conc(fit = fit, dilution_factor = dilution_factor, data = data_Ca, iFR_col = 2)
```

## Calculate concentrations of all elements

The analyze_list function is written specifically to Pain Lab protocol,
which can simutaneously calculate the concentration of 26 elements
analyzed by Pain’s ICP-OES instrument.

``` r
data_analyzed <- analyze_list(data = data_ins, dilution_factor = 200)
```

## Export the data to local computer

``` r
path <- "Local_File_Path" ##replace with your local file path
name <- "Your_File_Name.xlsx" ##replace with whatever you would like to name your file

path_xlsx <- paste0(path, "/", name)
write_xlsx(data_analyzed, path = path_xlsx)
```
