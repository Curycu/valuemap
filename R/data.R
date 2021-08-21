#' Polygons of 25 administration area of Seoul, Republic of Korea.
#'
#' A dataset containing the wgs84 coordinated polygons and other attributes.
#'
#' @format A sf with 25 rows and 3 variables:
#' \describe{
#'   \item{name}{id codes with 4 digit number}
#'   \item{value}{numbers of sub-administration area}
#'   \item{geometry}{wgs84 base coordinated polygons}
#'   ...
#' }
#' @source \url{https://github.com/vuski/admdongkor}
"seoul"

#' H3 addresses within Seoul, Republic of Korea.
#'
#' A dataset containing the h3 resolution level 8 addresses and other attributes.
#'
#' @format A data.frame with 1329 rows and 2 variables:
#' \describe{
#'   \item{name}{h3 resolution 8 address}
#'   \item{value}{meaningless number}
#'   ...
#' }
#' @source \url{https://github.com/vuski/admdongkor}
"seoul_h3"
