# Exercise 04
# Roi Schori


library(sf)
library(units)
library(maps)



#___Question 1_____________________________________________________________________________________________



nafot = st_read("nafot.shp")



# Creating a logical matrix of Intersections between Nafot

x = st_intersects(nafot, nafot, sparse = FALSE)



# summing intersections for each Nafa (not including self) into a vector 

y = apply(x, 1, sum) -1



# Plotting 


plot(st_geometry(nafot))

text(st_coordinates(st_centroid(nafot)), as.character(y), col="red")





#___Question 2_____________________________________________________________________________________________



nafot = st_read("nafot.shp")
head(world.cities)




##**_______Subseting cities that intersect with "nafot" polygons**



# creating a vector layer from "World.cities" and transforming "nafot" to the same coordinate system (WGS84)

cities = st_as_sf(world.cities, coords = c("long","lat"), crs = 4326)

nafot = st_transform(nafot, 4326)



# subseting cities that intersect with nafot

cities1 = cities[nafot, ]





##**_______Calculating cities density per Nafa**



# creating a new column using a loop that calculates the amount of cities per Nafa

nafot$City_count = NA

for (i in 1:nrow(nafot)) nafot$City_count[i] = sum(st_intersects(nafot[i,], cities1, sparse = FALSE))


# creating new column with the area in Km^2

nafot$Area_Km_sqrd = set_units(nafot$Area_dunam/1000, "km^2")


# calculating density of cities per Nafa

nafot$Cities_density = nafot$City_count/nafot$Area_Km_sqrd





##**_______Plotting**

plot(nafot[,"Cities_density"], breaks = "equal")











































