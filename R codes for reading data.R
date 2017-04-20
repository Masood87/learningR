 #### ### ## # ## ## ## # ## ### ####
#### ## # # IMPORTING DATA # # ## ####
 #### ### ## # ## ## ## # ## ### ####


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



### from other sources using using haven package
library(haven)
#from SAS
read_sas("data.sas7bdat")
#from SAS
sap <- read_stata("/Users/macbookair/Dropbox/SAP 2016/STATA-2006-1016_data_and_codebook/SAP Data 2006-2016.dta")
sap <- read_stata("/Users/macbookair/Dropbox/SAP 2016/STATA-2006-1016_data_and_codebook/SAP Data 2006-2016.dta")
as.character(as_factor(data$labeledvar)) #to convert Stata's labeled variables to factors and then characters in R
#from SPSS
read_spss("path/data.")
read_sav()
read_por()


### from other sources using using foreign package
library(foreign)
#from Stata 5 to 12
sap <- read.dta("/Users/macbookair/Dropbox/SAP 2016/STATA-2006-1016_data_and_codebook/SAP Data 2006-2016 old.dta", convert.factors = T, convert.dates = T, missing.type = F)
df <- read.spss("path/data.sav", use.value.labels = T, to.data.frame = T) #to.data.frame = TRUE to get a data frame



### MySQL
library(RMySQL)
library(DBI)

#1. connecting with database, creating connection object con
con <- dbConnect(RMySQL::MySQL(),#MysQL() is the SQL driver we use to connect to database
                 dbname = "company", #another dbname = "tweater"
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                 port = 3306, 
                 user = "student", 
                 password = "datacamp")

dbListTables(db)
dbListTables(con)

# read table from a connection
dbReadTable(db, "employees")

# read all tables from a connection
library(magrittr)
all_tables <- dbListTables(con) %>% lapply(dbReadTable, conn = con)

# read fraction of table
dbGetQuery(db, "SELECT * FROM products WHERE contract = 1") #SQL lang inside "". SELECT *=select all col. FROM product=from table product. WHERE contract=1 =where col contract==1
dbGetQuery(con, "SELECT * FROM tweats WHERE date > '2015-09-15' AND user_id > 1") #SQL lang inside "". SELECT all columns. FROM table product. WHERE date is after 2015-09-15 AND user_id is greater than 1
dbGetQuery(con, "SELECT id, name FROM users WHERE CHAR_LENGTH(name) < 5") #select columns id and name, from user table, where length of names are less than 5 character. CHAR_LENGTH() is sql language function
dbGetQuery(con, "SELECT post, message FROM tweats INNER JOIN comments on tweats.id = tweat_id WHERE tweat_id = 77") #INNER JOIN combines two datasets. SELECTion can be from both db. on tweats.id is table tweats, column id = tweat_id is column in joining db that corresponds with id column in FROM db. WHERE condition is for JOINing db (?)

# read fraction of massive table, alternative to dbGetQuary()
msg <- dbSendQuery(db, "SELECT * FROM products WHERE contract = 1")
#dbFetch(msg)
dbFetch(msg, n = 1)
dbFetch(msg) #prints what remains from the first code

# politely disconnect connection
dbDisconnect(db)
dbDisconnect(con)




### HTTP: HyperText Transfer Protocol

read.csv("https://s3.amazonaws.com/assets.datacamp.com/course/importing_data_into_r/states.csv")


### json
library(jsonlite)
fromJSON("http://www.omdbapi.com/?t=braveheart&y=1995")
json1 <- '[[1, 2], [3, 4]]'
json2 <- '[{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a": 5, "b": 6}]'
fromJSON(json2)
toJSON(object, pretty = T) #pretty or mini format of JSON
minify(jsonobj)
prettify(jsonobj)

### downloading files from web
url <- ("https://s3.amazonaws.com/assets.datacamp.com/course/importing_data_into_r/states.csv") # we can have two urls
setwd("/Users/macbookair/Downloads")
destination <- file.path(getwd(), destfile = "states.csv")
download.file(url, destination)
# dir()
library(readxl) # if the file is excel, use function read_excel
read_csv(destination)

library(httr)
resp <- GET("http://www.example.com/")
content(resp) # R to figure out the content of resp
content(resp, as = "text") # content as text






