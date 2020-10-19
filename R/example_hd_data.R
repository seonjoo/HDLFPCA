#' @title Example High-dimension data for PCA
#'
#' @description A list containing random sample data for HDLFPCA
#'
#' @format A list with 7 elements, which are:
#' \describe{
#' \item{Y}{p-by-J matrix of values}
#' \item{I}{Total number of subjects}
#' \item{J}{Total number of observations}
#' \item{time}{Time of the image collection}
#' \item{visit}{Vector of number of visits per subjects}
#' \item{phix0}{a matrix of true phi values for x0}
#' \item{phix1}{a matrix of truephi values for x1}
#' \item{phiw}{a matrix of true phi values for w}
#' \item{xi}{covariate values}
#' \item{zeta}{true zeta}
#' }
"example_hd_data"
