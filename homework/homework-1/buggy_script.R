library(tidyverse)

world_data <- read.csv("homework-world.csv")

world_summary <- world_data %>%
  filter(World = 1 | World == 2) %>%
  group_by(World) %>%
  summarize(
    n_countries = n(),
    avg_happiness = mean(Happiness, na.rm = TRUE),
    avg_gdp = mean(GDP, na.rm = TRUE),
    avg_support = mean(Suport, na.rm = TRUE),
    sd_happiness = sd(Happiness, na.rm = TRUE)
  )

happiness_categories <- world_data %>%
  mutate(
    happiness_level = case_when(
      Happiness >= 7 ~ "High",
      Happiness >= 5 ~ "Medium",
      Happiness < 5 ~ "Low"
    )
  )

category_counts <- table(happiness_categories$happiness_level)

wealth_perception <- world_data %>%
  mutate(
    gdp_tercile = ntile(GDP, 3),
    corruption_tercile = ntile(Corruption, 3)
  ) %>%
  group_by(gdp_tercile, corruption_tercile) %>%
  summarize(
    mean_freedom = mean(Freedom, na.rm = TRUE),
    mean_life = mean(Life, na.rm = TRUE),
    .groups = "drop"
  )

high_gdp_countries <- world_data %>%
  filter(GDP > quantile(GDP, 0.75, na.rm = TRUE)) %>%
  arrange(desc(Happiness)) %>%
  select(Country, Happiness, GDP, Freedom, Corruption)

top_countries <- head(high_gdp_countries, 15)

overall_stats <- data.frame(
  variable = c("Happiness", "GDP", "Support", "Life", "Freedom", "Generosity"),
  mean = c(
    mean(world_data$Happiness, na.rm = TRUE),
    mean(world_data$GDP, na.rm = TRUE),
    mean(world_data$Support, na.rm = TRUE),
    mean(world_data$Life, na.rm = TRUE),
    mean(world_data$Freedom, na.rm = TRUE),
    mean(world_data$Generosity, na.rm = TRUE)
  ),
  median = c(
    median(world_data$Happiness, na.rm = TRUE),
    median(world_data$GDP, na.rm = TRUE),
    median(world_data$Support, na.rm = TRUE),
    median(world_data$Life, na.rm = TRUE),
    median(world_data$Freedom, na.rm = TRUE),
    median(world_data$Generosity, na.rm = TRUE)
  ),
  sd = c(
    sd(world_data$Happiness, na.rm = TRUE),
    sd(world_data$GDP, na.rm = TRUE),
    sd(world_data$Support, na.rm = TRUE),
    sd(world_data$Life, na.rm = TRUE),
    sd(world_data$Freedom, na.rm = TRUE),
    sd(world_data$Generosity)
  )
)

print(world_summary)
print(category_counts)
print(wealth_perception)
print(top_countries)
print(overall_stats)
