## Asaf Yupiter Vanunu Targil 2
##Q1
## loading data
data(co2)
means = aggregate(co2, FUN = mean)
year = as.vector(time(means))
co2 = as.vector(means)
## creating difference variable
## creating variables for the point and the plot range
d_co2 = c(NA, diff(co2))
new_co2 = 2.64
new_year = 2020
co2_r=c(0:3.5)
##creating plot
plot(year,d_co2,
xlim = range(year:new_year),ylim = range(co2_r),
ylab = "co2 increase (ppm)",
type = "b")
## creating point
points(new_year,new_co2, pch=4, col= "red")


##Q2
## loading data frame and m variable with month names
rainfall=read.csv("rainfall.csv")
View(rainfall)
m = c("sep","oct","nov","dec","jan","feb","mar","apr","may")

## creating empty col and inserting NA

rainfall$t=NA

## creating loop for all rows summing months that are bigger then 180 

for (i in 1:nrow(rainfall)) rainfall$t[i]=sum(rainfall[i,m]>180)

## inserting the months into the the t col from earlier

## printing the station names which one month or more has 180+ rain amount

rainfall$name[which(rainfall$t>0)]
      