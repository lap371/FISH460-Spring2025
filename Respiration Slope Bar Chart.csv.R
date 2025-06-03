

library(readr)
library(dplyr)
library(ggplot2)


Raw_Crab_Data <- read_csv("Data for Respiration Slope Bar Chart.csv")


Raw_Crab_Data <- Raw_Crab_Data %>%
  rename(
    CrabID = `Crab ID`,
    Time_min = Time,
    RFU_wt = `RFU/ Weight (g)`  
  )


slopes <- Raw_Crab_Data %>%
  group_by(Treatment, CrabID, Week) %>%
  summarise(
    slope = coef(lm(RFU_wt ~ Time_min))[2],
    .groups = "drop"
  )


summary_stats <- slopes %>%
  group_by(Treatment) %>%
  summarise(
    mean_slope = mean(slope),
    sd_slope = sd(slope),
    n = n()
  )


set.seed(42)  
ggplot() +
  geom_bar(data = summary_stats,
           aes(x = Treatment, y = mean_slope),
           stat = "identity",
           fill = "lightblue",
           alpha = 0.7) +
  geom_errorbar(data = summary_stats,
                aes(x = Treatment,
                    ymin = mean_slope - sd_slope,
                    ymax = mean_slope + sd_slope),
                width = 0.2) +
  geom_jitter(data = slopes,
              aes(x = Treatment, y = slope),
              width = 0.1,
              height = 0.1,
              color = "darkblue",
              size = 2.5) +
  labs(
    title = "Crab Respiration Rates by Treatment",
    y = "Respiration slope (RFU/g/min)",
    x = "Treatment"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

