# Script containing unit tests
library(testthat)

context("remove_missing function")

test_that("remove_missing works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal( remove_missing(a), c(2,5,7,4,3))
})


context("get_minimum function")

test_that("get_minimum works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(get_minimum(a),min(remove_missing(a)))
})


context("get_maximum function")

test_that("get_maximum works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(get_maximum(a),max(remove_missing(a)))
})


context("get_range function")

test_that("get_range works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(get_range(a),5)
})


context("get_percentile10 function")

test_that("get_percentile10 works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(get_percentile10(a),2.4)
})

context("get_percentile90 function")

test_that("get_percentile90 works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(get_percentile90(a),6.2)
})

context("get_median function")

test_that("get_median works", {
  a <- c(2,5,7,4,3,NA)
  b <- c(1,2,5,7,4,3,NA)
  expect_equal(get_median(a),median(remove_missing(a)))
  expect_equal(get_median(b),median(remove_missing(b)))
})

context("get_average function")

test_that("get_average works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(get_average(a),mean(remove_missing(a)))
})


context("get_stdev function")

test_that("get_stdev works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(get_stdev(a),sd(remove_missing(a)))
})


context("get_quartile1 function")

test_that("get_quartile1 works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(get_quartile1(a),3)
})

context("get_quartile3 function")

test_that("get_quartile3 works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(get_quartile3(a),5)
})

context("count_missing function")

test_that("count_missing works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(count_missing(a),1)
})


context("drop_lowest function")

test_that("drop_lowest works", {
  a <- c(2,5,7,4,3,NA)
  expect_equal(drop_lowest(a),c(5,7,4,3))
})


context("score_homework function")

test_that("score_homework works", {
  n <- c(100, 80, 30, 70, 75, 85, NA)
  expect_equal(score_homework(n, drop = TRUE),68)
  expect_equal(score_homework(n, drop = FALSE),73.3,tolerance = .002)
})


context("score_quiz function")

test_that("score_quiz works", {
  n <- c(100, 80, 30, 70, 75, 0, NA)
  expect_equal(score_quiz(n, drop = TRUE),51)
  expect_equal(score_quiz(n, drop = FALSE),59.16667,tolerance = .002)
})


context("score_lab function")

test_that("score_lab works", {
  expect_equal(score_lab(10),80)
  expect_equal(score_lab(8),40)
})

