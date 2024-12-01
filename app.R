library(shiny)
library(reactable)
library(vroom)
library(tidyverse)
library(forcats)
library(leaflet)

source("tourism.R")
source("unemployment.R")


#bu-rstudio-connect.bu.edu

ui <- navbarPage("O'Ahu",
   tags$style(
     HTML(
      "body {
        background-color: Azure;
        }
      .container-fluid {
        background-color: lightyellow;
        }"
      )
     ),
   
    tabPanel(
      "Map", 
      h3("Map of O'ahu"),
      p("Oahu is the third largest Hawaiian island and home to Honolulu, the state capital. It is known for its natural landmarks like Diamond Head, Waikīkī Beach, and the Koʻolau Mountain Range. The island has a mix of urban areas and places that reflect Hawaiian culture and history. Activities like snorkeling at Hanauma Bay and hiking in the Lanikai area are common ways to explore its landscape. Oahu is also significant for its role in history, particularly with sites like Pearl Harbor."),
      leafletOutput("mymap", height = 500)
      ),
       
   
   tabPanel("Tourism", 
      h3("O'Ahu Tourism"),
      p("The COVID-19 pandemic caused a significant decline in tourism on Oahu as travel restrictions and safety concerns kept visitors away. Businesses reliant on tourism, such as hotels, restaurants, and tour operators, faced financial hardships, leading to layoffs and closures. The decrease in tourism also gave the island a temporary reprieve from over-tourism, allowing some natural areas to recover from the strain of high visitor numbers."),
      plotOutput("myplot"),
      plotOutput("myplot2"),
      ),
   
   tabPanel("Unemployment", 
      h3("O'ahu Unemployment"),
      p("
The COVID-19 pandemic caused a sharp increase in unemployment on Oahu, largely due to the island's heavy reliance on tourism, which came to a standstill during the early months of the crisis. In April 2020, Oahu's unemployment rate peaked at over 20%, a drastic rise from the pre-pandemic rate of around 2%. While recovery has been gradual, sectors like hospitality and retail have struggled to regain pre-pandemic employment levels, reflecting ongoing economic challenges."),
      plotOutput("myplot3")
      )
)

# Define the server logic
server <- function(input, output) {
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.Voyager") %>%
      setView(lng = -158.024816, lat = 21.532241, zoom = 10) %>%  
      addMarkers(lng = -157.8060, lat = 21.2620, popup = "Diamond Head") %>%
      addMarkers(lng = -158.024816, lat = 21.532241, popup = "The Dole Plantation") %>%
      addMarkers(lng = -157.98024, lat = 21.35118, popup = "Pearl Harbor")
  })
  
  output$myplot <- renderPlot({tourist_plot()})
  output$myplot3 <- renderPlot({plot_unemployment()})
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
