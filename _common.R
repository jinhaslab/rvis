# Common R setup for all chapters
# Korean font setup using showtext package

library(showtext)
library(sysfonts)

# Add Google Noto Sans KR font for Korean text
font_add_google("Noto Sans KR", "noto")

# Enable showtext for all devices
showtext_auto()

# Set default ggplot2 theme with Korean font
library(ggplot2)
theme_set(theme_grey(base_family = "noto"))

# Increase DPI for better font rendering
showtext_opts(dpi = 96)

# Set global knitr options
knitr::opts_chunk$set(
  fig.showtext = TRUE,
  dev = "png",
  dpi = 96
)
