# Exercise 02
# Roi Schori



#___Question 1_____________________________________________________________________________________


rainfall = read.csv("rainfall.csv")


#Defining a vector for the relevant columns
m = c("sep","oct","nov","dec","jan","feb","mar","apr","may")


#Defining a new column for "rainfall" data frame and populating it with NA values,
#populating each row in the new column with a logical value by using a "for" loop 


rainfall$Anomaly=NA

for (i in 1:nrow(rainfall)) rainfall$Anomaly[i] = any(rainfall[i,m]>205)


# using the values in the new Anomaly column to retrieve and print the stations with rainfall higher than 205mm  

rainfall$name[which(rainfall$Anomaly == TRUE)]





#___Question 2_______________________________________________________________________________________

#Defining two vectors of value and time

value = c(-211.92, -212.79, -208.8, -209.52, -208.84, -209.72, -209.12, 
          -210.94, -209.01, -210.85, -209.6, -211.4, -210.24, -212.01, 
          -210.46, -212.25, -211.76, -213, -211.92, -213.71, -213.13, -214.78, 
          -213.18, -214.34, -209.74, -210.93, -208.92, -210.69, -209.73, 
          -211.64, -210.68, -212.03, -211.1, -212.6, -212.18, -214.23, 
          -213.26, -214.33, -212.65, -213.89, -212.37, -213.68)

time = rep(1991:2011, each = 2)
time = paste0(time, c("-05-15", "-11-15"))
time = as.Date(time)



#Defining vectors to help graph the data from "value" and "time" vectors

month = as.numeric(as.character(time, "%m"))
year = as.numeric(as.character(time, "%Y"))



#Plotting a graph and adding two text labels to the year 1991 and 2011

plot(
  value[month == 5], 
  value[month == 11], 
  ylim = range(value), 
  type = "b",
  xlab = "May (m)",
  ylab = "November (m)")

text(
  value[month==5 & year==1991],
  value[month==11 & year==1991], 
  label = "1991",
  pos = 3, 
  col = "red")

text(
  value[month==5 & year==2011],
  value[month==11 & year==2011], 
  label = "2011",
  pos = 3, 
  col = "red")

