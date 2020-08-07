#Establish a Connection to database

install.packages("RMySQL")
library(RMySQL)
mydb <- dbConnect(MySQL(), user='g1109698', password='SEVERELY26', dbname='g1109698', host='mydb.itap.purdue.edu')

#sending a csv file to database
#Krakow data

sensor_location_krakow <- data.frame(read.csv("/www/Map/files/sensors.csv"))
sensors <- data.frame(sensor_location_krakow)
colnames(sensors) <- c("Name","Type","S_ID")
dbWriteTable(mydb, "Sensors", sensors, append= TRUE, overwrite=FALSE, row.names=FALSE)
dbDisconnect(mydb) 

#mumbai

sensor_location_mumbai <- data.frame(read.csv("/www/Map/files/Mumbai.csv"))

dbWriteTable(mydb, "Readings", sensor_location_mumbai, append= TRUE, overwrite=FALSE, row.names=FALSE)
dbDisconnect(mydb) 
