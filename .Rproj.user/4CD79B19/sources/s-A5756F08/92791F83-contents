
rm(list = ls())
vgsales <- read.csv(url(paste0("https://assets.datacamp.com/production/",
                               "repositories/1792/datasets/",
                               "2396f3f587e31ea726911e5d8974c5f98db5eee1/vgsales.csv")))

write.csv(vgsales, "plotly_data/vgsales.csv")

rm(list = ls())

library(plotly)
library(dplyr)

# reordering factor levels
library(forcats)
vgsales <- read.csv("plotly_data/vgsales.csv")
wine <- read.csv("plotly_data/wine.csv")
winequality <- read.csv("plotly_data/winequality.csv")



# === Customising your layout =================
# Adding axis labels
winequality %>%
  plot_ly(x = ~free_so2, y = ~total_so2) %>%
  add_markers(marker = list(opacity = 0.2)) %>%
  layout(xaxis = list(title = "Free S02 (ppm)"),
         yaxis = list(title = "Total S02 (ppm)"),
         title = "Does this scatter plot look nice?")

# transform scale --- log scale......
winequality %>%
  plot_ly(x = ~free_so2, y = ~total_so2) %>%
  add_markers(marker = list(opacity = 0.2)) %>%
  layout(xaxis = list(title = "Free S02 (ppm) - log scale", type = "log"),
         yaxis = list(title = "Total S02 (ppm) - log scale ", type = "log"),
         title = "Does this scatter plot look nice?")




# remove zero line
winequality %>%
  plot_ly(x = ~free_so2, y = ~total_so2) %>%
  add_markers(marker = list(opacity = 0.2)) %>%
  layout(xaxis = list(title = "Free S02 (ppm)", zeroline = FALSE),
         yaxis = list(title = "Total S02 (ppm)", zeroline = FALSE),
         title = "Does this scatter plot look nice?"
  )


# customise the canvas
winequality %>%
  plot_ly(x = ~free_so2, y = ~total_so2) %>%
  add_markers(marker = list(opacity = 0.2)) %>%
  layout(xaxis = list(title = "Free S02 (ppm)"),
         yaxis = list(title = "Total S02 (ppm)"),
         title = "Does this scatter plot look nice?",
         plot_bgcolor = toRGB("gray90"),
         paper_bgcolor = toRGB("skyblue"))

