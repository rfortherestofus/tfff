#' TFFF ggplot2 theme
#'
#' @return A ggplot2 theme
#' @export
#'
theme_tfff <-
  function(base_family = "Calibri",
           base_text_size = 12) {
    ggplot2::update_geom_defaults("text",
                                  list(family = base_family,
                                       lineheight = 1))

    ggplot2::theme_minimal(base_family = base_family) +
      ggplot2::theme(
        panel.grid.minor = ggplot2::element_blank(),
        panel.grid.major = ggplot2::element_line(color = tfff_colors("Light Gray")),
        text = ggplot2::element_text(size = base_text_size, color =  tfff_colors("Dark Gray")),
        axis.ticks = ggplot2::element_blank(),
        axis.text = ggplot2::element_text(color = tfff_colors("Dark Gray"),
                                          family = base_family),
        axis.text.y = ggplot2::element_text(hjust = 0),
        axis.title.x = ggplot2::element_blank(),
        axis.title.y = ggplot2::element_blank(),
        plot.title = ggplot2::element_text(
          family = base_family,
          face = "bold",
          color =  tfff_colors("Dark Gray"),
          size = 20
        ),
        plot.subtitle = ggplot2::element_text(size = 14),
        strip.text = ggplot2::element_text(color = tfff_colors("Dark Gray"), size = 12)
      )


  }
