## Exercise 3
## Asaf Yupiter Vanunu

library(stars)


#Q1

r = read_stars("MOD13A3_2000_2019.tif")
names(r) = "NDVI"


a=as.vector(r[[1]][,,1])


v=rep(NA,24)

for (i in 1:24) v[i]=
  cor(a,as.vector(r[[1]][,,i]),use = "pairwise.complete.obs")


plot(v, type = "b", xlab = "layer", ylab = "correlation coefficient")


#Q2

r = read_stars("MOD13A3_2000_2019.tif")
names(r) = "NDVI"



x=st_apply(r, 1:2,FUN = function(x) max(x,na.rm = TRUE)>=0.2)


y=st_apply(r, 1:2,FUN = function(x) min(x,na.rm = TRUE)<0.2)


z=st_apply(r, 1:2,FUN = function(x) mean(is.na(x))>0.2)

s=x

s[y]=0

s[x]=1

s[z]=NA

colors = c("orange","darkgreen")

plot(s, col = colors)


