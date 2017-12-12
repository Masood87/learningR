### data.table ###

<<<<<<< HEAD
DT <- data.table(A = sample(1:10, 8), B = c(1,2), C = rep(c("Yes", "No", "No", "Yes"), 2)) #optional argument: key = "C,A"

DT[1:3] #or DT[1:3, ] to access row(s)
DT[.N-1] #prints the last obs
DT[C == "No"] #select and print data where column C's values equal "No". We can use & and |
DT[C %in% c("No")] #select and print data where column C's values equal "No"

DT[order(-A, C)] #sorts based on column A and C. negative means descending

DT[, A] #to access a column
DT[, .(A, C)] #or DT[, list(A, B)] to access more thna one column. Note: c(A,B) prints both columns in one vector

DT[, .(A, Total = sum(A), Mean = mean(A))] #returns columns A, new columns Total and Mean. wrapping inside .() returns data.table

=======
DT <- data.table(A = sample(1:10, 8), B = c(1,2), C = rep(c("Yes", "No", "No", "Yes"), 2))
DT[2:4] #prints obs 2, 3 and 4 of data.table
DT[.N-1] #prints the last obs
DT[, .(A, C)] #prints columns A and C
DT[, .(Total = sum(A), Mean = mean(A))] #wrapping inside .() returns data.table
DT[, .(A, Total.A = sum(A))]
>>>>>>> origin/master
DT[, .(sum(A)), by = .(C)] #total of A by categories of C
DT[, sum(B), by = A%%2] #sum of values of B for A's even (0) and odd (1) values
DT[, .(B = cumsum(B)), by = .(C)][, .(B = tail(B, 2)), by = C] #chaining
DT[, lapply(.SD, median), by = C] # .SD = "Subset of Data", holds values of all columns with exception of column specified with "by".. see .SDcols too
DT[, c("A", "z") := .(rev(A), 8:1)] #adds new columns --not working?
DT[, c("A", "C") := NULL] #removes columns A and C
DT[, paste0("var", 1:3) := NULL] #removes columns var1, var2 and var3
DT[, `:=` (x = TRUE, y = 1:8)] #adds columns x and y to DT
DT[2:4, z := sum(y), by = C] #creates column z with condition given in obs 2:4


setnames(DT, "A", "a") #renames column A to a
setcolorder(DT, c("C", "A", "B", "x", "y", "z")) #orders columns.. somehow not working!?
setnames(iris, names(iris), gsub("Sepal.", "", names(iris))) #changes colnames that include "Sepal." in them
iris[, grep("Petal", names(iris)) := NULL] #removes colnames that include "Petal" in them
setkey(DT, C, A) #data is ordered by C and A. Also I can filter it directly without mentioning the colname: DT[.("No",6:9)] and DT[.("No",6:9), nomatch = 0]


dt1 <- data.table(dt1, setkey = "var") # library(data.table)
dt2 <- data.table(dt2, setkey = "var")
merge(x,y)

