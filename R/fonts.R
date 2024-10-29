#' Function to register fonts of the TFFF
#'
#' @name register_fonts
#' @param verbose whether or not to display families and their path in the console (FALSE by default)
#' @export
register_fonts <- function() {
  font_dir <- system.file("fonts", package = "tfff")
  font_files <- list.files(font_dir, recursive = TRUE, full.names = TRUE, pattern = "\\.(ttf|otf)$")

  for (font_file in font_files) {
    cat("registering:", font_file, "\n")
    font_name <- tools::file_path_sans_ext(basename(font_file))
    systemfonts::register_font(name = font_name, plain = font_file)
  }
}
