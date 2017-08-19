library(leaflet)
library(readxl)
library(magrittr)
library(dplyr)

# Example from http://leafletjs.com/examples/choropleth/us-states.js

states <- geojsonio::geojson_read("data/gz_2010_us_040_00_5m.json", what = "sp")

ili_data <- readxl::read_excel("./data/shiny_app_fake_data.xlsx")
state_name <- data.frame(state = state.abb, NAME = state.name)

ili_data <- inner_join(ili_data, state_name)
states@data <- merge(states@data, ili_data)

x <- hist(states@data$ratio, breaks= 5)

bins <- x$breaks
pal <- colorBin("YlOrRd", domain = states$CENSUSAREA, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>ratio: %g",
  states$NAME, states$ratio
) %>% lapply(htmltools::HTML)



mymap1 <- leaflet(states, options = leafletOptions(zoomControl = FALSE)) %>%
  setView(-96, 37.8, 4) %>%
  addTiles() %>%
  addPolygons(fill = TRUE, fillColor = ~pal(ratio),
weight = 2,
opacity = 1,
color = "white",
dashArray = "3",
fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto"))

mymap2 <- mymap1 %>%
  fitBounds(-168.915880,  49.00356, -126.444398,  71.720628) 

mymap3 <- mymap1 %>%
  fitBounds(-160.49762, 18.397377, -154.950451,   22.902383) 

mymap1 <- mymap1 %>%
  addLegend(pal = pal, values = ~ratio, opacity = 0.7, title = "Ratio",
            position = "bottomright")


