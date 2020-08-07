#Establish a Connection to database

install.packages("RMySQL")
library(RMySQL)
mydb <- dbConnect(MySQL(), user='g1109698', password='SEVERELY26', dbname='g1109698', host='mydb.itap.purdue.edu')

# Look at the output from algorithm and store the sensor ID, x, y and region's latitude and longitude (center) 
# in a csv file with empty columns for Latitude and Longitude

data <- data.frame(read.csv("/www/Map/files/userinput_Chicago.csv"))

# calculation to convert sensor at location (x,y) to latitude and longitude on map relative to center point.
# center point or origin is the center of the region chosen by user

n <- as.numeric(nrow(data)) # counts number of rows in the dataframe

for (r in 1:n){
  
  x <- data[r,4]
  y <- data[r,5]
  center_lat <- data[1,9]
  center_long <- data[1,10]
  data[r, 7] <- (center_lat + 0.0009*x)
  data[r,6] <- (center_long +0.0009*y)
}

# Send dataframe with sensor latitudes and longitudes to the database

dbWriteTable(mydb, "Locations", data[,1:8], append= FALSE, overwrite=TRUE, row.names=FALSE)



