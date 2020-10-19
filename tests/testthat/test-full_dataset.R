testthat::context("Trying HDLFPCA")
testthat::test_that("works on full data", {
  data(example_hd_data)
  phix0 = example_hd_data$phix0
  phix1 = example_hd_data$phix1
  phiw = example_hd_data$phiw
  Y = example_hd_data$Y
  time = example_hd_data$time
  J = example_hd_data$J
  I = example_hd_data$I
  visit = example_hd_data$visit
  indices = 1:nrow(Y)
  re <- HDLFPCA::hd_lfpca(
    Y[indices,],
    T = scale(time, center = TRUE, scale = TRUE),
    J = J,
    I = I,
    visit = visit,
    varthresh = 0.95,
    projectthresh = 1,
    timeadjust = FALSE
  )
  testthat::expect_equal(mean(re$phiw*1000), 0.0221596715582231)
  testthat::expect_equal(
    colMeans(re$phix0*1000),
    c(2.25835618679043, -2.21949537547265, -2.42342116795384, -2.88944204581535
    ))
  testthat::expect_equal(colMeans(re$phix1*1000),
                         c(1.90243315846835, -2.08446163591179,
                           -1.62285266405034, -0.634547910061792)
  )
  testthat::expect_equal(re$Nw, 7L)
  testthat::expect_equal(re$Nx, 4L)

  testthat::expect_equal(
    re$sx,
    c(490.77704840249, 96.8782474283866, 38.5230100680366, 4.5204046404315
    )
  )
  testthat::expect_equal(
    re$sw,
    c(114.551035546181, 30.3927525541092, 12.6548160599522, 11.9475847172898,
      8.36265901505133, 5.29074435789924, 3.63804451590994)
  )

  testthat::expect_equal(re$residual, 9872.67284871758)
  testthat::expect_equal(
    rowMeans(re$xi),
    c(0.677984623456904, -0.410937698650476, 0.16902003091013, 0.0194506415030195)
  )
})
