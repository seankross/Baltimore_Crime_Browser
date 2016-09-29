
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
library(leaflet)
library(ggplot2)

shinyServer(function(input, output) {
  filtered_crime <- reactive({
    input$date1
    
    isolate({
      crime %>%
        filter(CrimeDate >= input$date1[1]) %>%
        filter(CrimeDate <= input$date1[2])
    })
  })
  
  output$crime_map <- renderLeaflet({
    filtered_crime() %>%
      leaflet() %>%
      setView(lng = "-76.6204859", lat = "39.2847064", zoom = 12) %>%
      addTiles() %>%
      addMarkers(clusterOptions = markerClusterOptions())
  })
  
  output$daily_plot <- renderPlot({
    daily_crime <- filtered_crime() %>%
      group_by(CrimeDate) %>%
      summarize(Crimes_Per_Day = n())
    
    ggplot(daily_crime, aes(CrimeDate, Crimes_Per_Day)) + geom_line()
  })
})
