

#**________cor on Array___________________________________________________________

## r[,,,1][[1]] is an array


r = read_stars("MOD13A3_2000_2019.tif")

names(r) = "NDVI"


#**Defining variables in order to use a loop**


#first layer, as a vector, to to used for the correlation
x = as.vector(r[[1]][,,1])


#**Using a loop to calculate the correlation coefficients between the layers**

result = NULL

for(i in 1:24) result = c(result, cor(x, r[,,,i][[1]], use = "pairwise.complete.obs"))

result


#**Plot**

plot(coefficients, 
     type = "b", 
     xlab = "layer", 
     ylab = "correlation coefficient")





#or





#**________cor on Matrix (need to define as.vector before)___________________________________________________________

## r[[1]][,,1] is a matrix


library(stars)


r = read_stars("MOD13A3_2000_2019.tif")

names(r) = "NDVI"



#**Defining variables in order to use a loop**


#first layer, as a vector, to to used for the correlation
x = as.vector(r[[1]][,,1])

# a vector of 24 NA values to be filled with the loop
result = rep(NA, 24) 



#**Using a loop to calculate the correlation coefficients between the layers**

for(i in 1:24) reault[i] = cor(x, as.vector(r[[1]][,,i]), use="pairwise.complete.obs")

result



#**Plot**

plot(coefficients, 
     type = "b", 
     xlab = "layer", 
     ylab = "correlation coefficient")




















