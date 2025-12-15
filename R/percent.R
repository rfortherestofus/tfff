#' Percent formatting
#'
#' @description
#' These functions create percent labels.
#' They are mostly just wrappers around scales::percent(), scales::label_percent() and ggplot2::scale_(x|y)_continuous().
#' But they do have the extra convenience built in that the scale functions already use percent formatting and breaks are capped at 100%.
#'
#' @param accuracy Accuracy of percent labels (e.g. 0.1 or 0.01)
#' @param values Values to be formatted
#' @param ... Other arguments that are passed to `scales::percent()`, `scales::label_percent()` or `ggplot2::scale_(x|y)_continuous`
#'
#' @return A character vector of percent labels or a ggplot2 scale.
#'
#' @name tfff-percent
#' @rdname tfff-percent
#' @export
#'
tfff_label_percent <- function(
  accuracy = 0.1,
  ...
) {
  scales::label_percent(accuracy = accuracy, ...)
}

#' @rdname tfff-percent
#' @export
#'
tfff_percent <- function(values, accuracy = 0.1, ...) {
  tfff_label_percent(accuracy = accuracy, ...)(values)
}

#' @rdname tfff-percent
#' @export
tfff_scale_x_percent <- function(
  ...
) {
  tfff_scale_percent(aesthetic = 'x', ...)
}

#' @rdname tfff-percent
#' @export
tfff_scale_y_percent <- function(
  ...
) {
  tfff_scale_percent(aesthetic = 'y', ...)
}


tfff_scale_percent <- function(
  breaks,
  aesthetic = 'x',
  ...
) {
  if (!(aesthetic %in% c('x', 'y'))) {
    cli::cli_abort('{.arg aesthetic} must be one of {.val x} or {.val y}.')
  }
  {
    fn_scale <- ggplot2::scale_x_continuous
  }
  if (aesthetic == 'y') {
    fn_scale <- ggplot2::scale_y_continuous
  }
  fn_scale(
    breaks = breaks |> pmin(1),
    labels = tfff_percent,
    ...
  )
}
