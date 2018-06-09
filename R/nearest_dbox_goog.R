#' Nearest Dbox
#'
#' Given a set of lat-long coordinates for each voter, and a set of coordinates for all drop boxes or
#' polling locations, nearest_dbox2() calculates the nearest drop box or polling location for each voter,
#' in meters or seconds.
#'
#'
#' @param lat_lon1d Numeric matrix, latitude and longitude coordinates of voter
#' @param lat_lon2d Numeric matrix, latitude and longitude coordinate of drop box, polling location
#' @param mode Travel mode, one of: "driving" (default), "transit", "walking", "bicycling"
#' @param value to extract, one of: "distance_m" (default), "distance_text", "duration_s","duration_text"
#'
#' @return A numeric vector of minimum distances for each voter to their nearest drop box or polling location
#' @export
#'
#' @examples
nearest_dbox_goog<- function(lat_lon1d, lat_lon2d,
                         mode = c("driving", "transit", "walking", "bicycling"),
                         value =c("distance_m", "distance_text", "duration_s", "duration_text")){

  origins<- lat_lon1d[, c("long", "lat")]
  colnames(origins) <- c("lon", "lat")

  destinations <- lat_lon2d[, c("long", "lat")]
  colnames(destinations) <- c("lon", "lat")


  doc = mapsapi::mp_matrix(
    origin = origins,
    destination = destinations,
    mode = mode)

  m = NULL
  # Try calling Google's API, catch mapsapi error if it fails
  try({m = mapsapi::mp_get_matrix(doc, value = value)}, silent = TRUE)

  # If there were no results, issue warning and return NULL
  if(length(m) == 0){
    stop("No results were returned")
    zero_results = TRUE
    min_values <- NULL
  } else {
    # Otherwise, return minimum distance
    # Run function on all rows or columns
    min_values <- apply(m, 1, min)
  }

  return(min_values)
}
