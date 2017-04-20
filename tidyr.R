### tidyr

library(tidyr)

# long and wide data
df <- data.frame(id = c("x", "y"), a = c(2,3), b = c(4,6), c = c(2,5))
long_df <- gather(df, colnamevar, valuevar, -id) # -id indicates we want to gather all columns except variable id. we can specify list of columns to gather without minus sign
wide_df <- spread(long_df, colnamevar, valuevar)

# seperate and unite columns/variables
df <- data.frame(id = rep(c("x","y"),times=3), 
                 treatment = rep(c("A","B","C"),each=2), 
                 yr_mo = rep(c("2010-10","2012-08","2014-06"),each=2), 
                 response = c(2,5,4,2,5,2))
df <- separate(df, col = yr_mo, into = c("year","month"), sep = "-") #separate yr_mo into "year" and "month" variables. separate uses non-alpha-numeric character like space, -, _, /, ., etc.
df <- unite(df, year_mo, year, month, sep = "-") #more than two variables can be joined

glimpse(df)


