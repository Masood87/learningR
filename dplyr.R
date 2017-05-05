library(dplyr)

# select and mutate manipulates variables
# filter and arrange manipulates obs
# summarize manipulate groups

glimpse(df) # improved version of str() to display the structure of a data.frame
tbl_df(df) # nice way to display data.frame


select(df, var1, var11:var15) #select a subset of var1, var11 through var15 frome df
select(df, 1:5, 11) #select a subsect of 1st through fifth and 11th columns in df
select(df, starts_with("a"), #every name that starts with "a"
       ends_with("y"), #every name that ends with "y"
       contains("x"), #every name that contains "x"
       matches("hi"), #every name that matches "hi", where "hi" can be a regular expression
       num_range("x", 1:5), #the variables named x01, x02, x03, x04 and x05
       one_of(x)) #every name that appears in x, which should be a character vector


mutate(df, newvar1 = var1 - var2, newvar2 = var1 * var2) # creats new variables. other math functions applicable too
#creating a categorical variable from continous/discrete variable
mutate(data, newvar = ifelse(var<30, "label1", ifelse(var<50, "label2", "label3")))


## logical comparison: ==, <, >, <=, >=, !=, is.na, !is.na, "x" %in% c("a", "b", "c") means x is in the vector c("a", "b", "c")
filter(df, var == "f" | var == "m") # or: filter(df, var %in% c("f", "m"))


arrange(df, var1, var2) # Ascending order -- Stata: sort var1 var2
arrange(df, var1, desc(var2)) #ascending var and descending var2


summarise(df, sum = sum(x)) #others: mean(x), median(x), var(x), min(x), max(x), sd(X), length(x), IQR(x), first(x), last(x), nth(x, n), n(x), n_distinct(x), quantile(x,p)


group_by(df, groupvar) %>% summarise(n = n(), avg = mean(x)) #frequency and mean of x for each categories of groupvar


mutate_each(df, funs(as.numeric), -id)


