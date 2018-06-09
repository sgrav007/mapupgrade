library(Rvoterdistance)

data(meck_ev)
head(early_meck)
head(voter_meck)

voter_sample  <- voter_meck[1:50, ]
dboxes_sample <- early_meck[ ]

data1<- voter_sample
data2<- dboxes_sample

head(data1)

lat_long1_char<-c("lat", "long")
lat_long2_char<-c("lat", "long")


colnames(X)
head(X[,"lat"]) # latitude column
head(X[, c("lat", "long")])




X <- as.matrix( data1[,lat_long1_char] ) # Turn data into X, Y matrices to send to nearest_dbox2()
Y <- as.matrix( data2[, lat_long2_char] )

X
Y

nearest_dbox_goog(X,Y)


goog_results<- nearest_dbox_goog(X,Y, mode, value)


list_hold <- Rvoterdistance::nearest_dbox2(lat_lon1d = X, lat_lon2d = Y) # Execute nearest_dbox2, which is internal
distance_haversine <- list_hold$distance # extract distance
distance_mile <- Rvoterdistance::dist_mile(num_vec=distance_haversine, vec_only=TRUE) # Miles
distance_km <- Rvoterdistance::dist_km(num_vec=distance_haversine, vec_only=TRUE) # Kilometers
smorge <- data.frame(data1,data2[list_hold$rows,], distance_haversine, distance_mile, distance_km, goog_results) #Piece together
row.names(smorge) <-NULL # Clean up rownames

View(smorge)
