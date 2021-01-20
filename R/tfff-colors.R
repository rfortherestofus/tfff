#' Title
#'
#' @param desired_colors
#'
#' @return
#' @export
#'
#' @examples
tfff_colors <- function(desired_colors) {

  tfff_all_colors <- tibble::tribble(
    ~name, ~hex,
    "Dark Green", "#265142",
    "Light Green", "#B5CC8E",
    "Orange", "#e65100",
    "Yellow", "#FBC02D",
    "Blue", "#283593",
    "Red", "#B71C1C",
    "Brown", "#51261C",
    "Dark Gray", "#545454",
    "Medium Gray", "#a8a8a8",
    "Light Gray", "#eeeeee"
  )

  tfff_colors_to_return <- tfff_all_colors %>%
    dplyr::filter(name %in% desired_colors) %>%
    dplyr::pull(hex)

  tfff_colors_to_return

}


