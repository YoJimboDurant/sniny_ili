
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)


shinyUI(fluidPage(
  
    br(),
    column(8,leafletOutput("map", height="600px")),
    column(4,br(),br(),br(),br(),plotOutput("plot", height="300px")),
    br()
  ))
