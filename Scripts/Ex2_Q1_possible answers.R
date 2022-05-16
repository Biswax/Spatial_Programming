
rainfall = read.csv("rainfall.csv")
m = c("sep","oct","nov","dec","jan","feb","mar","apr","may")



rainfall$Anomaly=NA

for (i in 1:nrow(rainfall)) rainfall$Anomaly[i]=sum(rainfall[i,m]>205)

rainfall$name[which(rainfall$Anomaly>0)]


#or


rainfall$Anomaly=NA

for (i in 1:nrow(rainfall)) rainfall$Anomaly[i]=any(rainfall[i,m]>205)

rainfall$name[which(rainfall$Anomaly == TRUE)]


#or


result = rep(NA, nrow(rainfall))
for(i in 1:nrow(rainfall)) result[i] = any(rainfall[i,m]>205)

rainfall$name[which(result == TRUE)]


#or


rainfall$name[(apply(rainfall[,m],1, max)>205)]


