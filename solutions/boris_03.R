# Exercise 03
#Amit Boris

library(stars)

# Question 01

r = read_stars("MOD13A3_2000_2019.tif")

result = NULL
for(i in 1:24) result = c(result, cor(r[,,,1][[1]], r[,,,i][[1]], use = "pairwise.complete.obs"))
result

plot(1:24, result,type = "b", ylab = "Correlation Coefficient", xlab = "Layer")


# Question 02

r = read_stars("MOD13A3_2000_2019.tif")

max2 = function(x) if(all(is.na(x))) NA else max(x, na.rm = TRUE)

r_na = st_apply(r, 1:2, function(x) mean(is.na(x)))
r_max = st_apply(r, 1:2, max2)

r_rec = r_max
r_rec[r_max <= 0.2] = 0
r_rec[r_max > 0.2] = 1
r_rec[r_na > 0.2] = NA
names(r_rec) = "NDVI"
plot(r_rec, col = c("orange","darkgreen"))
