library(dplyr)
library(readxl)
library(tidyr)
library(ggplot2)
library(patchwork)

plot_unemployment <- function() {
  data <- read_excel("./data/unemployment_hono.xls")
  data <- data |>
    slice(-c(1:6, 449:465)) |>
    select(-c(2:4)) |>
    rename(Value = `...5`, Date = HONOLULU) |>
    na.omit() |>
    mutate(Value = as.numeric(Value)) |>
    mutate(Date = seq(as.Date("1990-01-01"), as.Date("2023-12-01"), by = "month"))
  
  monthly <- ggplot(data, aes(x = Date, y = Value)) +
    geom_line(color = "blue") +
    labs(title = "O'ahu Unemployment Rate (1990-2023)", x = "Year", y = "Unemployment Rate (%)") +
    ylim(0,20) +
    theme_minimal()
  
  return(monthly)
}