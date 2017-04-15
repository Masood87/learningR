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
typeof(object)
length(object)
summary(dataframe)
names(data)
head(data, n=11) #print top 11 obs
tail(data, n=11)
class(object)


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
ncol(data)
nrow(data)
vector <- vector("double", 44) #creates empty vector double with 44 elements. other options: "integer", "logical", "character"
range(vector) #elements will be min and max of vector
args(x)
tolower() #lowercase
cleaned_data <- na.omit(data_unclean) #removes all obs with missing values (NA)
data$var <- droplevels(data$var) #in factor variable, drops/ removes all levels with 0 obs/count
paste("var", 1:5, sep = "-") #creates var-1, var-2, var-3, var-4, var-5
paste0("var", 1:5) #creates var1, var2, var3, var4, var5
cat("text", mean(var)) #concatenate and print
seq_along(data) #returns a vector of sequential numbers equal to elements of df or vector
arrange(var1, var2) #from dplyr. Stata: sort var1 var2
abs(var) #absolute values of var
round(var,1) #rounds to one decimal
append(object, anything) #appends anything to an object and creates a list. Except if object=vector and anything=num, then output=vector
rev(object) #orders reverse of elements of object such as list, vector or data frame
strsplit(vector, split = " ") #splits elements of vector by space, and output a list of vectors
diff(vect) #difference between elements of a numerical or date vector
x <- list(a = 1, b = list(c = 3, d = 4)) #to refer to an element of a list within list: x[[c("b","c")]] or x[[c(2,1)]]
mutate_each(df, funs(as.numeric), var4:var10) #changes class to numeric for variables var4 through var10

### regular expressions (?regex)
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
seq(100, 11, by = -10) #
rep(3:6, times = 5) #creates a vector of 3 to 6 repeated 5 times
sort(rep(3:6, times = 2), decreasing = TRUE) #orders the vector of 3 to 6 repeated 5 times (6,6,5,5,4,4,3,3)
data.frame(one = c(1,3,4), two = c(4,5,3)) #creates a data frame with two columns: one, two

### importing data
read.csv("path/data", stringsAsFactors = F) # stringsAsFactors = T converts string data to factors
read.delim("path/data", stringsAsFactors = F)
read.delim("path/data", colClasses = c("numeric", "factor", "character", "logical")) # if colClasses = "NULL", it skips loading into dataframe. Use colClasses instead of stringsAsFactors
read.table("path/data", header = T, sep = "/", stringsAsFactors = F) #use "\t" for tab separated data

library(readr)
read_csv("path/data") #data is imported in a tibble
read_tsv("path/data", col_names = c("var1", "var2")) #string is not imported as factors by default, unlike read.csv()
read_delim("path/data", delim = "/") #first row is col_names by default
read_delim("path/data", delim = "/", col_names = F) #automatic naming of columns. or col_names = c("var1", "var2")
read_delim("path/data", delim = "/", col_types = "ldci") #in col_types, c = character, d = double, i = integer, l = logical, _ = skip a column
read_delim("path/data", delim = "/", skip = 5, n_max = 100, col_names = c("var1", "var2")) #do not import obs 1-5, and imports the next 100 obs

fac <- col_factor(levels = c("one", "two", "three"))
int <- col_integer()
read_tsv("path/data", col_types = list(fac, int, fac)) #imports columns as factors, integers and factors

library(data.table)
fread("path/data") #handles col_names, col_types and separators automatically
fread("path/data", drop = 2:4)
fread("path/data", select = c(1,5))
fread("path/data", drop = c("var2", "var3", "var4"))
fread("path/data", select = c("var1", "var5"))

library(readxl)
excel_sheets("path/data") #output name of sheets
read_excel("path/data") #import first sheet by default
read_excel("path/data", sheet = 2)
read_excel("path/data", sheet = "sheetname")
multiplesheets <- lapply(excel_sheets("path/data"), read_excel, path = "path/data")
read_excel("path/data", sheet = 2, col_names = FALSE) #col_names take TRUE (default), FALSE, or c("var1", "var2")
read_excel("path/data", sheet = 2, col_types = c("text", "text")) #col_types take NULL (default), c("text", "numeric", "date", "blank"). blank ignores column
read_excel("path/data", sheet = 2, skip = 4, col_names = c("var1", "var2", "var3")) #skips that many rows before exporting data, and use col_names since first row containing varnames is not imported

library(gdata) #it is slower since xls is converted to csv then to dataframe
read.xls("path/data") #first sheet is imported by default
read.xls("path/data", sheet = 2) #or sheet = "sheetname"

#library(rJava)
#library(XLConnectJars)
library("XLConnect") #there are more than below in this package
workbook <- loadWorkbook("path/workbook") #get data in workbook
getSheets(workbook)
readWorksheet(workbook, sheet = "sheetname") #or sheet = 2
readWorksheet(workbook, sheet = 2, startRow = 2, endRow = 3, startCol = 3, header = F)
createSheet(workbook, name = "sheetname") #creates a new sheet in the workbook in XLConnect workbook, which later can be added to excel file
writeWorksheet(workbook, dataframe, sheet = "sheetname") #saves dataframe to sheetname in the XLConnect's workbook
saveWorkbook(workbook, file = "path/filename.xlsx")
renameSheet(workbook, "oldname", "newname") #renames name of sheets for XLConnect workbook
removeSheet(workbook, sheet = "sheetname") #deletes sheet from XLConnect workbook

# creating factor from numeric variable
data$fac_var <- factor(data$num_var, labels=c("label_one", "label_two", ..., "label_last"))

# creating numeric from factor variable
data$numvar <- as.integer(data$factorvar)

# rename variables and rows
colnames(data)[2:3] <- c("var2", "var3")
rownames(data) <- c("one", "two", "three",...)
dimnames(data) <- list(c("one", "two", "three", ...), c("var1", "var2", ...)) #combines colname and rowname. note, first is rowname
data <- matrix(data, byrow = T, nrow = 3, dimnames = list(c("one", "two", "three"), c("var1", "var2")))

# saving data in .RData format
save(dataframe, file = "directory/filename.RDtata")
load("directory/filename.RData")

# relational and logical operators
dataframe$var == 1 # prints results but returns T/F if condition is met/not met
which(dataframe$var == 1) # return observation numbers of those that meet the condition
any(dataframe$var == 1) # returns T/F if there is any case that meets the condition
all(dataframe$var == 1) # returns T/F if all cases meet the condition
sum(dataframe$var == 1, na.rm = TRUE) # counts number of true cases that meet the condition, controlling for missing value
# ==
# <
# >
# <=
# >=
# !      Not
# !=     Not equal
# &
# |
# &&
# ||
# %in%        e.g. if ("hi" %in% names(df)) {} checks if "hi" is a colname in df, returns TRUE or FALSE
# xor(a,b)      a or b, but not both
# 7 %% 3 = 1

dataframe <- c("gender", "q1", "q2", "q3", "q4", "q5")
obs <- which(dataframe$gender == "f")
summary(dataframe[obs,1])

# subset of a dataset
subset <- dataframe[obs,dataframe]
subset <- subset(data, subset = var2 > 1)
subset <- select(dataframe, gender, q1:q5) # dplyr package
subset <- filter(subset, gender == "f") # dplyr package

data2 <- mutate(data, var1 = var1+var2, var2 = var1/var2) # dplyr package

# creating a subset of data
subsetdata <- subset(data, select = c("var1", "var2", "var3"))

# minimum and maximum
max(vect) #
data[which.max(data$var), ] #for min: data[which.min(data$var), ]

# total, row total, column total
sum(data, na.rm = T)
rowSums(data, na.rm = T)
colSums(data, na.rm = T)

### ordering data
order(var1) #shows the order index
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



### with and within
with(data, var1 - var2) #difference between var1 and var2 in data
within(data, {newvar <- var1 - var2}) #creates newvar in data, which is difference between var1 and var2

### packages
search() #lists the attached packages in R
library(package) #attack a package
install.packages("package") #installs a package
require(package) #attack a package, but unlike library ..


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


score <- c()
if (round(runif(10)*1)) {
  score <- score + 1
}

