#' meterstomiles
#'
#' Converts Meters to Miles
#'
#' @param meters Single value or vectors of integers.
#'
#' @return Returns the input meters converted to mile units.
#' @export
#'
#' @examples
meterstomiles<- function(meters){
 miles<- meters/1609.34
 return(miles)
}

