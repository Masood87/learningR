x <- 1:400
y <- sin(x/10) * exp(x*-.01)
plot(x,y)
#### ### ## # ## ## ## # ## ### ####
#### ## # # Spatial Data # # ## ####
#### ### ## # ## ## ## # ## ### ####
library(ggmap)
# There are two steps to adding a map to a ggplot2 plot with ggmap:
#1 Download a map using get_map()
#2 Display the map using ggmap()
# As an example, let's grab a map for New York City:
kabul <- c(lon = 69.1363, lat = 34.5191)
places <- data.frame(lon = c(69.155563,69.1363,69.0522,69.1200,69.1580,69.1194,69.1905), lat = c(34.509648,34.5191,34.4969,34.4670,34.5030,34.4653,34.5180), place = c("university","zoo","university","historical","leisure","historical","historical"))
kabul_map <- get_map(kabul, zoom = 12, scale = 1, source = "google", maptype = "terrain") #try: source = "stamen", maptype = "toner"
# The most important argument is the first, location, where you can provide a longitude and latitude pair of coordinates where you want the map centered. (We found these for NYC from a quick google search of "coordinates nyc".) The next argument, zoom, takes an integer between 3 and 21 and controls how far the mapped is zoomed in. In this exercise, you'll set a third argument, scale, equal to 1. This controls the resolution of the downloaded maps and you'll set it lower (the default is 2) to reduce how long it takes for the downloads.
ggmap(kabul_map)
# Similar to ggplot(), you can add layers of data to a ggmap() call (e.g. + geom_point()). It's important to note, however, that ggmap() sets the map as the default dataset and also sets the default aesthetic mappings.
# This means that if you want to add a layer from something other than the map (e.g. sales), you need to explicitly specify both the mapping and data arguments to the geom.
ggmap(kabul_map, base_layer = ggplot(places, aes(lon, lat, col = place))) + geom_point() #or ggmap(kabul_map) + geom_point(aes(lon, lat, col = place), data = places)
# ggmap also provides a quick alternative to ggmap(). Like qplot() in ggplot2, qmplot() is less flexible than a full specification, but often involves significantly less typing. qmplot() replaces both steps -- downloading the map and displaying the map -- and its syntax is a blend between qplot(), get_map(), and ggmap().
qmplot(lon, lat, data = places, geom = "point", color = place)

#Types of spatial data: point, line, polygon, raster (you have a variable measured at every location in a regular grid)
#Drawing polygons
# A choropleth map describes a map where polygons are colored according to some variable. In the ward_sales data frame, you have information on the house sales summarised to the ward level. Your goal is to create a map where each ward is colored by one of your summaries: the number of sales or the average sales price.
# In the data frame, each row describes one point on the boundary of a ward. The lon and lat variables describe its location and ward describes which ward it belongs to, but what are group and order?
# Remember the two tricky things about polygons? An area may be described by more than one polygon and order matters. group is an identifier for a single polygon, but a ward may be composed of more than one polygon, so you would see more than one value of group for such a ward. order describes the order in which the points should be drawn to create the correct shapes.
# In ggplot2, polygons are drawn with geom_polygon(). Each row of your data is one point on the boundary and points are joined up in the order in which they appear in the data frame. You specify which variables describe position using the x and y aesthetics and which points belong to a single polygon using the group aesthetic.
# Add a geom_point() layer with the color aesthetic mapped to ward. How many wards are in Corvallis? 
ggplot(ward_sales, aes(lon, lat)) + geom_point(aes(color = ward))
# Add a geom_point() layer with the color aesthetic mapped to group. Can you see some wards that are described by more than one polygon?
ggplot(ward_sales, aes(lon, lat)) + geom_point(aes(color = group))
# Add a geom_path() layer with the group aesthetic mapped to group. See how points in the same group are joined.
ggplot(ward_sales, aes(lon, lat)) + geom_path(aes(group = group))
# Finally, add a geom_polygon() layer with the fill aesthetic mapped to ward and the group aesthetic mapped to group.
ggplot(ward_sales, aes(lon, lat)) + geom_polygon(aes(fill = ward, group = group))
# Now that you understand drawing polygons, let's get your polygons on a map. Remember, you replace your ggplot() call with a ggmap() call and the original ggplot() call moves to the base_layer() argument, then you add your polygon layer as usual:
# Arguments extent = "normal" along with maprange = FALSE force the plot to use the data range rather than the map range to define the plotting boundaries.
ggmap(corvallis_map_bw, base_layer = ggplot(ward_sales, aes(lon, lat)), extent = "normal", maprange = FALSE) + geom_polygon(aes(group = group, fill = ward))
# or with qmplot:
qmplot(lon, lat, data = ward_sales, geom = "polygon", group = group, fill = avg_price)
