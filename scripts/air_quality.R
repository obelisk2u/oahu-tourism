library(dplyr)
library(readxl)
library(tidyr)
library(ggplot2)

quality_plot <- function(){
  data <- read_excel("./data/airquality.xlsx", sheet = 1)
  data$Year <- as.Date(paste0(data$Year, "-01-01"))
  
  plot1 <- ggplot(data, aes(x = Year, y = AQIMax)) +
    geom_line(color = "blue") +         # Add a line
    geom_point(color = "blue", size = 3) +
    labs(title = "Yearly Maximum AQI: Highlighting Peaks in Air Pollution", x = "Year", y = "Maximum AQI") +
    theme_minimal()
  
  plot2 <- ggplot(data, aes(x = Year, y = Moderate)) +
    geom_line(color = "skyblue") +         # Add a line
    geom_point(color = "skyblue", size = 3) +
    labs(title = "Number of Days with Moderate AQI per Year", x = "Year", y = "Days of Moderate Rating") +
    theme_minimal()
  
  combined <- plot1 + plot2
  return(combined)
}

