############ Data Visualization ############

# interactive display of a df or matrix in nice tables
library(DT)
datatable(x) #beautiful interactive table in HTML
datatable(df, rownames = F, colnames = c("firstcol", "secondcol"), filter = "top", caption = "Caption here")


## ## ## ## ## ## ##
## ### Base-R ### ##
## ## ## ## ## ## ##

### univariate charts
stripchart(df$var)
barplot(prop.table(table(df$var)))
hist(df$var)

## barplot
barplot(prop.table(table(df$var1, df$var2))) #cross-tab

## scatter plot
plot(yvar ~ xvar, data = df) # or plot(df$xvar, df$yvar)
plot(yvar ~ xvar, data = df, 
     pch = 19, # plot character
     cex = 2, # character expansion
     main = "Chart title", xlab = "x axis title", ylab = "y axis title", col = colvar) # colors based on colvar
grid() # adds a grid to plot

abline(c(33,44), lty = 1) # regression line of function y=33+44x. lty = line type
reg-estimate <- lm(depvar ~ indpvar, data = df) # linear regression
abline(coefficients(reg-estimate))

## scatter plot matrix
pairs(formula = ~var1 + var2 + var3, data=df)

## box plot
boxplot(df$scatvar, main = "Chart title", ylab = "y axis label", xlab = "x axis label", horizontal=TRUE, las = 1)
boxplot(df$scatvar ~ df$var1 + df$var2)

## Distribution of data using Q–Q plot (normal distribution)
qqnorm(df$var, main = "Chart title", ylab = "y axis label", xlab = "x axis label")
qqline(df$var)


## ## ## ## ## ## ##
## ## ggplot2  ## ##
## ## ## ## ## ## ##

library(ggplot2)

### scatter plot ###
ggplot(df = data, aes(x = xvar, y = yvar)) + geom_point() # if categorical, factor(xvar) treats xvar as factor, not continuous
ggplot(df, aes(xvar, yvar, size = sizevar)) + geom_point() # or geom_point(size=sizevar)
ggplot(df, aes(xvar, yvar, shape = catvar)) + geom_point(size = 5) # points sized 5 and different shapes for each catvar categories
ggplot(df, aes(xvar, yvar, col = catvar)) + geom_point(size = 5) # points sized 5 and different colors for each catvar categories
ggplot(df, aes(xvar, yvar, shape = catvar, linetype = catvar)) + geom_point(size = 5) + geom_smooth(method = "lm") # adds regression lines for each catvar categories
ggplot(df, aes(xvar, yvar, shape = catvar, linetype = catvar)) + geom_point(size = 5) + geom_smooth(method = "lm") + facet_grid(rowvar ~ colvar) # separated in rows by rowvar and in columns by colvar
#ggplot() + geom_point(df = dataframe, aes(xvar, yvar, shape = catvar)) + geom_smooth(data = df, aes(xvar, yvar), method = "lm") + facet_grid(rowvar ~ colvar)
ggplot(df, aes(xvar, yvar)) + geom_point() + labs(title="title", x="x label", y="y label") + theme(plot.title = element_text(size = rel(2.5))) # adds labels title title, x and y axis, and increase size of title by 2.5 times
ggplot(df, aes(xvar, yvar)) + geom_point() + theme_bw() # black and white theme
my_bw <- theme_bw() + theme(plot.title = element_text(size = rel(2.5)), panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(), panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank()) # creates a new theme of whiteness and larger title font size, which can be used for ggplots --see next line
ggplot(df, aes(xvar, yvar)) + geom_point() + my_bw # using customized my_bw theme --see previous line

ggplot(df, aes(xvar, yvar, size = var)) + # aes (global) options: x, y, col, size, fill, alpha, label, group, and shape
  geom_point(alpha = .4, size = 3, aes(size = var)) + # other (local) options: shape, size, label (e.g. label="x"), alpha (transparency level), position = "jitter" / position_jitter(width=.1) adds noise to data points and used for when data points overlap each other
  geom_point(data = df2, size = 5, shape = 15) + # to add another layer of geom from another data frame
  geom_jitter() + # adds noise to data points and used for when data points overlap each other
  geom_text() + # when option label is used in aes() call within ggplot()
  geom_smooth(method = "lm", se = F, fullrange = T) + # other methods: "glm","gmm"-- multiple linear lines if size, shape or color specified in aes() call within ggplot()
  geom_smooth(method = "lm", se = F, linetype = 2, aes(group = 1)) + # aes(group=1) draws a single line for all data irrespective of size, shape or color which is specified in aes() call within ggplot(); in its absence, each category of colvar will have separate fitted lines
  facet_grid(. ~ facetvar) + # separates plots for each facet of facetvar, but share same y-axis. recommended for facetvar with limited categories
  labs(title = "graph title", x = "x label", y = "y label", col = "colvar") + # or use ggtitle("graph title") + xlab("x label") + ylab("y label")
  scale_x_continuous("continuous x-axis label", limits = c(2,3), breaks = seq(2,8,3), expand = c(0,0)) + # 
  scale_color_discrete("something", labels = c("this", "that", "there")) + # 
  scale_fill_manual("legend title", values = c("red", "blue"), lab = c("legend cat1", "legend cat2")) + 
  scale_color_manual("legend title", values = c("black", "yellow"), lab = c("category1", "category2")) + 
  scale_color_gradient(low = "yellow", high = "red", name = "Legend title") + # or: colors = brewer.pal(9, "YlOrRd")
  stat_quantile(quantiles = .5) + #
  stat_sum() + # calculates the count for each group
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = .1) + # options: fun.data="mean_cl_normal"; geom="point","linerange" -- see smean.sdl() from Hmisc package
  stat_summary(fun.y = mean, geom = "bar", fill = "skyblue") #


### barplots ###
# histogram: frequency, density, binning
ggplot(df, aes(x = var, y = ..density.., fill = fillvar)) + # fill colors categories of fillvar "stack"ed on top of each other
  geom_histogram(binwidth = .1, position = "stack") + # options: position="dodge","fill", col="", fill=""
  geom_freqpoly(binwidth = .1)

ggplot(df, aes(var)) + 
  geom_bar(stat = "bin", fill = "grey50") + # options: stat="identity", alpha
  geom_errorbar(aes(ymin = avg - stdv, ymax = avg + stdv, width = .2))

ggplot(df, aes(var, fill = fillvar)) + 
  geom_bar(position = position_dodge(.2), alpha = .6) + # options: position="dodge","fill","stack","identity"
  scale_fill_brewer(palette = "Set1")

ggplot(df, aes(xyz = var)) + geom_bar() # barchart of frequencies of var, with x-axis label = xyz
ggplot(df, aes(xvar, fill = yvar)) + geom_bar() # barchart of xvar stacked with categories of yvar = geom_bar(position = "stack")
ggplot(df, aes(xvar, fill = yvar)) + geom_bar(position = "stack") # stacked with categories of yvar
ggplot(df, aes(xvar, fill = yvar)) + geom_bar(position = "dodge") # side-by-side with categories of yvar
ggplot(df, aes(xvar)) + geom_bar() + facet_grid(yvar ~ .) # barchart of xvar for each category of yvar in separate rows
ggplot(df, aes(xvar)) + geom_bar() + facet_grid(. ~ yvar) # barchart of xvar for each category of yvar in separate columns
#library("RColorBrewer")
display.brewer.all(n=4) # show color patterns for four categories
ggplot(df, aes(xvar, fill = yvar)) + geom_bar(position = "stack") + scale_fill_brewer(palette = "Set1") # use custom colors

ggplot(df, aes(xvar, yvar, fill = factor(fillvar))) + 
  geom_bar(position = "dodge") + # or position= "stack", "fill", 
  scale_x_discrete("categorical x-axis label") + #
  scale_y_continuous("continuous y-axis label") +
  scale_fill_manual("legend title", values = c("#E41A1C", "#377EB8"), lab = c("legend cat1", "legend cat2")) + 
  facet_grid(. ~ facetvar) + 
  stat_function(fun = dnorm, col = "red", arg = list(mean = mean(df$var), sd = sd(df$var))) + # plots a normal distribution line on top of the barplot
  geom_rug() # adds black tick marks in the bottom of the bar plot, which is handy


### line plot ###
ggplot(df, aes(xvar, yvar, col = colvar)) + # options: linetype = var, size = var, fill = var (use with geom_area)
  geom_line(aes(group = groupvar), alpha = .3) + # options: 
  geom_area(position = "fill") + # options: position="fill" (use with fill=var in aes() call in ggplot)
  geom_ribbon(aes(ymax = capture, ymin = 0), alpha = .3) + # use when fill=var in aes() call in ggplot is used
  geom_rect(data = df2, inherit.aes = F, aes(xmin = begin, xmax = end, ymin = -Inf, ymax = Inf), fill = "red", alpha = .2) + # adding another layer of e.g. recession periods on top of line graph
  geom_smooth(lwd = 2, se = F) + # adds smoothing line
  xlim(lim1, lim2) + # limits the x axis range and plots between lim1 and lim2
  ylim(lim1, lim2) # limits the y axis range and plots between lim1 and lim2

### date plots ###
ggplot(df, aes(x, y)) + geom_line() + 
  xlim(as.Date("2001-01-01"), as.Date("2002-01-01")) + #limits date to between Jan 1, 2001 and Jan 2, 2002
  scale_x_date(date_breaks = "1 years", date_labels = "%Y")


### qq-plot ###
# there is no way to directly plot qq-plot with ggplot2, so we have to make our own
df$slope <- diff(quantile(df$var, c(.25, .75))) / diff(qnorm(c(.25, .75)))
df$int <- quantile(df$var, .25) - df$slope * qnorm(.25)
ggplot(df, aes(sample = var)) + stat_qq() + geom_abline(aes(slope = slope, intercept = int), col = "red")


# boxplot
ggplot(df, aes(xvar, yvar)) + geom_boxplot() + geom_point() # xvar is categorical and yvar is continuous
ggplot(df, aes(xvar, yvar)) + geom_boxplot() + geom_point() + facet_grid(. ~ catvar) # separated horizontally by catvar categories

  

### qplots ###
qplot(xvar, yvar, data = df, size = 3, col = colvar, 
      shape = shapevar, position = "jitter", geom = "jitter", 
      position = position_jitter(.1), alpha = I(.5))


##### Interactive graphics: packages: iplots, ggvis
##### Graphics resources: http://R-Bloggers.com, http://ggplot2.org, http://groups.google.com/group/ggplot2, Hadley Wickham's book Elegant Graphics for Data Analysis, Muenchen and Hilbe's book R for Stata Users


ggplot(as.data.frame(prop.table(table(df$var))), 
      aes(x=Var1, y = Freq, 
      label=sprintf("%0.2f", round(Freq, digits = 2)))) + 
      geom_bar(stat="identity", fill='grey', colour = 'black') + 
      labs(x="p1price", y="Frequency") + 
      geom_text(size = 3, hjust=1.2) + coord_flip()



## ridgeline plot (formerly known as joyplot): http://blog.revolutionanalytics.com/2017/07/joyplots.html
# library(ggridges)
ggplot(df, aes(x = max_temp, y = month, height = ..density..)) +
  geom_density_ridges(stat = "density")





## ## ## ## ## ## ## ##
##### ggvis static ####
## ## ## ## ## ## ## ##

library(ggvis)
#If you set or map a property inside ggvis() it will be applied globally , every layer in the graph will use the property. 
#If you set or map a property inside a layer_<marks>() function it will be applied locally: only the layer created by the function will use the property. 
#Where applicable, local properties will override global properties.
ggvis(df, ~xvar, ~yvar, fill := "blue") %>% # fill=~fillvar, size=~sizevar
  layer_points(opacity := .5, stroke := "black", shape := "diamond") %>% # others: strokeOpacity, andstrokeWidth
  add_axis("y", title = "yaxis title", values = c(2,3,4,5), subdivide = 9, orient = "left") %>% # other orient: "bottom","right","top"
  add_legend("fill", title = "legend title", orient = "right") %>% #example: add_legend(c("fill", "shape", "size"), title = "~ duration (m)")
  layer_lines(stroke := "blue", strokeWidth := 3, strokeDash := 6) %>% # others: strokeOpacity, fill
  layer_paths(fill := "darkorange") %>% # similar to lines, but useful when order dots is relevant, e.g. maps. layer_lines() options applies
  layer_smooths() %>% # does the job of compute_model_prediction + ggvis layer_lines
  layer_histograms(width = 5) %>% # with xvar only
  layer_densities(fill := "green") %>% #this creates a density plot, and used instead of histogram to present distribution of data
  layer_bars()  %>%
  layer_model_predictions(model = "lm", stroke := "navy") %>% #adds linear line
  scale_numeric("fill", range = c("red", "yellow")) %>% # scale of fill color from red to yellow, conditional that fill=~var is continuous
  scale_nominal("stroke", range = c("darkred", "orange")) %>% # scale of stroke color to darkred to orange, conditional that fill=~var has two categories
  scale_numeric("opacity", range = c(.2, 1)) %>% #opacity is the transparency of marks
  scale_numeric("x", domain = c(0,6)) # to zoom in on the range of 0-6 on x-axis


#use group_by from dplyr to make group-by plots
df %>% group_by(var) %>% ggvis(~xvar, ~yvar, stroke = ~var) %>% layer_smooths()
df %>% group_by(var1,var2) %>% ggvis(~xvar, ~yvar, stroke = ~interaction(var1,var2)) %>% layer_smooths()

compute_count(df, ~var) %>% ggvis(x = ~x_, y = 0, y2 = ~count_, width = band()) %>% layer_rects() #= ggvis(df, ~var) %>% layer_bars()

# for regression
compute_model_prediction(df, depvar ~ indpvar, model = "lm") %>% #returns the x and y values of a line fitted to the data, model "loess" by default.
  ggvis(~pred_, ~resp_) %>% layer_lines() %>% layer_points()



## ## ## ## ## ## ## ## ## ##
##### ggvis interactive #####
## ## ## ## ## ## ## ## ## ##

### examples: 
#also input_checkbox() input_checkboxgroup()

## 1. input_select double
faithful %>%
  ggvis(~waiting, ~eruptions, fillOpacity := 0.5,
        shape := input_select(label = "Choose shape:",
                              choices = c("circle", "square", "cross",
                                          "diamond", "triangle-up", "triangle-down")),
        fill := input_select(label = "Choose color:", 
                             choices = c("black", "red", "blue", "green"))) %>%
  layer_points()

## 2. input_radiobuttons
df %>%
  ggvis(~var1, ~var2,
        fill := input_radiobuttons(label = "Choose color:", 
                                   choices = c("black", "red", "blue", "green"))) %>%
  layer_points()

## 3. input_text
mtcars %>%
  ggvis(~mpg, ~wt,
        fill := input_text(label = "Choose color:",
                           value = "black")) %>%
  layer_points()

## 4. map = as.name
mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill = input_select(label = "Choose fill variable:", 
                            choices = names(mtcars), map = as.name)) %>% 
  layer_points()

## 5. input_numeric with default value = 1
df %>% 
  ggvis(~var) %>% 
  layer_histograms(width = input_numeric(label = "Choose a binwidth:", value = 1))

## 6. input_slider with min and max values
df %>% 
  ggvis(~var) %>% 
  layer_histograms(width = input_slider(label = "Choose a binwidth:", min = 1, max = 100))



## ## ## ## ## ## ## ## ## ##
#### plotly interactive #####
## ## ## ## ## ## ## ## ## ##

library(plotly)
plot_ly(df, x = xvar, y = yvar, mode = "markers") #mode = "lines"


library(leaflet)






#for SAP
leave <- data.table(region = c("CENTRAL/ KABUL", "EAST", "SOUTH EAST", "WEST", "NORTH EAST", "CENTRAL/ HAZARAJAT", "NORTH WEST", "CENTRAL/ KABUL"),
                    leave = c(36.14, 25.78, 29.25, 17.77, 22.98, 37.08, 28.70, 28.99))


