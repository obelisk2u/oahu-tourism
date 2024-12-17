library(dplyr)
library(readxl)
library(tidyr)
library(ggplot2)
library(patchwork)

plot_unemployment <- function() {
  data <- read_excel("./data/unemployment_hono.xls")
  data <- data |>
    slice(-c(1:6, 449:465)) |>
    dplyr::select(-c(2:4)) |>
    rename(Value = `...5`, Date = HONOLULU) |>
    na.omit() |>
    mutate(Value = as.numeric(Value)) |>
    mutate(Date = seq(as.Date("1990-01-01"), as.Date("2023-12-01"), by = "month"))
    
  
  monthly_oahu <- ggplot(data, aes(x = Date, y = Value)) +
    geom_line(color = "blue") +
    labs(title = "O'ahu Unemployment Rate (1990-2023)", x = "Year", y = "Unemployment Rate (%)") +
    ylim(0,20) +
    theme_minimal()
  
  
  data <- read_excel("./data/unemployment_us.xlsx")
  data <- data |>
    mutate(across(everything(), as.numeric)) |>
    slice(-c(11)) |>
    pivot_longer(
      cols = -Year,
      names_to = "month",     # Create a new column 'month' from column names
      values_to = "rate"      # Create a new column 'rate' for values
    ) |>
    mutate(Date = seq(as.Date("2014-01-01"), as.Date("2023-12-01"), by = "month"))
  
  monthly_US <- ggplot(data, aes(x = Date, y = rate)) +
    geom_line(color = "blue") +
    labs(title = "US Unemployment Rate (2014-2023)", x = "Year", y = "Unemployment Rate (%)") +
    ylim(0,20) +
    theme_minimal()
  
  graph_final <- monthly_oahu + monthly_US
  return(graph_final)
}