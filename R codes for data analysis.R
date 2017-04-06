######### Data analysis #########
 ########## # # # # # #########

## one-way tabulation
table(dataframe$var)
prop.table(table(dataframe$var))
cumsum(prop.table(table(dataframe$var)))
diag(table(var1,var2))

## two-way tabulation
table(dataframe$var1, dataframe$var2)
prop.table(table(dataframe$var1, dataframe$var2))
addmargins(table(data$var1, data$var2))

Deducer::frequencies(select(dataframe, var1, var2))

library("gmodels")
CrossTable(var1, var2, chisq = T, format = "SPSS") # or "SPSS"
CrossTable(var1, var2, prop.r = T, prop.c = T, prop.t = T, chisq = T, format = "SAS") # prop.r = row proportion

chisq.test(table(data$var1, data$var2)) # var2 should have only two categories, like gender
summary(table(data$var1, data$var2)) # provides Pearson's Chi-Squared test, number of observations and number of factors

## descriptive statistics
summary(dataframe$var)
summary(dataframe[dataframe$var == 1, ]) # Stata: sum * if var==1
summary(filter(dataframe, var==1)) # Stata: sum * if var==1
summary(subset(dataframe$var1, var2 == 1)) # Stata: sum var1 if var2==1

mean(data$var)
median(df$var)
sd(df$var)
max(df$var)
min(df$var)
quantile(df$var, probs = .05) #5th percentile

rowMeans(dataframe, na.rm = T)
rowSums(dataframe, na.rm = T)
colMeans(dataframe, na.rm = T)
colSums(dataframe, na.rm = T)

summary(dataframe, contains("var"), na.rm = T) # returns summary statistics for variables whose name contains "var"

by(data$var1, data$var2, mean, na.rm = T) #mean of var1 for categories of var2
by(data$var1, data$var2, var, na.rm = T) #Stata: tab var2, sum(var1)

library("Rcmdr")
numSummary(select(dataframe, var1:var3), statistics = c("mean", "sd", "cv", "quantiles"), quantiles = c(0, .5, 1))

library("Hmisc")
describe(dataframe) # or dataframe$var

## correlation and covariance
cov(dataframe$var1, dataframe$var2)
cor(dataframe$var1, dataframe$var2)
cor(select(data, var1:var4), method = "pearson", use = "pairwise") #pairwise correlation of var1 through var4
cor.test(data$var1, data$var4, use = "pairwise") #pairwise correlation with p-value. also use = "pearson"

library("Rcmdr")
rcorr.adjust(select(data, var1:var4), type = "pearson")

### regression
#y ~ x simple regression, y ~ -1 + x without intercept, y ~ . add all vars in the right-hand side
#interaction: y ~ x1 + x2 + x1:x2 or y ~ x1*x2 or y ~ (x1+x2)^2
#polynomial: y ~ x + I(x^2) + I(x^3) or y ~ poly(x,3)
lm_model <- lm(y ~ x1 + x2 + x3, data = dataframe)
summary(lm_model)
anova(lm_model)
plot(lm_model)
predict(lm_model, newdata) #makes prediction based on lm_model on newdata. predict() can be used with regression tree, nueral network, etc. as well


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
#car: companion to applied regression
#library(car)
leveneTest(var, factorvar) #anova test that variance of categories of factorvar is different
#parametric
summary(aov(var, factorvar))
#nonparametric
kruskal.test(var, factor)



