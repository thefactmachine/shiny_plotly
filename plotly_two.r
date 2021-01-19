rm(list = ls())
library(dplyr)
library(plotly)
library(purrr)

# moving beyond simple interactivity.
# animations and linked brushing.
us_economy <- read.csv("plotly_data/state_economic_data.csv")

# ============================================================================
# this animates by year....bubble plot
us_economy %>%
  plot_ly(x = ~gdp, y = ~house_price) %>%
  add_markers(size = ~population, 
              color = ~region,
              frame = ~year, 
              ids = ~state,
              marker = list(sizemode = "diameter"))

# ============================================================================
# Animates by regions (only 4 regions)
us_economy %>%
  filter(year == 2017) %>%
  plot_ly(x = ~gdp, y = ~house_price) %>%
  add_markers(size = ~population, 
              color = ~region,
              frame = ~region, 
              ids = ~state,
              marker = list(sizemode = "diameter"))

# ============================================================================
# polishing animations: time between frames, frame transitions,
# slider appearance, colour, shape, et hover
# ============================================================================
# adding y, x axis titles and log transform the scale.......

df_us_economy_dist <- us_economy %>%
  group_by(year, state) %>% slice(1)

# 
df_us_economy_dist %>%
  plot_ly(x = ~gdp, y = ~house_price) %>%
  add_markers(
    size = ~population, color = ~region,
    frame = ~year, ids = ~state,
    marker = list(sizemode = "diameter")
  ) %>%
  layout(
    xaxis = list(title = "Real GDP (millions USD)", type = "log"),
    yaxis = list(title = "Housing price index")
  )

# ============================================================================
# Add the year as background text and remove the slider
df_us_economy_dist %>%
  plot_ly(x = ~gdp, y = ~house_price, hoverinfo = "text", text = ~state) %>%
  add_text(x = 200000, y = 450, text = ~year, frame = ~year,
           textfont = list(color = toRGB("gray80"), size = 150)) %>%
  add_markers(size = ~population, color = ~region,
              frame = ~year, ids = ~state,
              marker = list(sizemode = "diameter", sizeref = 3)) %>%
layout(xaxis = list(title = "Real GDP (millions USD)", type = "log"),
         yaxis = list(title = "Housing price index")) %>%
animation_slider(hide = TRUE)
# ============================================================================
# create an animated scatterplot with baseline from 1997 (GOOD)
# extract the 1997 data
us1997 <- df_us_economy_dist %>%
  filter(year == 1997)
s_economy_dist %>%
  plot_ly(x = ~gdp, y = ~house_price) %>%
  add_markers(data = us1997, 
              marker = list(color = toRGB("gray60"), 
                            opacity = 0.5)) %>%
  add_markers(frame = ~year, 
              ids = ~state, data = us_economy, 
              showlegend = FALSE, 
              alpha = 0.5) %>%
  layout(xaxis = list(type = "log"))

# ===============================================================
# Did not work here......
# we want to create cumulative datasets to display an animation.
# so we want to have something like: 1970; 1970, 1971; 1970, 1971, 1972 ....

df_med_hpi <-
  df_us_economy_dist %>%
  group_by(region, year) %>%
  summarize(median_hpi = median(house_price))

# this produces a data.frame for each year.
# object is a list.  Names is years.
df_med_hpi %>%
  split(.$year)

df_cal <- df_us_economy_dist %>% filter(state == "CA")

df_cal_accum <- df_cal %>% split(.$year) %>%
  purrr::accumulate(~bind_rows(.x, .y)) %>%
  purrr::set_names(1997:2017) %>%
  dplyr::bind_rows(.id = "frame")

# this did not work...but maybe can find a working snippet from somewhere.
df_cal_accum %>%
  plot_ly(x = ~year, y = ~house_price) %>%
  add_lines(
    frame = ~frame, showlegend = FALSE
  )

# ========================================================================
# linking two charts......

# "linked highlighting" or "linked brushing"
# crosstalk enables linked plots using Javascript

#world2014

library(crosstalk)
df_us_2017 <- df_us_economy_dist %>% filter(year == 2017)
shared_data <- crosstalk::SharedData$new(df_us_2017)
# gdp vs house_price
# gdp vs home_owners

p1 <- shared_data %>% plot_ly(x = ~house_price, y = ~gdp) %>%
  add_markers()

p2 <- shared_data %>% plot_ly(x = ~home_owners , y = ~gdp) %>%
  add_markers()

# we use the subplot commmand as usual but to link the two charts together
# we need to use the highlight() command

subplot(p1, p2, titleX = TRUE, titleY = TRUE) %>%
  hide_legend() %>%
  highlight(on = "plotly_selected")

# have a look at the graph above and then select some data points with the
# lasso command.

# brushing groups  .................

# nice line graph here....
df_us_economy_dist %>%
  plot_ly(x = ~year, y = ~house_price, alpha = 0.5) %>%
  group_by(state) %>%
  add_lines()

# above is good but not really that interactive....
# the following selects by state
df_us_economy_dist %>%
  crosstalk::SharedData$new(key = ~state) %>%
  plot_ly(x = ~year, y = ~house_price, alpha = 0.5) %>%
  group_by(state) %>%
  add_lines()


# you can select here by region.  Shows the dots associated with
# selected region....
us_temp_2017 <- df_us_economy_dist %>%
  ungroup() %>%
  filter(year == 2017) %>%
  crosstalk::SharedData$new(~region)

  us_temp_2017 %>%
  plot_ly(x = ~home_owners, y = ~house_price, alpha = 0.5) %>%
  add_markers()

# linking a summary and detailed view

# can use dplyr functions within plotly workflow with SharedData but
# otherwise the SharedData object does not fit in with the dplyr workflow

sd_raw <- shared_data <- df_us_economy_dist %>%
    filter(year == 2017)

shared_mast_detail <-df_us_economy_dist %>%
    filter(year == 2017) %>%
    crosstalk::SharedData$new(key = ~region)

# summary
p1 <- shared_mast_detail %>%
  plot_ly() %>%
  group_by(region) %>%
  summarise(av_population = mean(population, na.rm = TRUE)) %>%
  add_markers(x = ~av_population, y = ~region)

# detail
p2 <- shared_mast_detail %>%
  plot_ly(x = ~house_price, y = ~home_owners, text = ~region) %>%
  add_markers()

subplot(p1, p2) %>% hide_legend()

# mmmmm the above does not seem to work ??? should link the left hand with the
# right...

# ============================================================================
# ============================================================================

# following are exercises:
# Create a shared data object keyed by individual states
state_data <- df_us_economy_dist %>%
  SharedData$new(key = ~state)

# Using the shared data, plot house price vs. year
state_data %>%
  plot_ly(x = ~year, y = ~house_price) %>%
  # Group by state
  group_by(state) %>%
  # Add lines
  add_lines()

# Create a shared data object keyed by region
shared_region <- SharedData$new(us_economy, key = ~region)

# Create a shared data object keyed by division
shared_div <- SharedData$new(us2017, key = ~division)

# ============================================================================
# ============================================================================
# selection strategies....

# 1. Transient selection
# previously selected groups are forgotten

# 2. Persistent selection
# selected cases accumulate

