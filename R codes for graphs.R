############ Graphics

## barplot
barplot(prop.table(table(dataframe$var-name)))
barplot(prop.table(table(dataframe$var1, dataframe$var2))) #cross-tab

## scatter plot
plot(x = dataframe$x-continuous-var, y = dataframe$y-continuous-var,
     pch = 19, # plot character
     cex = 2, # character expansion
     main = "Chart title", xlab = "x axis title", ylab = "y axis title")
grid() # adds a grid to plot

abline(c(33,44)) # regression line of function y=33+44x
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

###### ggplot
library(ggplot2)

# barplots
ggplot(dataframe, aes(xyz = var)) + geom_bar() # barchart of frequencies of var, with x-axis label = xyz
ggplot(dataframe, aes(xvar, fill = yvar)) + geom_bar() # barchart of xvar stacked with categories of yvar = geom_bar(position = "stack")
ggplot(dataframe, aes(xvar, fill = yvar)) + geom_bar(position = "stack") # stacked with categories of yvar
ggplot(dataframe, aes(xvar, fill = yvar)) + geom_bar(position = "dodge") # side-by-side with categories of yvar
ggplot(dataframe, aes(xvar)) + geom_bar() + facet_grid(yvar ~ .) # barchart of xvar for each category of yvar in separate rows
ggplot(dataframe, aes(xvar)) + geom_bar() + facet_grid(. ~ yvar) # barchart of xvar for each category of yvar in separate columns
#library("RColorBrewer")
display.brewer.all(n=4) # show color patterns for four categories
ggplot(dataframe, aes(xvar, fill = yvar)) + geom_bar(position = "stack") + scale_fill_brewer(palette = "Set1") # use custom colors

# boxplot
ggplot(dataframe, aes(xvar, yvar)) + geom_boxplot() + geom_point() # xvar is categorical and yvar is continuous
ggplot(dataframe, aes(xvar, yvar)) + geom_boxplot() + geom_point() + facet_grid(. ~ catvar) # separated horizontally by catvar categories

# scatter plot
ggplot(data = data, aes(x = xvar, y = yvar)) + geom_point()
ggplot(data, aes(xvar, yvar, shape = catvar)) + geom_point(size = 5) # points sized 5 and different shapes for each catvar categories
ggplot(data, aes(xvar, yvar, col = catvar)) + geom_point(size = 5) # points sized 5 and different colors for each catvar categories
ggplot(data, aes(xvar, yvar, shape = catvar, linetype = catvar)) + geom_point(size = 5) + geom_smooth(method = "lm") # adds regression lines for each catvar categories
ggplot(data, aes(xvar, yvar, shape = catvar, linetype = catvar)) + geom_point(size = 5) + geom_smooth(method = "lm") + facet_grid(rowvar ~ colvar) # separated in rows by rowvar and in columns by colvar
#ggplot() + geom_point(data = dataframe, aes(xvar, yvar, shape = catvar)) + geom_smooth(data = dataframe, aes(xvar, yvar), method = "lm") + facet_grid(rowvar ~ colvar)
ggplot(data, aes(xvar, yvar)) + geom_point() + labs(title="title", x="x label", y="y label") + theme(plot.title = element_text(size = rel(2.5))) # adds labels title title, x and y axis, and increase size of title by 2.5 times
ggplot(data, aes(xvar, yvar)) + geom_point() + theme_bw() # black and white theme
my_bw <- theme_bw() + theme(plot.title = element_text(size = rel(2.5)), panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(), panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank()) # creates a new theme of whiteness and larger title font size, which can be used for ggplots --see next line
ggplot(data, aes(xvar, yvar)) + geom_point() + my_bw # using customized my_bw theme --see previous line



##### Interactive graphics: packages: iplots, ggvis
##### Graphics resources: http://R-Bloggers.com, http://ggplot2.org, http://groups.google.com/group/ggplot2, Hadley Wickham's book Elegant Graphics for Data Analysis, Muenchen and Hilbe's book R for Stata Users





ggplot(as.data.frame(prop.table(table(dataframe$var-name))), 
      aes(x=Var1, y = Freq, 
      label=sprintf("%0.2f", round(Freq, digits = 2)))) + 
      geom_bar(stat="identity", fill='grey', colour = 'black') + 
      labs(x="p1price", y="Frequency") + 
      geom_text(size = 3, hjust=1.2)+coord_flip()



