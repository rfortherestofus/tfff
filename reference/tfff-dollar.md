# Dollar formatting

These functions format numbers like dollar amounts. They are mostly a
wrapper around scales::label_dollar, scales::dollar, and
ggplot2::scale\_\*\_continuous. The major diference is that there are
two arguments \`values\` and \`reference_values\`. The latter value can
be used to make sure that dollar formatting happens based on all values
and not just of values wrt. one county.

## Usage

``` r
tfff_label_dollar(values, reference_values = values, uses_suffix = TRUE)

tfff_dollar(values, reference_values = values, uses_suffix = TRUE)

tfff_scale_x_dollar(uses_suffix = FALSE, ...)

tfff_scale_y_dollar(uses_suffix = FALSE, ...)
```

## Arguments

- values:

  Vector of numbers

- reference_values:

  Overarching values (e.g. all values of a category and not just of one
  county.)

- ...:

  Other arguments that are passed to
  \`ggplot2::scale\_(x\|y)\_continuous\`

- use_suffix:

  Should dollar amounts larger than 10000 be abbreviated as 10K?
  Defaults to TRUE for non-scale functions and to FALSE otherwise.

## Value

A character vector of dollar amounts or a ggplot2 scale.
