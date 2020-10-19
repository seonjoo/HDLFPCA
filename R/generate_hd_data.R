#' Generate High-Dimensional Data
#'
#' @param I number of subjects
#'
#' @export
#'
#' @return A list with 7 elements, which are:
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
#'
#' @examples
#' generate_hd_data()
#' generate_hd_data(I = 20)
generate_hd_data = function(I = 100) {
  set.seed(12345678)
  visit = stats::rpois(I, 1) + 3
  time = unlist(lapply(visit, function(x)
    scale(c(0, cumsum(
      stats::rpois(x - 1, 1) + 1
    )))))
  J = sum(visit)
  V = 2500
  phix0 = matrix(0, V, 3)
  phix0[1:50, 1] <- .1

  phix0[1:50 + 50, 2] <- .1

  phix0[1:50 + 100, 3] <- .1
  phix1 = matrix(0, V, 3)

  phix1[1:50 + 150, 1] <- .1

  phix1[1:50 + 200, 2] <- .1

  phix1[1:50 + 250, 3] <- .1
  phiw = matrix(0, V, 3)

  phiw[1:50 + 300, 1] <- .1

  phiw[1:50 + 350, 2] <- .1

  phiw[1:50 + 400, 3] <- .1
  xi = t(matrix(stats::rnorm(I * 3), ncol = I) * c(8, 4, 2)) * 3
  zeta = t(matrix(stats::rnorm(J * 3), ncol = J) * c(8, 4, 2)) * 2
  Y = phix0 %*% t(xi[rep(1:I, visit), ]) +
    phix1 %*% t(time * xi[rep(1:I, visit), ]) +
    phiw %*% t(zeta) + matrix(stats::rnorm(V * J, 0, .1), V, J)

  list(
    I = I,
    J = J,
    V = V,
    phix0 = phix0,
    phix1 = phix1,
    phiw = phiw,
    xi = xi,
    zeta = zeta,
    Y = Y,
    time = time,
    visit = visit
  )
}
