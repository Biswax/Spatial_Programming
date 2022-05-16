

# Exercise 05
# Roi Schori



library(stars)
library(sf)


#___Question 1_____________________________________________________________________________________________


dem1 = read_stars("srtm_43_06.tif")
dem2 = read_stars("srtm_44_06.tif")
pol = st_read("israel_borders.shp")
dem = st_mosaic(dem1, dem2)
dem = dem[, 5687:6287, 2348:2948]
names(dem) = "elevation"
dem = st_warp(src = dem, crs = 32636, method = "near", cellsize = 90)



# Transforming Raster to points and calculating minimum distance between MAX elevation value to an NA value

point = st_as_sf(dem, as_points = TRUE, na.rm = FALSE)

na_values = point$geometry[is.na(point$elevation)]

max = point$geometry[which.max(point$elevation)]
na = na_values[which.min(st_distance(max, na_values))]



# Unifying both points in order to cast a line

union = st_union(na, max)

line = st_cast(union, "LINESTRING")



#Plotting

plot(dem, axes = TRUE, breaks = "equal", col = terrain.colors(10), reset = FALSE)
plot(max, add = TRUE)
plot(na, add = TRUE)
plot(line, col="red", add = TRUE)
text(st_coordinates(st_centroid(line)), labels = paste(round(st_length(line),2), units(st_length(line))[[1]]))





#___Question 2_____________________________________________________________________________________________



r = read_stars("MOD13A3_2000_2019.tif")
r = st_warp(r, crs = 32636)



# Defining "dates.csv" and "nafot.shp'


dates = read.csv("MOD13A3_2000_2019_dates.csv")
dates$date = as.Date(dates$date)

nafot = read_sf("nafot.shp")
nafot = st_transform(nafot, crs = 32636)



# Calculating average NDVI for each polygon in each date

NDVI = aggregate(r, nafot, mean, na.rm = TRUE)

# Changing NDVI to a data.frame with no geometry

NDVI = st_as_sf(NDVI)
NDVI = st_drop_geometry(NDVI)



# Plotting

col = rep("grey", nrow(NDVI))
col[which.max(apply(NDVI, 1, max))] = "blue"
col[which.min(apply(NDVI, 1, min))] = "red"

plot(dates$date, NDVI[1,], 
     col = NA,
     ylim = c(min(NDVI), max(NDVI)), 
     xlab = "Date", 
     ylab = "NDVI")

for(i in 1:length(col)) {
  lines(dates$date, NDVI[i, ], col = col[i], type = "l", lwd = 2)}

lines(dates$date, NDVI[which.max(apply(NDVI, 1, max)),], col = "blue", type = "l", lwd = 2)













