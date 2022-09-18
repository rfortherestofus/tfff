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
    `Medium Green` = "#71A850",
    `Light Green` = "#AAC275",
    `Orange` = "#DD8A03",
    `Yellow` = "#FCD672",
    `Blue` = "#42A7C6",
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
