################################
####### Data Management ########
################################

rm(list=ls())
setwd("path")
getwd()
dir()
attach(data) #Since I'm not loading other data frames, I can attach this data frame to type less :)
dim(dataframe) #dimensions of dataframe
str(dataframe)
summary(dataframe)
typeof(object) 
length(object) 
is.na() #returns a logical vector
ncol(data)
nrow(data)
vector <- vector("double", 44) #creates empty vector double with 44 elements. other options: "integer", "logical", "character"
range(vector) #elements will be min and max of vector
sum(is.na(x) & is.na(y)) #returns how many obs both x and y have missing (NA)
x[is.na(x)] <- y #if x is missing, replace it with y
args(x)
tolower() #lowercase
strsplit(vector, split = " ") #splits elements of vector by space, and output a list of vectors
names(data)
head(data, n=11) #print top 11 obs
tail(data, n=11)
cleaned_data <- na.omit(data_unclean) #removes all obs with missing values (NA)
paste0("var", 1:5) #creates var1, var2, var3, var4, var5
vectorname <- gsub("a", "b", vectorname) #replaces "a" to "b" in a vector
cat("text", mean(var)) #concatenate and print

# importing data
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
dataframe$factor-var <- factor(dataframe$numeric-var, 
                               labels=c("label-one", "label-two", ..., "label-last"))

# creating numeric from factor variable
dataframe$numeric-var <- as.integer(dataframe$factor-var)

# rename variable
colnames(dataframe)[2:3] <- c("second-var", "third-var")

# saving data in .RData format
save(dataframe, file = "directory/filename.RDtata")
load("directory/filename.RData")

# logic
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
# %in%        e.g. workshop %in% c("R", "SAS")
# xor(a,b)      a or b, but not both

dataframe <- c("gender", "q1", "q2", "q3", "q4", "q5")
obs <- which(dataframe$gender == "f")
summary(dataframe[obs,1])
subset <- dataframe[obs,dataframe]

subset <- select(dataframe, gender, q1:q5) # dplyr package
subset <- filter(subset, gender == "f") # dplyr package

dataframe2 <- mutate(dataframe, var1 = var1+var2, var2 = var1/var2) # dplyr package

# creating a subset of data
subsetdata <- subset(data, select = c("var1", "var2", "var3"))

# minimum and maximum
data[which.min(data$var), ]
data[which.max(data$var), ]

# reshuffling and sampling
n <- nrow(data)
shuffled <- data[sample(n),]
sample50 <- data[sample(n*0.5),]

### The apply family 
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

#vapply
vapply(vector, nachar, numeric(1)) #also use: logical() or character()
