
library(readr)
library(dplyr)
library(knitr)
library(kableExtra)


salinity_data <- read_csv("Raw Salinity Data.csv")


salinity_data <- salinity_data %>%
  rename(
    Treatment = `Treatment`,
    Salinity_Start = `Salinity (Start)`,
    Salinity_End = `Salinity (End)`
  )


salinity_data %>%
  rename(
    `Salinity (Start)` = Salinity_Start,
    `Salinity (End)` = Salinity_End
  ) %>%
  kbl(caption = "Start and End Salinity by Treatment",
      digits = 1,
      align = "lcc") %>%
  kable_styling(full_width = FALSE,
                bootstrap_options = c("striped", "hover", "condensed"))

