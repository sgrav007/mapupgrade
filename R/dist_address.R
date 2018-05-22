#' Dist_Address
#'
#' @param locations Text addresses to calculate distance between all addresses entered.
#'
#' @return Matrix of distances in miles and returns datafrmae of locations.
#' @export
#'
#' @examples
dist_address<- function(locations){
  doc = mapsapi::mp_matrix(
    origins = locations,
    destinations = locations
  )
  m = mapsapi::mp_get_matrix(doc, value = "distance_m")
  #add id numbers to col and row names
  n<-length(locations)
  id<-as.character(1:n)
  colnames(m) = id
  rownames(m) = id
  miles<- meterstomiles(m)
  df<- data.frame(id=id, location=locations)
  return(list(miles=miles, locations=df))

}
