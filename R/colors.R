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

#' Transparency color - from https://www.dataanalytics.org.uk/make-transparent-colors-in-r/
#'
#' @param color A color
#' @param percent Transparency shade
#'
#' @return A color hex
#' @export
#'
#' @example t_col(tfff_colors("Dark Green"),50)
t_col <- function(color, percent = 50) {
  #      color = color name
  #    percent = % transparency
  #       name = an optional name for the color

  ## Get RGB values for named color
  rgb.val <- col2rgb(color)

  ## Make new color using input color as base and alpha set by transparency
  t.col <- rgb(
    rgb.val[1],
    rgb.val[2],
    rgb.val[3],
    max = 255,
    alpha = percent * 255 / 100
  )

  ## Save the color
  return(t.col)
}
