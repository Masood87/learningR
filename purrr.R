######## purrr package #########
library(purrr)

x <- c(1,2,4)
map(x, ~ 10*.) #much like lapply(x, ~. *10) but lapply doesnt work since the operation is not a function. this works: lapply(x, function(y) { y*10 }) 
#see more on base R: sapply(x, function(y) { y*10 })

# reduce: apply recursively (Datacamp: Joining Data in R with dplyr, chap 4)
reduce(listofdf, left_join, by = "var") #joins each element/df from the listofdf by "var" column


# linear regression for a column list
df <- nest(df, -id)
mutate(df, model = map(data, ~ lm(depvar ~ indpvar, data = .)))
mutate(df, model = map(data, ~ lm(depvar ~ indpvar, data = .))) %>% mutate(tidied = map(model, tidy))
mutate(df, model = map(data, ~ lm(depvar ~ indpvar, data = .))) %>% mutate(tidied = map(model, tidy)) %>% unnest(tidied)
mutate(df, model = map(data, ~ lm(depvar ~ indpvar, data = .))) %>% mutate(tidied = map(model, tidy)) %>% unnest(tidied) %>% filter(term == "indpvar")
