############ Functions


## function to arrange variables
arrange.vars <- function(data, vars){
  ##stop if not a data.frame (but should work for matrices as well)
  stopifnot(is.data.frame(data))
  
  ##sort out inputs
  data.nms <- names(data)
  var.nr <- length(data.nms)
  var.nms <- names(vars)
  var.pos <- vars
  ##sanity checks
  stopifnot( !any(duplicated(var.nms)), 
             !any(duplicated(var.pos)) )
  stopifnot( is.character(var.nms), 
             is.numeric(var.pos) )
  stopifnot( all(var.nms %in% data.nms) )
  stopifnot( all(var.pos > 0), 
             all(var.pos <= var.nr) )
  
  ##prepare output
  out.vec <- character(var.nr)
  out.vec[var.pos] <- var.nms
  out.vec[-var.pos] <- data.nms[ !(data.nms %in% var.nms) ]
  stopifnot( length(out.vec)==var.nr )
  
  ##re-arrange vars by position
  data <- data[ , out.vec]
  return(data)
}
arrange.vars(DT, c("C" = 1))


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


### tabulation of all elements of a dataframe
tab <- function(x) {
  if (is.data.frame(x) == TRUE) {
    for (i in 1:length(x)) {
      print(paste("dataframe element", i))
      print(table(x[[i]]))
    }
  } else if (is.list(x) == TRUE) {
    for (i in 1:length(x)) {
      print(paste("list element", i))
      print(table(x[[i]]))
    }
  } else if (is.vector(x) == TRUE) {
    print(table(x))
  }
}


### robust functions: stopifnot()
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)
z <- c(2, NA, 2, NA)

both_na <- function(x,y) {
  if (length(x) != length(y)) { # stopifnot(length(x) == length(y))
    stop("vectors do not have equal length", call. = FALSE)
  }
  sum(is.na(x) & is.na(y))
}
both_na(x,y)
both_na(y,z)


show_miss <- function(x) {
  n <- sum(is.na(x))
  cat("Missing values: ", n, "\n", sep = "")
  x
}




by(vectorname, catvar, functionname) # applies function on vectorname by categories of catvar
by(vectorname, catvar, function(x) { c(mean(x), sd(x)) })

