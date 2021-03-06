
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


library(shiny)
library(leaflet)

shinyServer(function(input, output) {
  

  RV <- reactiveValues(Clicks=list())




  # Leaflet map with 2 markers
  source("./R/leaflet_1.R")

  output$map <- renderLeaflet({
    mymap1
  })
  
  output$map2 <- renderLeaflet({
    mymap2
  })
  
  output$map3 <- renderLeaflet({
    mymap3
  })
  
  

  
  observeEvent(input$map_shape_click, {
    
    #create object for clicked polygon
    click <- input$map_shape_click

    if(gsub("x$", "", click$id) %in% RV$Clicks){
      leafletProxy("map") %>% removeShape(as.character(click$id))
      leafletProxy("map2") %>% removeShape(as.character(click$id))
      leafletProxy("map3") %>% removeShape(as.character(click$id))
      
      RV$Clicks <- RV$Clicks[!RV$Clicks %in% gsub("x$", "", click$id)]
      

         }else{
           RV$Clicks<-c(RV$Clicks,click$id)
         
    
      leafletProxy("map") %>%
      addPolygons(layerId = paste0(as.character(click$id),"x"), data = subset(states, NAME == click$id), 
                  stroke = T, fillOpacity = 0.5,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
      
      leafletProxy("map2") %>%
        addPolygons(layerId = paste0(as.character(click$id),"x"), data = subset(states, NAME == click$id), 
                    stroke = T, fillOpacity = 0.5,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
      
      leafletProxy("map3") %>%
        addPolygons(layerId = paste0(as.character(click$id),"x"), data = subset(states, NAME == click$id), 
                    stroke = T, fillOpacity = 0.5,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
    
    
         }
    

  }) #END OBSERVE EVENT
  
  observeEvent(input$map2_shape_click, {
    #create object for clicked polygon
    click <- input$map2_shape_click
    
    if(gsub("x$", "", click$id) %in% RV$Clicks){
      leafletProxy("map") %>% removeShape(as.character(click$id))
      leafletProxy("map2") %>% removeShape(as.character(click$id))
      leafletProxy("map3") %>% removeShape(as.character(click$id))
      
      RV$Clicks <- RV$Clicks[!RV$Clicks %in% gsub("x$", "", click$id)]
      
      
    }else{
      RV$Clicks<-c(RV$Clicks,click$id)
      
      
      leafletProxy("map") %>%
        addPolygons(layerId = paste0(as.character(click$id),"x"), data = subset(states, NAME == click$id), 
                    stroke = T, fillOpacity = 0.5,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
      
      leafletProxy("map2") %>%
        addPolygons(layerId = paste0(as.character(click$id),"x"), data = subset(states, NAME == click$id), 
                    stroke = T, fillOpacity = 0.5,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
      
      leafletProxy("map3") %>%
        addPolygons(layerId = paste0(as.character(click$id),"x"), data = subset(states, NAME == click$id), 
                    stroke = T, fillOpacity = 0.5,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
      
      
    }

  }) #END OBSERVE EVENT
  
  observeEvent(input$map3_shape_click, {
    
    #create object for clicked polygon
    click <- input$map3_shape_click
    
    if(gsub("x$", "", click$id) %in% RV$Clicks){
      leafletProxy("map") %>% removeShape(as.character(click$id))
      leafletProxy("map2") %>% removeShape(as.character(click$id))
      leafletProxy("map3") %>% removeShape(as.character(click$id))
      
      RV$Clicks <- RV$Clicks[!RV$Clicks %in% gsub("x$", "", click$id)]
      
      
    }else{
      RV$Clicks<-c(RV$Clicks,click$id)
      
      
      leafletProxy("map") %>%
        addPolygons(layerId = paste0(as.character(click$id),"x"), data = subset(states, NAME == click$id), 
                    stroke = T, fillOpacity = 0.5,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
      
      leafletProxy("map2") %>%
        addPolygons(layerId = paste0(as.character(click$id),"x"), data = subset(states, NAME == click$id), 
                    stroke = T, fillOpacity = 0.5,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
      
      leafletProxy("map3") %>%
        addPolygons(layerId = paste0(as.character(click$id),"x"), data = subset(states, NAME == click$id), 
                    stroke = T, fillOpacity = 0.5,highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
      
      
    }
    
    
  }) #END OBSERVE EVENT
  
  output$plot_ed = renderPlot({
    x <- makeRateBar(unlist(RV$Clicks))
    if(dim(x)[1]>0) {
    barplot(x$`E.D. Rate`, horiz = TRUE, names = x$State, las=1,
            main= "Emergency Dept.", xlim=c(0,1),
            col="#0039A6")
    }
  })
  
  output$plot_uc = renderPlot({
    x <- makeRateBar(unlist(RV$Clicks))
    if(dim(x)[1]>0) {
    barplot(x$`U.C. Rate`, horiz = TRUE, names = x$State, las=1,
            main= "Urgent Care", xlim=c(0,1),
            col="#4971F2")
    }
  })
  
  
  output$plot_or = renderPlot({
    x <- makeRateBar(unlist(RV$Clicks))
    if(dim(x)[1]>0) {
    barplot(x$`Outpatient Rate`, horiz = TRUE, names = x$State, las=1,
            main= "Outpatient Care", xlim=c(0,1),
            col = "#007D57")
    }
  })
  
  
  output$plot_ratio = renderPlot({
    x <- makeRateBar(unlist(RV$Clicks))
    if(dim(x)[1]>0) {
      barplot(x$Ratio, horiz = TRUE, names = x$State, las=1,
            main= "Ratio", xlim=c(0,1),
            col = "#9A3B26")
    }
  })
  


})




