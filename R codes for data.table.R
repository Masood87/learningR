### data.table ###

DT <- data.table(A = sample(1:10, 8), B = c(1,2), C = rep(c("Yes", "No", "No", "Yes"), 2))
DT[2:4] #prints obs 2, 3 and 4 of data.table
DT[.N-1] #prints the last obs
DT[, .(A, C)] #prints columns A and C
DT[, .(Total = sum(A), Mean = mean(A))] #wrapping inside .() returns data.table
DT[, .(A, Total.A = sum(A))]
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
setcolorder(DT, c("C", "A", "B", "x", "y", "z")) #orders columns
