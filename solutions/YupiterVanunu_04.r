##Asaf Yupiter Vanunu - 311437461
##Exercise 4



library(maps)

library(sf)

library(units)


## Q1

nafot = st_read("nafot.shp")

##checking which nafa intersect with other nafot

x = st_intersects(nafot, nafot, sparse = FALSE)

##summing the total intersections for each nafa

y = apply(x, 1, sum)

##removing self intersection

z= y-1

##adding plot and text for each nafa

plot(st_geometry(nafot))

text(st_coordinates(st_centroid(nafot)), add=TRUE, as.character(z), col="red")

##Q2

dat=world.cities

nafot = st_read("nafot.shp")

##creating sf from the data frame

newdat = st_as_sf(dat, coords = c("long","lat"), crs = 4326)

## transforming the nafot and world cities to the same coordinates

nafot=st_transform(nafot,4326)

##substeing only cities that intersecting the nafot polygons

city=newdat[nafot,]

##creating a vector with the number of nafot

amount= c(1:length(nafot$Id))

## creating a loop wich calculate amount of cities in each nafa

for (i in amount) amount[i] = sum(st_intersects(nafot[i,],city,sparse = FALSE))

##creating number of cities for each nafa in nafot

nafot$numcities = amount

##creating new column which convert dunam to km^2

nafot$Area_square_km = nafot$Area_dunam/1000

##seting units to km^2

nafot$Area_square_km = set_units(nafot$Area_square_km, "km^2")

##claulating cities density

nafot$cities_density = nafot$numcities/nafot$Area_square_km


## ploting the outcome

plot(nafot[,"cities_density"], breaks = "equal")











