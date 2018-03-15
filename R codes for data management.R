################################
####### Data Management ########
################################

rm(object)
rm(list=ls())
setwd("path")
getwd()
dir() #list name of files.extension in the working directory
attach(df) #Since I'm not loading other data frames, I can attach this data frame to type less :)
detach(df) #opposite of attach

### quick look at the data
dim(df) #dimensions of dataframe
str(df)
glimpse(df) #library(dplyr)
length(object)
summary(dataframe)
names(data)
head(data, n=11) #print top 11 obs
tail(data, n=11)
class(object)
typeof(object)
ls() #lists objects
ls.str() #lists objects and their structure. ls() + str()
tbl_df(df) # nice way to display data.frame

### is. and as.
is.na(object) #returns a logical vector whether missing value
is.list(listname) #returns a logic
as.data.frame(object) #reads object as data frame
as.list(object) #reads object as list
as.Date("2000-01-20", format = "%Y-%m-%d") #R default format for date is %Y-%m-%d, but we can use other formats such as "%Y-%d-%m"
sum(is.na(df$var)) #counts number of missing values
sum(!is.na(df$var)) #xounts number of non-missing values
sum(is.na(x) & is.na(y)) #returns how many obs both x and y have missing (NA)
x[is.na(x)] <- y #if x is missing, replace it with y


### dealing with missing values
is.na(object) #returns a logical vector whether missing value
any(is.na(object)) #returns TRUE if there is any missing in the data, FALSE otherwise
sum(is.na(object)) #tells number of missing values
which(is.na(df$var)) #return indix numbers of missing values
complete.cases(df) #returns logical vector, elements correspond to rows of df, FALSE if there is a missing in the row, TRUE otherwise.
df[complete.cases(df),] #keep rows with complete cases/without missing values
na.omit(df) #automatically removes cases/rows with missing values


###
ncol(data) #number of columns/variables
nrow(data) #number of rows
vector <- vector("double", 44) #creates empty vector double with 44 elements. other options: "integer", "logical", "character"
range(vector) #elements will be min and max of vector
args(x)
tolower() #lowercase
cleaned_data <- na.omit(data_unclean) #removes all obs with missing values (NA)
levels(df$factorvar) #provides the levels of a factor variable
data$var <- droplevels(data$var) #in factor variable, drops/ removes all levels with 0 obs/count
paste("var", 1:5, sep = "-") #creates var-1, var-2, var-3, var-4, var-5
paste0("var", 1:5) #creates var1, var2, var3, var4, var5
cat("text", mean(var)) #concatenate and print
seq_along(data) #returns a vector of sequential numbers equal to elements of df or vector
arrange(var1, var2) #from dplyr. Stata: sort var1 var2
rank(var) #ranks the elements of var alphabetically or numerically
abs(var) #absolute values of var
round(var,1) #rounds to one decimal
append(object, anything) #appends anything to an object and creates a list. Except if object=vector and anything=num, then output=vector
rev(object) #orders reverse of elements of object such as list, vector or data frame
strsplit(vector, split = " ") #splits elements of vector by space, and output a list of vectors
diff(vect) #difference between elements of a numerical or date vector
x <- list(a = 1, b = list(c = 3, d = 4)) #to refer to an element of a list within list: x[[c("b","c")]] or x[[c(2,1)]]
mutate_each(df, funs(as.numeric), var4:var10) #changes class to numeric for variables var4 through var10
count(diamonds, cut, clarity, color) #return count of each combination in dataset diamonds

### transforming data
t(obj) #generic function to transpose
t.data.frame(df) #transposes the dataframe
aggregate(var1 ~ byvar, FUN = sum, data = df)


### regular expressions (?regex)
# Since regular expressions can be tricky, here is a quick refresher:
# Metacharacters allow you to match certain types of characters. For example, . means any single character, ^ means "begins with", and $ means "ends with".
# If you want to use any of the metacharacters as actual text, you need to use the \\ escape sequence.
grep(pattern = "a", x = vect) #returns numeric vector of indices of elements of vect that has "a" in them
grep(pattern = "^a", x = vect) #returns numeric vector of indices of elements of vect that starts with "a"
grep(pattern = "a$", x = vect) #returns numeric vector of indices of elements of vect that ends with "a"
grepl(pattern = "a", x = vect) #returns logical vector for elements of vect that has "a" in them
which(grepl(pattern = "a", x = vect)) #the same as grep(pattern = "a", x = vect)
grepl(pattern = "^a", x = vect) #returns logical vector for elements of vect that starts with "a"
grepl(pattern = "a$", x = vect) #returns logical vector for elements of vect that ends with "a"
sub(pattern = "a", replacement = "b", vect) #substitutes / replaces "a" to "b" in elements of vect, but only the first "a". If there are more then use gsub
gsub(pattern = "a", replacement = "b", vect) #substitutes / replaces all "a" to "b" in elements of vect
gsub(pattern = "a|o", replacement = "b", vect) #substitutes / replaces all "a" and "o" with "b" in elements of vect
grepl("\\d{3,}", x) #checks if a string x contains 3 or more digits in a row


### meta characters
grepl(pattern = "@.*\\.edu", x = vect) #checks if an email that include @ ends with ".edu". ".*" matches any character (.) zero or more times (*). \\.edu$, to match the ".edu" part of the email at the end of the string. The \\ part escapes the dot: tells R that you want to use the . as an actual character.
# .*: A usual suspect! It can be read as "any character that is matched zero or more times"
# \\s: Match a space. The "s" is normally a character, escaping it (\\) makes it a metacharacter.
# [0-9]+: Match the numbers 0 to 9, at least once (+).
# ([0-9]+): The parentheses are used to make parts of the matching string available to define the replacement. The \\1 in the replacement argument of sub() gets set to the string that is captured by the regular expression [0-9]+.


### constructing data
diag(x = c(1,2,3), 3,3) #creates a 3x3 matrix with diagonal of 1, 2 and 3
seq(from = 100, to = 11, by = -10) # or seq(2,8,3)
rep(3:6, times = 5) #creates a vector of 3 to 6 repeated 5 times
sort(rep(3:6, times = 2), decreasing = TRUE) #orders the vector of 3 to 6 repeated 5 times (6,6,5,5,4,4,3,3)
data.frame(one = c(1,3,4), two = c(4,5,3)) #creates a data frame with two columns: one, two
letters[1:4] #returns alphabet letters a, b, c and d
LETTERS[11:4] #returns letters in capital and reverse

# creating factor from numeric variable
data$fac_var <- factor(data$num_var, labels=c("label_one", "label_two", ..., "label_last"))

# creating numeric from factor variable
data$numvar <- as.integer(data$factorvar)

# rename variables and rows
colnames(data)[2:3] <- c("var2", "var3")
rownames(data) <- c("one", "two", "three",...)
dimnames(data) <- list(c("one", "two", "three", ...), c("var1", "var2", ...)) #combines colname and rowname. note, first is rowname
data <- matrix(data, byrow = T, nrow = 3, dimnames = list(c("one", "two", "three"), c("var1", "var2")))
setnames(DT, "A", "a") #renames column A to a --library(data.table)
rename(df, newname = oldname) #renames variable. library(dplyr)

# saving data in .RData format
save(dataframe, file = "directory/filename.RData")
load("directory/filename.RData")


# relational and logical operators
dataframe$var == 1 # prints results but returns T/F if condition is met/not met
which(dataframe$var == 1) # return observation numbers of those that meet the condition
any(dataframe$var == 1) # returns T/F if there is any case that meets the condition
all(dataframe$var == 1) # returns T/F if all cases meet the condition
sum(dataframe$var == 1, na.rm = TRUE) # counts number of true cases that meet the condition, controlling for missing value

## logical comparison: ==, <, >, <=, >=, !=, is.na, !is.na


# &
# |
# &&
# ||
# %in%        e.g. if ("hi" %in% names(df)) {} checks if "hi" is a colname in df, returns TRUE or FALSE
# xor(a,b)      a or b, but not both
# 7 %% 3 = 1


# subset of a dataset: for more see dplyr select()
subset <- dataframe[obs,dataframe]
subset <- subset(data, subset = var2 > 1)
subset <- select(dataframe, gender, q1:q5) # dplyr package
subset <- filter(subset, gender == "f") # dplyr package

code <- c("AF", "US")
country <- c("AF" = "Afghanistan", "US" = "United States", "IN" = "India")
subset <- country[code] # country's labels to apply on code!

subsetdata <- subset(data, select = c("var1", "var2", "var3"))
subset_y <- y[c("c","d")] #subsets y and assigns to subset_y

data2 <- mutate(data, var1 = var1+var2, var2 = var1/var2) # dplyr package
# minimum and maximum
max(vect) # or min(vect)
data[which.max(data$var), ] #for min: data[which.min(data$var), ]

# total, row total, column total
sum(data, na.rm = T)
rowSums(data, na.rm = T)
colSums(data, na.rm = T)
cumsum(data$var)

### ordering data
order(var1) #shows the order index
order(-var) #descending order
var1[order(var1)] #shows the order values
data[order(var1), ] #sort the data frame in order of smallest to largest var1

### Spliting and merging datasets
listname <- split(df, df$catvar) #splits df dataframe into smaller dataframes for each category of catvar, creates list
df2 <- listname[[2]]

# library(purrr)
map(listname, function(df) lm(depvar ~ indvar, data = df)) #fits regression for each smaller dataframe inside listname
map(listname, ~ lm(depvar ~ indvar, data = .)) #with purrr package
map2(listname1, listname2, funtionname) #applies function on two lists, for instance 
map2(list(1,2,3), list(2,3,4), rnorm) #equals: rnorm(1,2), rnorm(2,3), rnorm(3,4)
pmap(list(n=list(1,3,4), mean=list(2,4,2), sd=list(2,2,3)), rnorm) #equals: rnorm(1,mean=2,sd=2), rnorm(3,mean=4,sd,2), ...
invoke_map(list(rnorm, runif, rexp), n=5) #applies over functions, the opposite of map()
# invoke_map_chr() invoke_map_dbl() invoke_map_lgl() etc
# map()
# map2() #iterate over two arguments
# pmap() #iterate over multiple arguments
# invoke_map() #iterate over functions and arguments


### The apply family 
mat <- matrix(1:100, nrow = 10, ncol = 10)
apply(mat, 2, sum, na.rm = T) #elements: mat is data, 2 corresponds to dimention/column (also 1 can be used for rows), and sum is the function i want to apply

#lapply and sapply (simplified apply)
listname <- list(numname = 4444, vectorname = c("this", "that", "nonsense"), loginame = FALSE)
unlist(lapply(listname, class)) #returns class of each element of list listname in a vector

vectorname <- list(234, 435, 46, 234)
triple <- function(x) { x*3 }
result <- lapply(vectorname, triple)
unlist(result)

multiply <- function(x, factor) { x*factor }
result <- lapply(vectorname, multiply, factor = 3)
unlist(result)

vectorname <- c("this", "that", "nonsense")
unlist(lapply(vectorname, nchar)) #returns vector of number of characters (using nchar) of each elements of vector vectorname
sapply(vectorname, nchar, USE.NAMES = FALSE) #USE.NAMES is optional

#results <- sapply(logs, `[[`, "success") #don't know how it works, from datacamp. logs is a list with 3 elements, success, details, timestamp

# vapply: explicitly mention what the outcome of the function we're applying will be with vapply()
vapply(vector, nachar, numeric(1)) #numeric(1) here is a function value. it can also be: logical() or character()

# tapply
tapply(data$var1, data$var2, sum) #prepares sum of var1 for categories of var2.
# try this: 
#tapply(data[[5]], data[[1]], sum)
#tapply(data[[5]], data[[1]], mean)
#tapply(data[[5]], data[[1]], sd)
#summarydata <- data.frame(sum, mean, sd)

### passing functions as arguments with purrr package
#library(purrr)

map_dbl(vector, mean) #takes function (mean) applies to each element of vector and returns result, similar to sapply()
map(vector, mean) #returns mean of each element of vector in a list, similar to lapply
#map() returns a list or data frame
#map_lgl() returns a logical vector
#map_int() returns a integer vector
#map_dbl() returns a double vector
#map_chr() returns a character vector
map(df, function(x) sum(is.na(x)))
map(df, ~ sum(is.na(.)))
# adverbs in purrr
#safely() the output never throws an error, instread returns two elements: result and error
#possibly()
#quietly()

# side effects: plots, printing output, saving files to disk
#to deal with side effects, instead of map() we use walk()
x %>% walk(print) #is the same as: walk(x, print)
# example: saving multiple plots on desk at once
plots <- cyl %>% map(~ ggplot(., aes(mpg, wt)) + geom_point())
paths <- paste0(names(plots), ".pdf")
walk2(paths, plots, ggsave)
#or
mat %>% walk(hist) %>% map(summary)


### creating a categorical variable from continous/discrete variable
mutate(data, newvar = ifelse(var<30, "label1", ifelse(var<50, "label2", "label3")))


### bind, combine, merge
merge(x, y, by = "var", all.x = T, all.y = F) #joins x and y dataframes and include nonmatching rows (similar to left_join in dplyr)
merge(x, y, by = "var", all = T) #equivalent of full_join in dplyr. all = F equivalent of inner_join in dplyr
rbind(df, df2) # df and df2 have similar colnames
rbind.fill(df, df2 ) # df and df2 have non-similar colnames
bind_rows(df, df2) # rbind from library(dplyr), top of each other, equivalent of append
smartbind(df, df2) # rbind from library(gtools)

merge(dt1, dt2, by = "var", all = T)
x <- data.table(x, setkey = "var") # library(data.table)
y <- data.table(y, setkey = "var")
merge(x,y)

### with and within
with(data, var1 - var2) #difference between var1 and var2 in data
within(data, {newvar <- var1 - var2}) #creates newvar in data, which is difference between var1 and var2

### test of speed of different functions with microbenchmark
library(microbenchmark)
microbenchmark(expression1, expression2, times = 20) #checks both expressions 20 times

### packages
search() #lists the attached packages in R
library(package) #attach a package
install.packages("package") #installs a package
require(package) #attach a package, but unlike library ..


### dont know what this is for now
readLines("http://maestudents.tumblr.com")
safe_readLines <- safely(readLines)
safe_readLines("http://maestudents.tumblr.com")
safe_readLines("http://asd;agjasdg.a")
urls <- list(example = "http://example.org", rproj = "http://www.r-project.org", asdf = "http://asdfasdasdkfjlda")
html <- map(urls, safe_readLines)
str(html)
results <- transpose(html)[["result"]]
errors <- transpose(html)[["error"]]



