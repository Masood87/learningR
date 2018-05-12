######### Data analysis #########
 ########## # # # # # #########

## one-way tabulation
table(df$var)
count(df, var) #library(dplyr)
prop.table(table(df$var))
cumsum(prop.table(table(dataframe$var)))
count(group_by(data, var)) #library(dplyr)

## two-way tabulation
table(df$var1, df$var2)
prop.table(table(df$var1, df$var2))
addmargins(table(df$var1, df$var2))
count(df, var1, var2) %>% spread(var2, n) #library(dplyr) and library(tidyr)
count(df, var1, var2) %>% spread(var2, n) %>% mutate(ratio = cat1/(cat1 + cat2)) #creates a column for a ratio of those in cat1

#Deducer::frequencies(select(df, var1, var2))

library("gmodels")
CrossTable(var1, var2, chisq = T, format = "SPSS") # or "SPSS"
CrossTable(var1, var2, prop.r = T, prop.c = T, prop.t = T, chisq = T, format = "SAS") # prop.r = row proportion

chisq.test(table(df$var1, df$var2)) # var2 should have only two categories, like gender
summary(table(df$var1, df$var2)) # provides Pearson's Chi-Squared test, number of observations and number of factors

## descriptive statistics
summary(dataframe$var)
summary(dataframe[dataframe$var == 1, ]) # Stata: sum * if var==1
summary(filter(dataframe, var==1)) # Stata: sum * if var==1
summary(subset(dataframe$var1, var2 == 1)) # Stata: sum var1 if var2==1

mean(df$var)
median(df$var)
sd(df$var)
max(df$var)
min(df$var)
quantile(df$var, probs = .05) #5th percentile
range(vector) #elements will be min and max of vector

rowMeans(dataframe, na.rm = T)
rowSums(dataframe, na.rm = T)
colMeans(dataframe, na.rm = T)
colSums(dataframe, na.rm = T)
sapply(dataframe, sum, na.rm = T)  # the same as colSum(df, na.rm = T)

summary(dataframe, contains("var"), na.rm = T) # returns summary statistics for variables whose name contains "var"

by(data$var1, data$var2, mean, na.rm = T) #mean of var1 for categories of var2
by(data$var1, data$var2, var, na.rm = T) #Stata: tab var2, sum(var1)

library("Rcmdr")
numSummary(select(dataframe, var1:var3), statistics = c("mean", "sd", "cv", "quantiles"), quantiles = c(0, .5, 1))

library("Hmisc")
describe(dataframe) # or dataframe$var
smean.sd(df$var) #mean and sd
smean.sdl(df$var, 2) # computes the mean plus or minus a constant times the standard deviation
smean.cl.normal(df$var) # returns mean, upper and lower 95% confidence interval

library(ggplot2)
mean_sdl(df$var) # mean and sd
mean_cl_normal(df$var) # mean and 95% CI

#using tapply
freq <- tapply(data[,5], data[,1], length)
mean <- tapply(data[[5]], data[[1]], mean)
sd <- tapply(data[[5]], data[[1]], sd)
total <- tapply(data[[5]], data[[1]], sum)
summarydata <- data.frame(freq, mean, sd, total)

tapply(data[[5]], data[[c(2,3)]], mean) #this is cross-tab of col 2 and 3 with mean of col 5. >by() is similar to tapply()?
aggregate(var5 ~ var2 + var3, data, mean)

# correlation and covariance
cov(dataframe$var1, dataframe$var2)
cor(dataframe$var1, dataframe$var2)
cor(select(data, var1:var4), method = "pearson", use = "pairwise") #pairwise correlation of var1 through var4
cor.test(data$var1, data$var4, use = "pairwise") #pairwise correlation with p-value. also use = "pearson"

### visualize correlation using qgraph
require(qgraph)
qgraph(cor(mtcars))
qgraph.pca(cor(mtcars), factors = 3) # arrows indicate loading on the PCA factors


library("Rcmdr")
rcorr.adjust(select(data, var1:var4), type = "pearson")

### Linear regression
#y ~ x simple regression, y ~ -1 + x without intercept, y ~ . add all vars in the right-hand side
#interaction: y ~ x1 + x2 + x1:x2 or y ~ x1*x2 or y ~ (x1+x2)^2
#polynomial: y ~ x + I(x^2) + I(x^3) or y ~ poly(x,3)
lm_model <- lm(y ~ x1 + x2 + x3, data = dataframe)
lm_model <- lm(y ~ . - x3, data = dataframe)

# result of regression
summary(lm_model)
fitted.values(lm_model) #vector of fitter values, y hat
residuals(lm_model) #vector of residuals
coef(lm_model) #coefficients
df.residual(lm_model) #degree of freedom

anova(lm_model)
plot(lm_model)

tidy(lm_model) #prepares a small tidy dataset with result of lm() from library(broom)
augment(lm_model) #returns a dataframe of variables, fitted values, residuals and others... library(broom)

# prediction
predict(lm_model, newdata) #makes prediction based on lm_model on newdata. newdata has to be data.frame and have the same y variable name. predict() can be used with regression tree, nueral network, etc. as well
augment(lm_model, newdata = new_data) #newdata has to be data.frame and have the same y variable name... library(brook)

compute_model_prediction(df, depvar ~ indpvar, model = "lm") #returns the x and y values of a line fitted to the data. other: model="loess"

# outliers: leverage and influence
# leverage: distance from the mean-- influence: high leverage and high residual (cook's distance)
augment(lm_model) %>% arrange(desc(.hat)) %>% head() # after augment(), .hat includes the leverage scores... require(broom)
augment(lm_model) %>% arrange(desc(.cooksd)) %>% head() #after augment(), .cooksd includes the influence/cook's distance... require(broom)


### binomial logistic regression
# coefficients are probability. Alternatives are odds ratio and log odds ratio.
# Most people tend to interpret the fitted values on the probabilities scale and the function on the log-odds scale. The interpretation of the coefficients is most commonly done on the odds scale.
# OR = odds(y|x + 1)/oss(y|x) = exp(beta_1)

glm_model <- glm(y ~ x1 + x2, data = df, family = "binomial")

augment(glm_model) #returns log odds scale for fitted values... we have to compute odds ratio or probabilities separately separately
augment(glm_model, type.predict = "response") # returns fitted values in probability scale

# out of sample prediction
newdata <- data.frame(x1 = 44, x2 = 1)
augment(glm_model, newdata = newdata, type.predict = "response") # returns prediction for new data using the parameters from glm_model

# 
ggplot() + geom_smooth(method = "glm", se = 0, color = "red", method.args = list(family = "binomial"))





### comparing groups
# for two independent groups
#parametric test
t.test(data$var ~ data$binaryvar) #one continuous one factor/binary
t.test(data$var1, data$var2, paired = T) #two matched groups
#Nonparametric tests are also called distribution-free tests because they don't assume that data follow a specific distribution. You could use nonparametric tests when data don't meet the assumptions of the parametric test, especially the assumption about normally distributed data.
wilcox.test(data$var ~ data$binaryvar)
wilcox.test(data$var1 ~ data$var2, paired = T)
#baysian method
library(devtools)
install_github("rasmusab/bayesian_first_aid")
library(BayesianFirstAid)
bayes.t.test(data$var ~ data$binaryvar)
bayes.t.test(data$var1 ~ data$var2, paired = T)

# bayes.cor.test(data$var1, data$var2, use = "pairwise")
# df <- data.frame(one = c(35,632,346,234,4562,346,234,4634,292,546,345), two = c(482,35,346,456,23,443,634,6,53,234,2345))

# ANOVA: if we compare more than two groups
#library(car) #companion to applied regression
leveneTest(var, factorvar) #leveneTest is an anova test whether variance of categories of factorvar is different
#parametric
summary(aov(var ~ factorvar))
#nonparametric
kruskal.test(var, factor)

# pair-wise T-Test
pairwise.t.test(var, factorvar)
thsd <- TukeyHSD(aov(var ~ factorvar, data = data), na.rm = T) # group/multiple comparisons of mean of categories
plot(thsd)

# Pairwise Wilcoxon Rank Sum Test







