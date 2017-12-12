# data viz using plotly
# https://campus.datacamp.com/courses/plotly-tutorial-plotly-and-r
# https://plotly-book.cpsievert.me/plot-ly-for-collaboration.html
# cheatsheet: https://images.plot.ly/plotly-documentation/images/r_cheat_sheet.pdf
require(plotly)
require(dplyr)
require(tidyr)
require(ggplot2)

plot_ly(z = ~volcano, type = "heatmap")
plot_ly(z = ~volcano, type = "surface")
plot_ly(diamonds, x = ~carat, y = ~price)
plot_ly(diamonds, x = ~carat, y = ~price, color = ~carat, size = ~carat)
count(diamonds, cut, clarity) %>% plot_ly(x = ~cut, y = ~n, type = "bar", color = ~clarity)
plot_ly(x = time(USAccDeaths), y = USAccDeaths) %>% add_lines() %>% rangeslider()

# National Mood
dir <- data.frame(
  year = seq(2006, 2017, 1),
  right = c(44.29, 42.27, 37.52, 42.34, 46.69, 46.20, 51.53, 58.23, 54.71, 36.71, 29.29, 32.78),
  wrong = c(21.06, 23.72, 32.02, 29.42, 27.01, 34.65, 31.29, 36.77, 40.46, 57.45, 65.88, 61.19),
  dk = c(4.28, 7.49, 6.39, 6.80, 4.29, 1.97, 1.61, 4.87, 4.47, 5.27, 4.26, 5.27), 
  some.right.wrong = c(29.40, 25.35, 22.97, 20.55, 21.57, 17.08, 15.40, NA, NA, NA, NA, NA), 
  refused = c(0.97, 1.16, 1.10, 0.89, 0.44, 0.10, 0.17, 0.12, 0.36, 0.57, 0.56, 0.77)
)
dir <- gather(dir, response, values, -year)
plot_ly(dir, x = ~year, y = ~values, color = ~response, type = "scatter", mode = "lines+markers") %>% layout(title = "Natinal Mood", xaxis = list(title = "Year"), yaxis = list(title = "Percent Responses")) %>% rangeslider()
plot_ly(dir, x = ~year, y = ~values, color = ~response) %>% add_lines() %>% rangeslider()


# Right Direction
df <- data.frame(
  year = seq(2006, 2017, 1),
  right = c(44.29, 42.27, 37.52, 42.34, 46.69, 46.20, 51.53, 58.23, 54.71, 36.71, 29.29, 32.78),
  frame = seq(1:12)
)
p <- ggplot(df, aes(year, right, col = right, size = right)) +
  geom_point(aes(frame = frame)) + geom_line()
ggplotly(p)

g <- ggplot(df, aes(year, right, fill = right)) + geom_col(aes(frame = frame))
ggplotly(g)


# mode = "markers"
plot_ly(mtcars, x = ~wt, y = ~mpg, mode = "markers", color = ~factor(cyl), size = ~hp)
plot_ly(mtcars, x = ~wt, y = ~mpg, mode = "markers", color = ~disp)
plot_ly(mtcars, x = ~wt, y = ~mpg, z = ~hp, type = "scatter3d", mode = "markers", color = ~factor(cyl))

# "lines", "lines+markers"
# EU stock market prices, mainpuated and line plot
stock <- gather(as.data.frame(EuStockMarkets), index, price) %>% mutate(time = rep(time(EuStockMarkets), 4))
plot_ly(stock, x = ~time, y = ~price, color = ~index, mode = "lines", type = "scatter")


# map
state_pop <- data.frame(State = state.abb, Pop = as.vector(state.x77[,1]))
state_pop$hover <- with(state_inc, paste(State, "<br>", "population:", Pop))
borders <- list(color = toRGB("red"))
map_options <- list(scope = "usa", projection = list(type = "albers usa"), showlakes = TRUE, lakecolor = toRGB("white"))
plot_ly(state_pop, z = ~Pop, text = ~hover, locations = ~State, type = "choropleth", 
        locationmode = "USA-states", color = ~Pop, colors = "Blues", marker = list(line = borders)) %>% 
  layout(title = "US pop in 1975", geo = map_options)




