options(digits = 4, width = 84)
options(dplyr.print_min = 6, dplyr.print_max = 6)
options(cli.width = 85)
options(crayon.enabled = FALSE)

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  fig.align = 'center',
  tidy = FALSE
)

## -----------------------------------------------------------------------------

theme_transparent <- function(...) {

  ret <- ggplot2::theme_bw(...)
  
  trans_rect <- ggplot2::element_rect(fill = "transparent", colour = NA)
  ret$panel.background  <- trans_rect
  ret$plot.background   <- trans_rect
  ret$legend.background <- trans_rect
  ret$legend.key        <- trans_rect
  
  ret$legend.position <- "top"
  
  ret
}

library(ggplot2)
theme_set(theme_transparent())

## -----------------------------------------------------------------------------

tidy_apm_version <- function() {
  dt <- Sys.Date()
  ver <- read.dcf("DESCRIPTION")[1, "Version"]
  paste0("Version ", ver, " (", dt, ")")
}

pkg <- function(x) {
  cl <- match.call()
  x <- as.character(cl$x)
  pkg_link(x)
}
pkg_link <- function(x) {
  if (x %in% c("mixOmics")) {
    res <- bioc_link(x)
  } else {
    res <- cran_link(x)
  }
  res
}
pkg_text <- function(x) {
  x <- sort(x)
  x <- purrr::map_chr(x, pkg_link)
  knitr::combine_words(x)
}
cran_link <- function(x) {
  paste0(
    '<span class="pkg"><a href="https://cran.r-project.org/package=', x, 
    '" target="_blank">', x, '</a></span>')
}
bioc_link <- function(x) {
  paste0(
    '<span class="pkg"><a href="https://www.bioconductor.org/packages/release/bioc/html/', x, 
    '.html" target="_blank">', x, '</a></span>')
}

# ------------------------------------------------------------------------------

source("extras/regression_plots.R")
