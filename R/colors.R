#' Function to extract TFFF colors as hex codes
#'
#' tfff_colors() enables you to pull colors directly from the tfff palette.
#' Choose one of the following options: `Dark Green`, `Light Green`, `Orange`,
#' `Yellow`, `Blue`, `Red`, `Brown`, `Dark Gray`, `Medium Gray`, `Light Gray`.
#'
#' @param ... color or colors you want to retun
#'
#' @return A vector of colors
#' @export
#'
tfff_colors <- function(...) {
  tfff_colors_vector <- c(
    `Dark Green` = "#265142",
    `Light Green` = "#B5CC8E",
    `Orange` = "#e65100",
    `Yellow` = "#FBC02D",
    `Blue` = "#283593",
    `Red` = "#B71C1C",
    `Brown` = "#51261C",
    `Dark Gray` = "#545454",
    `Medium Gray` = "#a8a8a8",
    `Light Gray` = "#eeeeee"
  )

  cols <- c(...)

  cols <- stringr::str_to_title(cols)

  if (is.null(cols))
    return(tfff_colors_vector)

  tfff_colors_vector[cols] %>%
    as.vector()


}
