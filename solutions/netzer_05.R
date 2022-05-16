
# Exercise 05
# Roi Netzer
# setwd("C:\\Users\\netze\\OneDrive\\Documents\\RWDPC\\data")

# Question 1 --------------------------------------------------------------

library(stars)
dem1 = read_stars("srtm_43_06.tif")
dem2 = read_stars("srtm_44_06.tif")
pol = st_read("israel_borders.shp")
dem = st_mosaic(dem1, dem2)
dem = dem[, 5687:6287, 2348:2948]
names(dem) = "elevation"
dem = st_warp(src = dem, crs = 32636, method = "near", cellsize = 90)

plot(dem, breaks = "equal", col = terrain.colors(10), axes = TRUE,  key.pos = 1, reset = FALSE)



p = st_as_sf(dem, as_points = TRUE, na.rm = FALSE)

max_e = p$geometry[which.max(p$elevation)]

plot(max_e, add = TRUE)

na_p = p$geometry[is.na(p$elevation)]

min_d = na_p[which.min(st_distance(max_e, na_p))]

plot(min_d, add = TRUE)



# Unifying to multypolygon object
mp = st_union(min_d, max_e)
# Casting to linestring
ls = st_cast(mp, "LINESTRING")
plot(ls, add = TRUE)
text(st_coordinates(st_centroid(ls)), labels = paste(round(st_length(ls),2), units(st_length(ls))[[1]]))




# Question 2 --------------------------------------------------------------

r = read_stars("MOD13A3_2000_2019.tif")
r = st_warp(r, crs = 32636)

dates = read.csv("MOD13A3_2000_2019_dates2.csv")
dates$date = as.Date(dates$date)

nafot = read_sf("nafot.shp")
nafot = st_transform(nafot, crs = 32636)


a_r_nafot = st_as_sf(aggregate(r, nafot, mean, na.rm = TRUE))
a_r_nafot = t(st_drop_geometry((a_r_nafot)))


plot(dates$date, a_r_nafot[,1], ylim = c(min(a_r_nafot), max(a_r_nafot)), col = NA, xlab = "Date", ylab = "NDVI")
col = rep("grey", length(colnames(a_r_nafot)))
col[which.max(apply(a_r_nafot, 2, max))] = "blue"
col[which.min(apply(a_r_nafot, 2, min))] = "red"
for(i in 1:length(col)) {
  lines(dates$date, a_r_nafot[,i], col = col[i], type = "l")
}

