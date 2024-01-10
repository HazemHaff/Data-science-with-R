# Load the necessary library
library(leaflet)

# 1. Basic Map Creation
basic_map <- leaflet() %>% 
  addTiles()

# 2. Adding a Single Marker
single_marker_map <- basic_map %>%
  addMarkers(lng = -76.6122, lat = 39.2904, popup = "Baltimore")

# 3. Adding Multiple Markers from a Data Frame
locations <- data.frame(
  lng = c(-76.6122, -76.7115),
  lat = c(39.2904, 39.4143),
  label = c("Baltimore", "Towson")
)
multiple_markers_map <- basic_map %>%
  addMarkers(data = locations, ~lng, ~lat, popup = ~label)

# 4. Customizing Markers
custom_icon <- makeIcon(
  iconUrl = "https://example.com/icon.png",
  iconWidth = 25, iconHeight = 41
)
custom_markers_map <- basic_map %>%
  addMarkers(data = locations, ~lng, ~lat, icon = custom_icon, popup = ~label)

# 5. Implementing Marker Clustering
clustered_markers_map <- basic_map %>%
  addMarkers(data = locations, ~lng, ~lat, clusterOptions = markerClusterOptions())

# 6. Adding Circles and Rectangles
shapes_map <- basic_map %>%
  addCircles(lng = -76.6122, lat = 39.2904, radius = 500, color = "red") %>%
  addRectangles(
    lng1 = -76.7115, lat1 = 39.4143,
    lng2 = -76.7015, lat2 = 39.4243,
    color = "blue"
  )

# 7. Data-Driven Map with Varying Circle Sizes
cities <- data.frame(
  lng = c(-76.6122, -77.2089),
  lat = c(39.2904, 39.0836),
  population = c(600000, 120000)
)
population_map <- leaflet(cities) %>%
  addTiles() %>%
  addCircles(~lng, ~lat, radius = ~population / 10)

# 8. Adding a Legend
legend_map <- basic_map %>%
  addCircles(
    data = cities,
    ~lng, ~lat,
    color = c("red", "blue"),
    radius = 500
  ) %>%
  addLegend(
    position = "bottomright",
    colors = c("red", "blue"),
    labels = c("Large City", "Small City"),
    title = "City Sizes"
  )

# Render the map of your choice by running its variable name in the R console.
# For example, to view the map with varying circle sizes, run: population_map
clustered_markers_map


