# package check
packs <- c("leaflet", "readxl", "magrittr", "dplyr", "geojsonio")
packs <- packs[!packs %in% rownames(installed.packages())]
if(length(packs) > 0 ) sapply(packs, install.packages)

library(leaflet)
library(readxl)
library(magrittr)
library(dplyr)


# load states shape file
states <- geojsonio::geojson_read("data/gz_2010_us_040_00_5m.json", what = "sp")

# load data and merge key
ili_data <- readxl::read_excel("./data/shiny_app_fake_data.xlsx")
state_name <- data.frame(state = state.abb, NAME = state.name)
ili_data <- inner_join(ili_data, state_name)

# use sp::merge to merge spatial object data will create NA for Puerto Rico and 
# Washington DC
states <- sp::merge(states, ili_data, by.x="NAME", by.y ="NAME")

# color breaks using a histogram
x <- hist(states@data$ratio, breaks= 5)
bins <- x$breaks
pal <- colorBin("PuBu", domain = states$CENSUSAREA, bins = bins)

# labels in html for hovering
labels <- sprintf(
  "<strong>%s</strong><br/>ratio: %g",
  states$NAME, states$ratio
) %>% lapply(htmltools::HTML)


# I create 1 map, then use it to zoom panels for Alaska and Hawaii

mymap1 <- leaflet(states, options = leafletOptions(zoomControl = FALSE)) %>%
  setView(-96, 37.8, 4) %>%
  addTiles() %>%
  addPolygons(fill = TRUE, fillColor = ~pal(ratio),
              layerId = states@data$NAME,
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

# may want to add zoom of northeast? Puerto Rico? DC?


# barplot by state selected function --------------------------------------

makeRateBar <- function(clicked_states = c("Wyoming", "Montana", "Alaska")){
  dfx <- filter(ili_data, NAME %in% clicked_states) %>%
    select(State = state, `E.D. Rate` = ed, `U.C. Rate` = uc, 
           `Outpatient Rate` = outpatient, Ratio=ratio)
  dfx[order(dfx$State, decreasing = TRUE),]

}

