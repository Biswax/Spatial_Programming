# Exercise 03
# Roi Schori


library(stars)



#___Question 1_____________________________________________________________________________________________



r = read_stars("MOD13A3_2000_2019.tif")

names(r) = "NDVI"



#**Using a loop to calculate the correlation coefficients between the layers**


#first layer, as a vector, to to used for the correlation
x = as.vector(r[[1]][,,1])


coefficients = NULL

for(i in 1:24) coefficients = c(coefficients, cor(x, as.vector(r[[1]][,,i]), use = "pairwise.complete.obs"))

coefficients



#**Plot**

plot(coefficients, 
     type = "b", 
     xlab = "layer", 
     ylab = "correlation coefficient")






#___Question 2____________________________________________________________________________________________



r = read_stars("MOD13A3_2000_2019.tif")
names(r) = "NDVI"


#single band raster s

s = r[,,,1]


#NDVI >= 0.2
s[st_apply(r, 1:2, max, na.rm = TRUE) >= 0.2] = 1

#NDVI < 0.2
s[st_apply(r, 1:2, max ,na.rm = TRUE) < 0.2] = 0

#proportion of NA values in each pixel > 0.2
s[st_apply(r, 1:2,FUN = function(x) mean(is.na(x))>0.2)] = NA


#Plot

colors = c("orange","darkgreen")

plot(s, col = colors)





















