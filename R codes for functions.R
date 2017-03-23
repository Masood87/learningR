############ Functions

# if y is no mentioned, it is 1 by default
add <- function(x, y=1) { 
  x + y 
  }

absolute <- function(x) {
  if (x < 0) {
    -x
  } else {
    x
  }
}

#returns how many obs both x and y have missing (NA)
both_na <- function(x,y) {
  sum(is.na(x) & is.na(y))
}

#return minimum and maximum letters of a word
min_max_letter <- function(x) {
  x <- gsub(" ", "", x)
  x <- strsplit(x, "")[[1]]
  print(unique(x))
  print(c(min = min(x), max = max(x)))
}

mystat <- function(x) {
  mymean <- mean(x, na.rm = T)
  mysd <- sd(x, na.rm = T)
  mymedian <- median(x, na.rm = T)
  mymax <- max(x, na.rm = T)
  mymin <- min(x, na.rm = T)
  c(mean = mymean, sd = mysd, median = mymedian, max = mymax, min = mymin)
}

mystat2 <- function(df) {
  output <- data.frame(matrix(0, nrow = length(df), ncol = 5))
  mymean <- numeric(length(df))
  mysd <- numeric(length(df))
  mymedian <- numeric(length(df))
  mymax <- numeric(length(df))
  mymin <- numeric(length(df))
  for (i in seq_along(df)){
    mymean[i] <- round(mean(df[[i]], na.rm = T), 1)
    mysd[i] <- round(sd(df[[i]], na.rm = T), 1)
    mymedian[i] <- round(median(df[[i]], na.rm = T), 1)
    mymax[i] <- round(max(df[[i]], na.rm = T), 1)
    mymin[i] <- round(min(df[[i]], na.rm = T), 1)
    output <- c(mean = mymean, sd = mysd, median = mymedian, max = mymax, min = mymin)
  }
  output
}


add











by(vectorname, catvar, functionname) # applies function on vectorname by categories of catvar
by(vectorname, catvar, function(x) { c(mean(x), sd(x)) })

