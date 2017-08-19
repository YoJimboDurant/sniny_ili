library(leaflet)
# From http://leafletjs.com/examples/choropleth/us-states.js
states <- geojsonio::geojson_read("data/gz_2010_us_040_00_5m.json", what = "sp")

x <- hist(states@data$CENSUSAREA, breaks= 9)

bins <- x$breaks
pal <- colorBin("YlOrRd", domain = states$CENSUSAREA, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>",
  states$NAME, states$CENSUSAREA
) %>% lapply(htmltools::HTML)


leaflet(states) %>%
  setView(-96, 37.8, 4) %>%
  addTiles() %>%
  addPolygons(fill = TRUE, fillColor = ~pal(CENSUSAREA),
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

%>%
  addLegend(pal = pal, values = ~CENSUSAREA, opacity = 0.7, title = NULL,
            position = "bottomright")