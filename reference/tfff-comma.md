# Comma formatting

These functions create comma labels. They are mostly just wrappers
around scales::comma(), scales::label_comma() and
ggplot2::scale\_(x\|y)\_continuous(). But they do have the extra
convenience built in that the scale functions already use comma
formatting.

## Usage

``` r
tfff_label_comma(accuracy = 0.1, ...)

tfff_comma(values, accuracy = 0.1, ...)

tfff_scale_x_comma(...)

tfff_scale_y_comma(...)
```

## Arguments

- accuracy:

  Accuracy of labels (e.g. 0.1 or 0.01)

- ...:

  Other arguments that are passed to \`scales::comma()\`,
  \`scales::label_comma()\` or \`ggplot2::scale\_(x\|y)\_continuous\`

- values:

  Values to be formatted

## Value

A character vector of comma labels or a ggplot2 scale.
