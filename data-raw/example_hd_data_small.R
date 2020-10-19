## code to prepare `DATASET` dataset goes here
set.seed(12345678)
I = 20
visit = rpois(I, 1) + 3
time = unlist(lapply(visit, function(x)
  scale(c(0, cumsum(
    rpois(x - 1, 1) + 1
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
xi = t(matrix(rnorm(I * 3), ncol = I) * c(8, 4, 2)) * 3
zeta = t(matrix(rnorm(J * 3), ncol = J) * c(8, 4, 2)) * 2
Y = phix0 %*% t(xi[rep(1:I, visit), ]) +
  phix1 %*% t(time * xi[rep(1:I, visit), ]) +
  phiw %*% t(zeta) + matrix(rnorm(V * J, 0, .1), V, J)

example_hd_data_small = list(
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
usethis::use_data(example_hd_data_small, overwrite = TRUE, compress = "xz")
