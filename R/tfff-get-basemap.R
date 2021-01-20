#' Title
#'
#' @return
#' @export
#'
#' @examples
tfff_get_basemap <- function() {

  options(tigris_class = "sf")

  tfff_basemap <- tigris::counties(cb = TRUE, class="sf") %>%
    janitor::clean_names() %>%
    dplyr::filter(statefp == "41" | statefp == "06") %>%
    dplyr::filter(statefp == "41" | name == "Siskiyou")
}
