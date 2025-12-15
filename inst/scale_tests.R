devtools::load_all()
library(ggplot2)

### DOLLAR FORMATTING ===================================

tfff_dollar(1:20 * 1000) |> print()
tfff_dollar(1:20 * 1000, uses_suffix = FALSE) |> print()

plt <- diamonds |>
  ggplot(aes(carat, price)) +
  geom_point() +
  tfff_scale_y_dollar()

print(plt)

plt <- diamonds |>
  ggplot(aes(carat, price)) +
  geom_point() +
  tfff_scale_y_dollar(uses_suffix = TRUE)

print(plt)

### PERCENT FORMATTING ===================================

tfff_percent(9:11 / 100) |> print()
tfff_percent(9:11 / 100, accuracy = 0.01) |> print()

plt <- diamonds |>
  ggplot(aes(carat, depth / 100)) +
  geom_point() +
  tfff_scale_y_percent(
    breaks = seq(45, 105, 10) / 100,
    limits = c(0.45, 1.2)
  )

print(plt)

### COMMA FORMATTING ===================================

tfff_comma(1:20 * 1000) |> print()
tfff_comma(1:20 * 1000, accuracy = 0.01) |> print()

plt <- diamonds |>
  ggplot(aes(carat, price)) +
  geom_point() +
  tfff_scale_x_comma()

print(plt)
