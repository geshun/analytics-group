library(tidyverse)
library(echarts4r)

ru <-
  gapminder::gapminder_unfiltered %>%
  filter(country %in% c("Russia", "Ukraine")) %>%
  filter(year > 1991) %>%
  mutate(year = lubridate::make_date(year, 1, 1)) %>%
  rename(life_expectancy = lifeExp) %>% 
  mutate(
    life_expectancy_ = case_when(
      min(year) ==  year ~ life_expectancy,
      max(year) ==  year ~ life_expectancy,
      TRUE ~ NA_real_)
  )

line_type <- function(country, color) {
  list(
    type = "line",
    name = country,
    smooth = TRUE,
    data = ru$life_expectancy[ru$country == country],
    color = color,
    showSymbol = FALSE,
    endLabel = list(
      show = TRUE,
      formatter = "{a} {c}",
      fontSize = 19,
      fontFamily = 'monospace'
    ),
    lineStyle = list(width = 3)
  )
}

scatter_type <- function(country, color) {
  list(
    type = "effectScatter",
    rippleEffect = list(scale = 4),
    symbolSize = 12,
    color = color,
    data = ru$life_expectancy_[ru$country == country]
  )
}

text_element <- function(text, size, bottom) {
  list(
    type = "text",
    right = "center",
    bottom = bottom,
    style = list(
      text = text,
      font = paste0('bolder ', size, 'px monospace'),
      fill = 'rgba(100, 100, 100, 0.25)'
    ),
    z = 100
  )
}

opt <- list(
  backgroundColor = "#161627",
  title = list(
    text = "Life Expectancy in Russia and Ukraine",
    subtext = "since 1992",
    left = "center",
    top = 10,
    textStyle = list(
      color = "#eee",
      fontFamily = 'monospace'
    ),
    subtextStyle = list(
      color = "#ccc",
      fontSize = 18,
      fontFamily = 'monospace'
    )
  ),
  tooltip = list(
    trigger = "axis"
  ),
  animationDuration = 25000,
  graphic = list(
    elements = list(
      text_element("", 50, 150),
      text_element("", 40, 115)
    )
  ),
  xAxis = list(
    type = "category",
    data = lubridate::year(ru$year[ru$country == "Russia"]),
    axisLabel = list(
      color = "#bbb",
      fontSize = 15,
      fontFamily = 'monospace'
    ),
    splitLine = list(
      lineStyle = list(
        color = "#ccc",
        type = "dashed"
      )
    )
  ),
  yAxis = list(
    type = "value",
    min = 60,
    max = 75,
    axisLabel = list(
      color = "#bbb",
      fontSize = 15,
      fontFamily = 'monospace'
    ),
    splitLine = list(
      show = TRUE,
      lineStyle = list(
        color = "rgba(100, 100, 100, 0.35)",
        type = "dashed"
        
      )
    )
  ),
  series = list(
    line_type("Russia", "firebrick"),
    line_type("Ukraine", "rgba(238, 197, 102, 1)"),
    scatter_type("Russia", "firebrick"),
    scatter_type("Ukraine", "rgba(238, 197, 102, 1)")
  )
)

e_chart() %>%
  e_list(opt)

