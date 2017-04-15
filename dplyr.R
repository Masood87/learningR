### library(dplyr)

glimpse(df)

arrange(var1, var2) #from dplyr. Stata: sort var1 var2

subset <- select(dataframe, gender, q1:q5)
subset <- filter(subset, gender == "f")

### creating a categorical variable from continous/discrete variable
mutate(data, newvar = ifelse(var<30, "label1", ifelse(var<50, "label2", "label3")))

mutate_each(df, funs(as.numeric), -id)




