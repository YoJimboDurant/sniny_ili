
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)


shinyUI(fluidPage(
  
    br(),
    column(4,leafletOutput("map2", height="300px"),
           br(),
    leafletOutput("map3", height="300px")),

    column(8, leafletOutput("map1", height="620px")),
    br()
    
    
  ))
