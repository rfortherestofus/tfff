library(tidyverse)

plt <- ggplot() +
  geom_text(
    # Just to check whether really Proxima Nova font
    aes(x = 1, y = 0.8, label = 'Proxima Nova Bold'),
    fontface = 'bold',
    size = 10
  ) +
  geom_text(
    aes(x = 1, y = 1, label = 'Proxima Nova Bold'),
    family = 'Proxima Nova',
    fontface = 'bold',
    size = 10
  ) +
  geom_text(
    aes(x = 1, y = 1.2, label = 'Proxima Nova Bold'),
    family = 'ProximaNova-Bold',
    size = 10
  ) +
  geom_text(
    aes(x = 1, y = 1.6, label = 'Proxima Nova Black'),
    family = 'ProximaNova-Black',
    size = 10
  ) +
  coord_cartesian(ylim = c(0, 2))

ggsave('inst/font_test.png', plt)
