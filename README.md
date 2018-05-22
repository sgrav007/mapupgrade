# mapupgrade

Takes addresses and gives the distance between each of the locations. It then converts this distance to miles and returns it as a vector with a legend. It uses the Google distance matrix API by using the `mapsapi` package.

```

library(mapupgrade)

locations<- c("900 University Ave Riverside, CA 92521","9500 Gilman Dr, La Jolla, CA 92093", "White House")

dist_address(locations)

```

