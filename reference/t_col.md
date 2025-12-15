# Transparency color - from https://www.dataanalytics.org.uk/make-transparent-colors-in-r/

Transparency color - from
https://www.dataanalytics.org.uk/make-transparent-colors-in-r/

## Usage

``` r
t_col(color, percent = 50)
```

## Arguments

- color:

  A color

- percent:

  Transparency shade

## Value

A color hex

## Examples

``` r
t_col(tfff_colors("Dark Green"),50)
#> [1] "#004F397F"
```
