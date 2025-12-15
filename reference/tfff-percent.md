# Percent formatting

These functions create percent labels. They are mostly just wrappers
around scales::percent(), scales::label_percent() and
ggplot2::scale\_(x\|y)\_continuous(). But they do have the extra
convenience built in that the scale functions already use percent
formatting and breaks are capped at 100

## Usage

``` r
tfff_label_percent(accuracy = 0.1, ...)

tfff_percent(values, accuracy = 0.1, ...)

tfff_scale_x_percent(...)

tfff_scale_y_percent(...)
```

## Arguments

- accuracy:

  Accuracy of percent labels (e.g. 0.1 or 0.01)

- ...:

  Other arguments that are passed to \`scales::percent()\`,
  \`scales::label_percent()\` or \`ggplot2::scale\_(x\|y)\_continuous\`

- values:

  Values to be formatted

## Value

A character vector of percent labels or a ggplot2 scale.
