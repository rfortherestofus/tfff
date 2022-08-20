#' TFFF paged template
#'
#' @param ... Params to pagedown::html_paged
#'
#' @return An Rmd paged them
#' @export
#'
tfff_draft <- function(...) {
  pagedown::html_paged(
    css = system.file("assets/main.css", package = "tfff"),
    number_sections = FALSE,
    toc = FALSE,
    ...
  )
}
