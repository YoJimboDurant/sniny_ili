
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


library(shiny)
library(leaflet)

shinyServer(function(input, output) {

  # build data with 2 places
  data=data.frame(x=c(130, 128), y=c(-22,-26), id=c("place1", "place2"))
  
  # create a reactive value that will store the click position
  data_of_click <- reactiveValues(clickedMarker=NULL)
  
  # Leaflet map with 2 markers
  source("./R/leaflet_1.R")
  output$map1 <- renderLeaflet({
    mymap1
  })
  
  output$map2 <- renderLeaflet({
    mymap2
  })
  
  output$map3 <- renderLeaflet({
    mymap3
  })
  
})




