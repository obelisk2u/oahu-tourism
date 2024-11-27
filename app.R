library(shiny)
library(reactable)
library(vroom)
library(tidyverse)
library(forcats)
library(leaflet)

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
                    leafletOutput("mymap", height = 500)  # Add leaflet map output
                    ),
                 
                 tabPanel("Tourism", 
                    h3("Welcome to Page 2"),
                    plotOutput("myplot"),
                    p("This is the content of the second page.")
                    ),
                 
                 tabPanel("Economy", 
                    h3("Welcome to Page 3"),
                    p("This is the content of the third page.")
                    )
)

# Define the server logic
server <- function(input, output) {
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.Voyager") %>%
      setView(lng = -158.024816, lat = 21.532241, zoom = 10) %>%  
      addMarkers(lng = -157.8060, lat = 21.2620, popup = "Diamondhead") %>%
      addMarkers(lng = -158.024816, lat = 21.532241, popup = "The Dole Plantation") %>%
      addMarkers(lng = -157.98024, lat = 21.35118, popup = "Pearl Harbor")
  })
  
  output$myplot <- renderPlot({
    ggplot(mtcars, aes(x = wt, y = mpg)) +
      geom_point() +
      ggtitle("Scatter Plot of MPG vs Weight")
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
