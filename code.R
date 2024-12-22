#Load packages
library(tidyverse)
library(ggforce)
library(sf)

#Create plain background
c1 <-
ggplot() +
theme_void() +
theme(
  plot.background = element_rect(
    fill = "midnightblue"
  )
)

#Create ground snow
c2 <-
c1 +
annotate(
  geom = "rect",
  xmin = 0, xmax = 1,
  ymin = 0, ymax = 0.25,
  fill = "grey99",
  colour = "grey99"
) +
  xlim(0, 1) +
  ylim(0, 1) +
  coord_fixed(expand = FALSE)

#Create snowflakes
set.seed(20241225) #Cause it's christmas!
n <- 120
snowflakes <- 
  data.frame(x = runif(n, 0, 1),
             y = runif(n, 0, 1)
             )
c3 <-
c2 + 
  geom_point(
  data = snowflakes,
  mapping = aes(
    x = x,
    y = y
  ),
  colour = "white",
  pch = 8
)

#Create snowman's body from circles
c4 <-
c3 +
  geom_circle(
    data = data.frame(
      x0 = c(0.6, 0.6),
      y0 = c(0.3, 0.5),
      r = c(0.15, 0.1)
    ),
    mapping = aes(x0 = x0, y0 = y0, r = r),
    fill = "white",
    colour = "white"
  )

#Create eyes and buttons
c5 <-
c4 +
  geom_point(
    data = data.frame(
      x = c(0.6, 0.6, 0.6, 0.57, 0.62),
      y = c(0.25, 0.3, 0.35, 0.52, 0.52),
      size = runif(5, 2, 4.5)
    ),
    mapping = aes(x = x, y = y, size = size)
  ) +
  scale_size_identity()

#Create stick arms
c6 <- 
c5 + 
  geom_segment(
    data = data.frame(
      x = c(0.46, 0.7),
      xend = c(0.33, 0.85),
      y = c(0.3, 0.3),
      yend = c(0.4, 0.4)
    ),
    mapping = aes(x = x, y = y, xend = xend, yend = yend),
    colour = "chocolate4",
    lineend = "round",
    linewidth = 2
  )

#Create hat from rectangles
c7 <-
c6 +
  annotate(
    geom = "rect",
    xmin = 0.46, xmax = 0.74,
    ymin = 0.55, ymax = 0.60,
    fill = "brown"
  ) +
  annotate(
    geom = "rect",
    xmin = 0.50, xmax = 0.70,
    ymin = 0.56, ymax = 0.73,
    fill = "brown"
  )

#Create nose from triangle
  nose_pts <- matrix(
    c(
      0.6, 0.5,
      0.65, 0.48,
      0.6, 0.46,
      0.6, 0.5
    ),
    ncol = 2,
    byrow = TRUE
  )
nose <- st_polygon(list(nose_pts))
plot(nose) 

c8 <-
c7 +
  geom_sf(
    data = nose,
    fill = "orange",
    colour = "orange"
  ) +
  coord_sf(expand = FALSE)

#Add text "Merry Christmas"
c9 <- 
  c8 +
  annotate(
    geom = "text",
    x = 0.5, y = 0.1,
    label = "Merry Christmas!",
    colour = "red3",
    family = "mono",
    fontface = "bold", size = 7
  )
c9

#save the snowman!
ggsave("mr_snowman.png")

