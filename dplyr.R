library(dplyr)

# select and mutate manipulates variables
# filter and arrange manipulates obs
# summarize manipulate groups

# select() returns a subset of the columns
# filter() returns a subset of the rows
# arrange() reorders the rows according to single or multiple variables
# mutate() adds columns from existing data
# summarise() reduces each group to a single row by calculating aggregate measures

glimpse(df) # improved version of str() to display the structure of a data.frame
tbl_df(df) # nice way to display data.frame

count(df, var1, var2) #calculate frequency of combination for categories of var1 and var2

select(df, var1, var11:var15) #select a subset of var1, var11 through var15 from df
select(df, 1:5, -4) #select 1st through fifth columns excluding 4th
select(df, starts_with("a"), #every name that starts with "a"
       ends_with("y"), #every name that ends with "y"
       contains("x"), #every name that contains "x"
       matches("hi"), #every name that matches "hi", where "hi" can be a regular expression
       num_range("x", 1:5), #the variables named x01, x02, x03, x04 and x05
       one_of(x)) #every name that appears in x, which should be a character vector


mutate(df, newvar1 = var1 - var2, newvar2 = newvar1 * var2) # creats new variables. other math functions applicable too
mutate(data, newvar = ifelse(var<30, "label1", ifelse(var<50, "label2", "label3")))#creating a categorical variable from continous/discrete variable


## logical comparison: ==, <, >, <=, >=, !=, is.na, !is.na, "x" %in% c("a", "b", "c") means x is in the vector c("a", "b", "c")
filter(df, var == "f" | var == "m") # or: filter(df, var %in% c("f", "m"))


arrange(df, var1, var2) # Ascending order -- Stata: sort var1 var2
arrange(df, var1, desc(var2)) #ascending var and descending var2
arrange(df, var1+var2) #allows ordering by the sum of two variables. More math functions allowed


summarise(df, sum = sum(x)) #others: mean(x), median(x), var(x), min(x), max(x), sd(X), length(x), IQR(x), quantile(x,p)
# first(x) - The first element of vector x.
# last(x) - The last element of vector x.
# nth(x, n) - The nth element of vector x.
# n() - The number of rows in the data.frame or group of observations that summarise() describes.
# n_distinct(x) - The number of unique values in vector x.

group_by(df, groupvar) %>% summarise(n = n(), avg = mean(x)) #frequency and mean of x for each categories of groupvar

mutate_each(df, funs(as.numeric), -id)

recode(vect, hi = "bye") #replace element of vect

inner_join(df1, df2, by = c("var1", "var2")) #merges two datasets by matching elements of var1 and var2 columns

# Joining Data with dplyr (merge in base). Datacamp course: Joining Data in R with dplyr
left_join(df1, df2, by = c("var1", "var2")) #(mutating join)
right_join(df2, df1, by = c("var1", "var2")) #(mutating join)
left_join(df1, df2, by = c("var1" = "var2")) #if keys have different names
inner_join() #most exclusive join. only matching rows. similar syntax to left_join... (mutating join)
full_join() #most inclusive join. all matching and not matching rows. similar syntax to left_join... (mutating join)
semi_join(df1, df2, by = "var") #returns rows in df1 that has match in df2, without joining them. similar syntax to left_join. can also be used instead of filter... (filtering join)
anti_join() #the opposite of semi_join()... (filtering join)

# Binding data sets
bind_rows() #binds two datasets with the same columns in the same order
bind_cols() #binds two datasets with the same rows in the same order
bind_rows(list, .id = "var") #combines a list of dataframes and creates a new variable var that indicate the element of the list

# Set operations. Datacamp course: Joining Data in R with dplyr
setequal(df1, df2) #checks if two dataframes have the exact rows (and columns), irrespective of order. Use identical() for checking order
union(df1, df2) #union of two df with same columns
intersect(df1, df2) #intersection of two df with same columns
setdiff(df1, df2) #returns df1 rows that are not in df2

rename(df, newname = oldname) #renames variable

data_frame()
as_data_frame()

