testthat::context("Trying HDLFPCA")
example_hd_data = generate_hd_data(I = 100)

phix0 = example_hd_data$phix0
phix1 = example_hd_data$phix1
phiw = example_hd_data$phiw
Y = example_hd_data$Y
time = example_hd_data$time
J = example_hd_data$J
I = example_hd_data$I
visit = example_hd_data$visit

testthat::test_that("works on full data", {

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



testthat::test_that("works on subset data", {
  indices = 1:400
  re <- HDLFPCA::hd_lfpca(
    Y[indices,],
    T = scale(time, center = TRUE, scale = TRUE),
    J = J,
    I = I,
    visit = visit,
    Nw = 7,
    Nx = 4,
    varthresh = 0.95,
    projectthresh = 1,
    timeadjust = TRUE,
    figure = TRUE
  )


  testthat::expect_equal(mean(re$phiw*1000), -2.63946792438721)
  testthat::expect_equal(
    colMeans(re$phix0*1000),
    c(13.3493723861197, -13.3580732255287,
      -14.2666551815559, -18.5168153134067
    )
  )
  testthat::expect_equal(
    colMeans(re$phix1*1000),
    c(12.9816278713505, -13.9120079554871,
      -10.9841124093542, -10.2772410142864
    )
  )
  testthat::expect_equal(re$Nw, 7L)
  testthat::expect_equal(re$Nx, 4L)

  testthat::expect_equal(
    re$sx,
    c(559.122970613659, 110.110616086869, 43.7670421892069, 4.30591146765645
    )
  )
  testthat::expect_equal(
    re$sw,
    c(114.444177475096, 30.295055513728, 12.4159339484643, 11.7040242553597,
      5.021148985976, 3.14593397314224, 0.0513151608548925)
  )

  testthat::expect_equal(re$residual, 4132.61295466348)
  testthat::expect_equal(
    rowMeans(re$xi),
    c(0.75594903527378, -0.218963018530693, 0.194753903278344, 0.0231163909575934
    )
  )

})


testthat::test_that("Added in verbose and Nx > 20", {
  indices = 1:400
  re <- HDLFPCA::hd_lfpca(
    Y[indices,],
    T = scale(time, center = TRUE, scale = TRUE),
    J = J,
    I = I,
    visit = visit,
    Nw = 7,
    Nx = 20,
    varthresh = 0.95,
    projectthresh = 1,
    timeadjust = TRUE,
    figure = TRUE,
    verbose = 2
  )



})

