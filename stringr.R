library(stringr)
str_trim("   this is nice ") #cleans white spaces
str_pad("93795689571", width = 13, side = "left", pad = "0") # pad left side with 0's to make the length of the string 13

countries <- c("Afghanistan", "Czechia", "India", "Russia", "United States of America")
str_detect(countries, "Czechia")
str_replace(countries, "Czechia", "Czech Republic")
str_replace_all(string = )
str_replace_na()

tolower("I AM WHISPERING...")
toupper("i am shouting...")
