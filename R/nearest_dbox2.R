#' Nearest Dbox
#'
#' Given a set of lat-long coordinates for each voter, and a set of coordinates for all drop boxes or
#' polling locations, nearest_dbox2() calculates the nearest drop box or polling location for each voter,
#' in meters or seconds.
#'
#'
#' @param lat1d_vec Numeric vector, latitude coordinate of voter
#' @param lon1d_vec Numeric vector, longitude coordinate of voter
#' @param lat2d_vec Numeric vector, latitude coordinate of drop box, polling location
#' @param lon2d_vec Numeric vector, longitude coordinate of drop box, polling location
#' @param mode Travel mode, one of: "driving" (default), "transit", "walking", "bicycling"
#' @param value to extract, one of: "distance_m" (default), "distance_text", "duration_s","duration_text"
#'
#' @return A numeric vector of minimum distances for each voter to their nearest drop box or polling location
#' @export
#'
#' @examples
nearest_dbox2<- function(lat1d_vec, lon1d_vec, lat2d_vec, lon2d_vec,
              mode = c("driving", "transit", "walking", "bicycling"),
              value =c("distance_m", "distance_text", "duration_s", "duration_text")){

  origins <- cbind(lon1d_vec, lat1d_vec)
  colnames(origins) <- c("lon", "lat")

  destinations <- cbind(lon2d_vec, lat2d_vec)
  colnames(destinations) <- c("lon", "lat")


  doc = mapsapi::mp_matrix(
    origin = origins,
    destination = destinations,
    mode = mode)


  m = mapsapi::mp_get_matrix(doc, value = value)

  # Run function on all rows or columns (1 is for rows, 2 is for columns/ rows are the voters)
  min_values <- apply(m, 1, min)

  return(min_values)
}
