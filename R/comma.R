#' Comma formatting
#'
#' @description
#' These functions create comma labels.
#' They are mostly just wrappers around scales::comma(), scales::label_comma() and ggplot2::scale_(x|y)_continuous().
#' But they do have the extra convenience built in that the scale functions already use comma formatting.
#'
#' @param accuracy Accuracy of labels (e.g. 0.1 or 0.01)
#' @param values Values to be formatted
#' @param ... Other arguments that are passed to `scales::comma()`, `scales::label_comma()` or `ggplot2::scale_(x|y)_continuous`
#'
#' @return A character vector of comma labels or a ggplot2 scale.
#'
#' @name tfff-comma
#' @rdname tfff-comma
#' @export
#'
tfff_label_comma <- function(
  accuracy = 0.1,
  ...
) {
  scales::label_comma(accuracy = accuracy, ...)
}

#' @rdname tfff-comma
#' @export
#'
tfff_comma <- function(values, accuracy = 0.1, ...) {
  tfff_label_comma(accuracy = accuracy, ...)(values)
}

#' @rdname tfff-comma
#' @export
tfff_scale_x_comma <- function(
  ...
) {
  tfff_scale_comma(aesthetic = 'x', ...)
}

#' @rdname tfff-comma
#' @export
#'
tfff_scale_y_comma <- function(
  ...
) {
  tfff_scale_comma(aesthetic = 'y', ...)
}


tfff_scale_comma <- function(
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
    labels = tfff_comma,
    ...
  )
}
