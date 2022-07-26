#' Function to get an sf object with the TFFF service area (Oregon and Siskiyou
#' County, California)
#'
#' @return sf object with Oregon counties and Siskiyou County, California
#' @export
#'
tfff_get_basemap <- function() {
  options(tigris_class = "sf")

  tfff_basemap <- tigris::counties(cb = TRUE, class = "sf") %>%
    janitor::clean_names() %>%
    dplyr::filter(statefp == "41" | statefp == "06") %>%
    dplyr::filter(statefp == "41" | name == "Siskiyou") %>%
    dplyr::select(name, geoid) %>%
    dplyr::rename(geography = name)

  tfff_basemap
}
