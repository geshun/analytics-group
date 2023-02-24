library(echarts4r)

ru <- gapminder::gapminder_unfiltered |>
  subset(country %in% c("Russia", "Ukraine") & year > 1991) |>
  transform(lifeExp_ = ifelse(year %in% range(year), lifeExp, NA_real_))

opt <- list(
  dataset = list(
    list(
      dimensions = colnames(ru),
      source = ru
    ),
    list(
      id = "russia",
      transform = list(
        type = "filter",
        config = list(
          dimension = "country",
          value = "Russia"
        )
      )
    ),
    list(
      id = "ukraine",
      transform = list(
        type = "filter",
        config = list(
          dimension = "country",
          value = "Ukraine"
        )
      )
    )
  ),
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
  xAxis = list(
    type = "category",
    axisLabel = list(
      color = "#bbb",
      fontSize = 15,
      fontFamily = 'monospace'
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
      lineStyle = list(
        color = "rgba(100, 100, 100, 0.35)",
        type = "dashed"
      )
    )
  ),
  tooltip = list(trigger = "axis"),
  series = list(
    list(
      name = "Russia",
      type = "line", 
      # datasetIndex = 1,
      datasetId = "russia",
      encode = list(
        x = "year", 
        y = "lifeExp"
      ),
      smooth = TRUE,
      showSymbol = FALSE,
      color = "#B22222",
      endLabel = list(
        show = TRUE,
        formatter = "{@country} {@lifeExp}",
        fontSize = 20,
        fontFamily = 'monospace'
      ),
      lineStyle = list(width = 3)
    ),
    list(
      name = "Ukraine",
      type = "line",
      # datasetIndex = 2,
      datasetId = "ukraine",
      encode = list(
        x = "year",
        y = "lifeExp"
      ),
      smooth = TRUE,
      showSymbol = FALSE,
      color = "rgba(238, 197, 102, 1)",
      endLabel = list(
        show = TRUE,
        formatter = "{@country} {@lifeExp}",
        fontSize = 19,
        fontFamily = 'monospace'
      ),
      lineStyle = list(width = 3)
    ),
    list(
      type = "effectScatter",
      datasetIndex = 1,
      encode = list(
        x = "year",
        y = "lifeExp_"
      ),
      rippleEffect = list(scale = 4),
      symbolSize = 12,
      color = "#b22",
      tooltip = list(show = FALSE)
    ),
    list(
      type = "effectScatter",
      datasetIndex = 2,
      encode = list(
        x = "year",
        y = "lifeExp_"
      ),
      rippleEffect = list(scale = 4),
      symbolSize = 12,
      color = "rgba(238, 197, 102, 1)",
      tooltip = list(show = FALSE)
    )
  ),
  animationDuration = 25000
)

e_charts() |> e_list(opt)

