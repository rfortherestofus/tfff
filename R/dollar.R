#' Dollar formatting
#'
#' @description
#' These functions format numbers like dollar amounts.
#' They are mostly a wrapper around scales::label_dollar, scales::dollar, and ggplot2::scale_*_continuous.
#' The major diference is that there are two arguments `values` and `reference_values`.
#' The latter value can be used to make sure that dollar formatting happens based on all values and not just
#' of values wrt. one county.
#'
#' @param values Vector of numbers
#' @param reference_values Overarching values (e.g. all values of a category and not just of one county.)
#' @param use_suffix Should dollar amounts larger than 10000 be abbreviated as 10K? Defaults to TRUE for non-scale functions and to FALSE otherwise.
#' @param ... Other arguments that are passed to `ggplot2::scale_(x|y)_continuous`
#'
#' @return A character vector of dollar amounts or a ggplot2 scale.
#'
#' @name tfff-dollar
#' @rdname tfff-dollar
#' @export
#'
tfff_label_dollar <- function(
  values,
  reference_values = values,
  uses_suffix = TRUE
) {
  if (uses_suffix && max(reference_values, na.rm = TRUE) > 10000) {
    return(
      scales::label_dollar(
        scale = 1e-3,
        suffix = "k",
        accuracy = 1
      )
    )
  }

  scales::label_dollar(accuracy = 1)
}

#' @rdname tfff-dollar
#' @export
#'
tfff_dollar <- function(values, reference_values = values, uses_suffix = TRUE) {
  tfff_label_dollar(reference_values, uses_suffix = uses_suffix)(values)
}

#' @rdname tfff-dollar
#' @export
tfff_scale_x_dollar <- function(
  uses_suffix = FALSE,
  ...
) {
  tfff_scale_dollar(aesthetic = 'x', uses_suffix = uses_suffix)
}

#' @rdname tfff-dollar
#' @export
tfff_scale_y_dollar <- function(
  uses_suffix = FALSE,
  ...
) {
  tfff_scale_dollar(aesthetic = 'y', uses_suffix = uses_suffix)
}


tfff_scale_dollar <- function(
  aesthetic = 'x',
  uses_suffix = FALSE,
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
    labels = \(x) tfff_dollar(x, uses_suffix = uses_suffix),
    ...
  )
}
