library(Rvoterdistance)

data(meck_ev)
head(early_meck)
head(voter_meck)

#Test Data

voter_long <- voter_meck[1:4, "long"]
voter_lat <- voter_meck[1:4, "lat"]


dboxes_long <- early_meck[1:4, "long"]
dboxes_lat <- early_meck[1:4, "lat"]

mode= "driving"
value= "duration_s"

mapupgrade::nearest_dbox2(voter_lat, voter_long, dboxes_lat, dboxes_long, mode= "driving", value= "duration_s")

origins <- cbind(voter_long, voter_lat)
colnames(origins) <- c("lon", "lat")

destinations <- cbind(dboxes_long, dboxes_lat)
colnames(destinations) <- c("lon", "lat")


doc = mapsapi::mp_matrix(
  origin = origins,
  destination = destinations,
  mode = mode)


m = mapsapi::mp_get_matrix(doc, value = value)

View(m)


# Run function on all rows or columns (1 is for rows, 2 is for columns/ rows are the voters)
inx<- apply(m, 1, min)
View(inx)


