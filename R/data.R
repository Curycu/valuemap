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

#' Polygons of administration area of Republic of Korea.
#'
#' A dataset containing the wgs84 coordinated polygons and other attributes.
#'
#' @format A sf with 3487 rows and 4 variables:
#' \describe{
#'   \item{name}{name of administration area}
#'   \item{hcode_7}{id codes with 7 digit number of administration area}
#'   \item{hcode_10}{id codes with 10 digit number of administration area}
#'   \item{geometry}{wgs84 base coordinated polygons}
#'   ...
#' }
#' @source \url{https://github.com/vuski/admdongkor}
"korea"

#' H3 addresses within Seoul, Republic of Korea.
#'
#' A dataset containing the h3 resolution level 8 addresses and other attributes.
#'
#' @format A data.frame with 1329 rows and 2 variables:
#' \describe{
#'   \item{h3_addr}{h3 resolution 8 address}
#'   \item{value}{meaningless number}
#'   ...
#' }
#' @source \url{https://github.com/vuski/admdongkor}
"seoul_h3"

#' administration area id code of Suwon, Republic of Korea.
#'
#' A dataset containing 7 digit number of administration area codes and other attributes.
#'
#' @format A sf with 44 rows and 2 variables:
#' \describe{
#'   \item{code}{id codes with 7 digit number of administration area}
#'   \item{value}{district number}
#'   ...
#' }
#' @source \url{https://github.com/vuski/admdongkor}
"suwon"
