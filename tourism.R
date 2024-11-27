library(dplyr)
library(readxl)
library(tidyr)
library(ggplot2)
library(patchwork)

tourist_plot <- function(x){
  #years interested
  years <- 2021:2014
  years <- years[!years %in% c(2017)]
  
  #manually do 2023 because its the only xlsx and I'm lazy
  path <- "./data/2023-tourism.xlsx"
  temp_data <- read_excel(path)
  val_vec <- temp_data[12,3:14]
  df <- as.data.frame(val_vec)
  colnames(df) <- month.name
  
  #read years 2021-2014
  for (year in years) {
    path <- paste0("./data/", as.character(year),"-tourism.xls")
    temp_year_data <- read_excel(path)
    temp <- temp_year_data[12,3:14]
    val_vec <- c(val_vec, temp)
    bymonth <- as.data.frame(temp)
    colnames(bymonth) <- month.name
    df <- rbind(df, bymonth)
  }
  
  years <- 2013:2008
  
  #read years 2013-2008
  for (year in years) {
    path <- paste0("./data/", as.character(year),"-tourism.xls")
    temp_year_data <- read_excel(path)
    temp <- temp_year_data[12,2:13]
    bymonth <- as.data.frame(temp)
    val_vec <- c(val_vec, temp)
    colnames(bymonth) <- month.name
    df <- rbind(df, bymonth)
  }
  df <- na.omit(df)
  df <- as.data.frame(sapply(df, as.integer))
  
  years <- 2023:2008
  years <- years[!years %in% c(2017, 2022)]
  df <- cbind(years, df)
  
  df_longer <- pivot_longer(df, cols = month.name, names_to = "Month", values_to = "Value")
  df_longer$Month <- factor(df_longer$Month, levels = month.name)
  
  if(x == 0){
    every_month <- ggplot(df_longer, aes(x = Month, y = Value, group = years, color = as.factor(years))) +
      geom_line() +
      geom_point() +
      scale_y_continuous() +
      labs(x = "Month", y = "Value", title = "O'ahu Visitors Monthly by Year", color = "Year") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    return(every_month)
  }else if(x == 1){
    df_july <- df_longer |> filter(Month == "July")

    july_plot <- ggplot(df_july, aes(x = years, y = Value)) +
      geom_line() +
      geom_point() +
      labs(x = "Year", y = "O'ahu Visitors", title = "July Time Series Over Years") +
      theme_minimal()
    return(july_plot)
  }
}

