library(ggplot2)
library(reshape2)
library(gridExtra)

setwd("~/Dropbox/beer_labels/sags")

ingredients <- "sag_pa.csv"
ingredients_table <- read.csv(ingredients, header = TRUE)

scatter <- ggplot(ingredients_table, aes(x = Time, y = Quantity)) +
  geom_point(shape = 21, aes(fill = factor(Quantity), size = Size), show.legend = FALSE) +
  theme_grey() + theme(
    panel.grid.minor = element_blank(),
    panel.border = element_rect(linetype = "solid", fill = NA)
  ) +
  scale_x_continuous(limits = c(0, 100), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 100), expand = c(0, 0))
scatter

mdata <- melt(ingredients_table, id="Time")

hist_top <- ggplot(mdata, aes(x = Time)) +
  geom_histogram() + #aes(fill = Quantity)) +
  theme_grey() + theme(
    panel.grid.minor = element_blank(),
    panel.border = element_rect(linetype = "solid", fill = NA),
    axis.ticks.x = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank()
  ) +
  scale_x_continuous(limits = c(0, 100), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 100), expand = c(0, 0))
hist_top

hist_right <- ggplot(ingredients_table, aes(x = Quantity)) +
  geom_histogram(aes(fill = Time)) + coord_flip() + #xlab(NULL) +
  #geom_density(alpha = 0.5, position = "stack") +
  theme_grey() + theme(
    panel.grid.minor = element_blank(),
    panel.border = element_rect(linetype = "solid", fill = NA),
    axis.ticks.y = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank()
  ) +
  scale_x_continuous(limits = c(0, 100), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 100), expand = c(0, 0))
hist_right

empty <- ggplot() + geom_point(aes(1, 1), colour = "white") +
  theme(
    axis.ticks = element_blank(),
    panel.background = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank()
  )

grid.arrange(hist_top, empty, scatter, hist_right, ncol=2, nrow=2, widths=c(4, 1), heights=c(1, 4))