



#' Title
#'
#' @param data1
#' @param data2
#' @param lat_long1_char
#' @param lat_long2_char
#' @param mode
#' @param value
#'
#' @return
#' @export
#'
#' @examples
#'
#'
smorgesboard2 <- function( data1, data2 , lat_long1_char, lat_long2_char,
                          mode = c("driving", "transit", "walking", "bicycling"),
                          value =c("distance_m", "distance_text", "duration_s", "duration_text")) {

  X <- as.matrix( data1[,lat_long1_char] ) # Turn data into X, Y matrices to send to nearest_dbox2()
  Y <- as.matrix( data2[, lat_long2_char] )
  goog_results<- nearest_dbox_goog(X,Y, mode, value)
  list_hold <- nearest_dbox2(lat_lon1d = X, lat_lon2d = Y) # Execute nearest_dbox2, which is internal
  distance_haversine <- list_hold$distance # extract distance
  distance_mile <- Rvoterdistance::dist_mile(num_vec=distance_haversine, vec_only=TRUE) # Miles
  distance_km <- Rvoterdistance::dist_km(num_vec=distance_haversine, vec_only=TRUE) # Kilometers
  smorge <- data.frame(data1,data2[list_hold$rows,], distance_haversine, distance_mile, distance_km, goog_results)  #Piece together
  row.names(smorge) <-NULL # Clean up rownames
  return(smorge)

}

