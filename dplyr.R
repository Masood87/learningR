library(dplyr)

# select and mutate manipulates variables
# filter and arrange manipulates obs
# summarize manipulate groups

glimpse(df)
tbl_df(dataFrame) # nice way to display data.frame


select(df, gender, q1:q5) #make a subset of gender, q1 through q5 in df
select(df, 1:5, 11) #select 1st through fifth and 11th variables in df
select(df, starts_with("a"), #every name that starts with "X"
       ends_with("y"), #every name that ends with "X"
       contains("x"), #every name that contains "X"
       matches("hi"), #every name that matches "X", where "X" can be a regular expression
       num_range("x", 1:5), #the variables named x01, x02, x03, x04 and x05
       one_of(x)) #every name that appears in x, which should be a character vector


mutate(df, newvar1 = var1 - var2, newvar2 = var1 * var2) # other math functions too
#creating a categorical variable from continous/discrete variable
mutate(data, newvar = ifelse(var<30, "label1", ifelse(var<50, "label2", "label3")))


## logical comparison: ==, <, >, <=, >=, !=, is.na, !is.na, "x" %in% c("a", "b", "c") means x is in the vector c("a", "b", "c")
filter(df, var == "f" | var == "m") # or: filter(df, var %in% c("f", "m"))


arrange(df, var1, var2) # Ascending order -- Stata: sort var1 var2
arrange(df, var1, desc(var2)) #ascending var and descending var2


summarise(df, sum = sum(x)) #others: mean(x), median(x), var(x), min(x), max(x), sd(X), length(x), IQR(x), first(x), last(x), nth(x, n), n(x), n_distinct(x), quantile(x,p)


group_by(df, groupvar) %>% summarise(n = n(), avg = mean(x)) #frequency and mean of x for each categories of groupvar


mutate_each(df, funs(as.numeric), -id)


