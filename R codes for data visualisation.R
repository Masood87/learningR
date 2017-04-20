############ Data Vis ############


## ## ## ## ## ##
##### Base-R  ###
## ## ## ## ## ##

### univariate charts
stripchart(df$var1)
barplot(prop.table(table(dataframe$var)))
hist(df$var)

## barplot
barplot(prop.table(table(dataframe$var1, dataframe$var2))) #cross-tab

## scatter plot
plot(yvar ~ xvar, data = df) # or plot(df$xvar, df$yvar)
plot(yvar ~ xvar, data = df, 
     pch = 19, # plot character
     cex = 2, # character expansion
     main = "Chart title", xlab = "x axis title", ylab = "y axis title", col = colvar) # colors based on colvar
grid() # adds a grid to plot

abline(c(33,44), lty = 1) # regression line of function y=33+44x. lty = line type
reg-estimate <- lm(y-continuous-var ~ x-continuous-var, data = dataframe)
abline(coefficients(reg-estimate))

ggvis(data, ~var1, ~var2) # library(ggvis)

## scatter plot matrix
pairs(formula = ~var1 + var2 + var3, data=dataframe)

## box plot
boxplot(dataframe$scatter-var, main = "Chart title", ylab = "y axis label", xlab = "x axis label", horizontal=TRUE, las = 1)
boxplot(dataframe$scatter-var ~ dataframe$cross-var1 + dataframe$cross-var2)

## Distribution of data using Q–Q plot (normal distribution)
qqnorm(dataframe$var, main = "Chart title", ylab = "y axis label", xlab = "x axis label")
qqline(dataframe$var)


## ## ## ## ## ##
#### ggplot2  ###
## ## ## ## ## ##

library(ggplot2)

### scatter plot ###
ggplot(data = data, aes(x = xvar, y = yvar)) + geom_point()
ggplot(data, aes(factor(xvar), yvar)) + geom_point() # factor(xvar) treats xvar as factor, not continuous
ggplot(data, aes(xvar, yvar, size = sizevar)) + geom_point() # size of points depend on value of sizevar
ggplot(data, aes(xvar, yvar, shape = catvar)) + geom_point(size = 5) # points sized 5 and different shapes for each catvar categories
ggplot(data, aes(xvar, yvar, col = catvar)) + geom_point(size = 5) # points sized 5 and different colors for each catvar categories
ggplot(data, aes(xvar, yvar, shape = catvar, linetype = catvar)) + geom_point(size = 5) + geom_smooth(method = "lm") # adds regression lines for each catvar categories
ggplot(data, aes(xvar, yvar, shape = catvar, linetype = catvar)) + geom_point(size = 5) + geom_smooth(method = "lm") + facet_grid(rowvar ~ colvar) # separated in rows by rowvar and in columns by colvar
#ggplot() + geom_point(data = dataframe, aes(xvar, yvar, shape = catvar)) + geom_smooth(data = dataframe, aes(xvar, yvar), method = "lm") + facet_grid(rowvar ~ colvar)
ggplot(data, aes(xvar, yvar)) + geom_point() + labs(title="title", x="x label", y="y label") + theme(plot.title = element_text(size = rel(2.5))) # adds labels title title, x and y axis, and increase size of title by 2.5 times
ggplot(data, aes(xvar, yvar)) + geom_point() + theme_bw() # black and white theme
my_bw <- theme_bw() + theme(plot.title = element_text(size = rel(2.5)), panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(), panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank()) # creates a new theme of whiteness and larger title font size, which can be used for ggplots --see next line
ggplot(data, aes(xvar, yvar)) + geom_point() + my_bw # using customized my_bw theme --see previous line

ggplot(df, aes(xvar, yvar, size = var)) + # aes options: x, y, col, size, fill, alpha, label, group, and shape
  geom_point(alpha = .4, size = 3, aes(size = var)) + # other options: shape, size, label (e.g. label="x"), alpha (transparency level), position = "jitter" / position_jitter(width=.1) adds noise to data points and used for when data points overlap each other
  geom_point(data = df2, size = 5, shape = 15) + # to add another layer of geom from another data frame
  geom_jitter() + # adds noise to data points and used for when data points overlap each other
  geom_text() + # when option label is used in aes() call within ggplot()
  geom_smooth(method = "lm", se = F, fullrange = T) + # other methods: "glm","gmm"-- multiple linear lines if size, shape or color specified in aes() call within ggplot()
  geom_smooth(method = "lm", se = F, linetype = 2, aes(group = 1)) + # aes(group=1) draws a single line for all data irrespective of size, shape or color which is specified in aes() call within ggplot(); in its absence, each category of colvar will have separate fitted lines
  facet_grid(. ~ facetvar) + # separates plots for each facet of facetvar, but share same y-axis. recommended for facetvar with limited categories
  labs(x = "x label", y = "y label", col = "colvar") + 
  scale_x_continuous("continuous x-axis label", limits = c(2,3), breaks = seq(2,8,3), expand = c(0,0)) + # 
  scale_color_discrete("something", labels = c("this", "that", "there")) + # 
  scale_fill_manual("legend title", values = c("red", "blue"), lab = c("legend cat1", "legend cat2")) + 
  scale_color_manual("legend title", values = c("black", "yellow"), lab = c("category1", "category2")) + 
  scale_color_gradient(colors = brewer.pal(9, "YlOrRd")) + 
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

ggplot(dataframe, aes(xyz = var)) + geom_bar() # barchart of frequencies of var, with x-axis label = xyz
ggplot(dataframe, aes(xvar, fill = yvar)) + geom_bar() # barchart of xvar stacked with categories of yvar = geom_bar(position = "stack")
ggplot(dataframe, aes(xvar, fill = yvar)) + geom_bar(position = "stack") # stacked with categories of yvar
ggplot(dataframe, aes(xvar, fill = yvar)) + geom_bar(position = "dodge") # side-by-side with categories of yvar
ggplot(dataframe, aes(xvar)) + geom_bar() + facet_grid(yvar ~ .) # barchart of xvar for each category of yvar in separate rows
ggplot(dataframe, aes(xvar)) + geom_bar() + facet_grid(. ~ yvar) # barchart of xvar for each category of yvar in separate columns
#library("RColorBrewer")
display.brewer.all(n=4) # show color patterns for four categories
ggplot(dataframe, aes(xvar, fill = yvar)) + geom_bar(position = "stack") + scale_fill_brewer(palette = "Set1") # use custom colors

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
  geom_smooth(lwd = 2, se = F) # adds smoothing line


### qq-plot ###
# there is no way to directly plot qq-plot with ggplot2, so we have to make our own
df$slope <- diff(quantile(df$var, c(.25, .75))) / diff(qnorm(c(.25, .75)))
df$int <- quantile(df$var, .25) - df$slope * qnorm(.25)
ggplot(df, aes(sample = var)) + stat_qq() + geom_abline(aes(slope = slope, intercept = int), col = "red")


# boxplot
ggplot(dataframe, aes(xvar, yvar)) + geom_boxplot() + geom_point() # xvar is categorical and yvar is continuous
ggplot(dataframe, aes(xvar, yvar)) + geom_boxplot() + geom_point() + facet_grid(. ~ catvar) # separated horizontally by catvar categories

  

### qplots ###
qplot(xvar, yvar, data = df, size = 3, col = colvar, 
      shape = shapevar, position = "jitter", geom = "jitter", 
      position = position_jitter(.1), alpha = I(.5))


##### Interactive graphics: packages: iplots, ggvis
##### Graphics resources: http://R-Bloggers.com, http://ggplot2.org, http://groups.google.com/group/ggplot2, Hadley Wickham's book Elegant Graphics for Data Analysis, Muenchen and Hilbe's book R for Stata Users


ggplot(as.data.frame(prop.table(table(dataframe$var-name))), 
      aes(x=Var1, y = Freq, 
      label=sprintf("%0.2f", round(Freq, digits = 2)))) + 
      geom_bar(stat="identity", fill='grey', colour = 'black') + 
      labs(x="p1price", y="Frequency") + 
      geom_text(size = 3, hjust=1.2)+coord_flip()








