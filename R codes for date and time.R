### dates and times: with lubridate, zoo, xts

# library(lubridate)
ymd("2010 Sep 10") # or ymd("2010/Sep/10"), ymd("2010-Sep-10"), ymd("2010-01-18")
mdy("Aug 22 2010") # or mdy("Aug,22,2010"), mdy("Aug_22_2010"), mdy("Aug.22.2010")
hms("13-10-10") # or hms("13:10:10"), hms("13 10 10"), hms("13.10.10")
# ymd_hms(), ymd_hm(), ymd_h(), year(), month(), day(), weekdays(), quarter()

Sys.Date() #prints current date
Sys.time() #prints date and time, with time zone
Sys.Date() - as.Date("1987-10-29") #returns number of days between the two dates
Sys.Date() + 1000 #returns the date of 1000 days from today
Sys.time() + 1000 #returns the date and time of 1000 seconds from now
unclass(Sys.Date()) #number of days since 1970-01-01

format(Sys.Date(), "%A") #day of the week
format(Sys.Date(), "%b-%Y") #abbrev. month-year

as.Date("September 11, 2010", format = "%B %d, %Y")
as.POSIXct("It is 11pm", format = "It is %I%p")

weekdays(as.Date("2000-01-01")) #or weekdays(as.POSIXct("2000-01-01"))
months(as.Date("2000-01-01")) #or months(as.POSIXct("2000-01-01"))
quarters(as.Date("2000-01-01")) #or quarters(as.POSIXct("2000-01-01"))
quarters(as.Date("2000-01-01")) #or quarters(as.POSIXct("2000-01-01"))

# %Y: 4-digit year (1982)
# %y: 2-digit year (82)
# %m: 2-digit month (01)
# %d: 2-digit day of the month (13)
# %A: weekday (Wednesday)
# %a: abbreviated weekday (Wed)
# %B: month (January)
# %b: abbreviated month (Jan)
# %H: hours as a decimal number (00-23)
# %I: hours as a decimal number (01-12)
# %M: minutes as a decimal number
# %S: seconds as a decimal number
# %T: shorthand notation for the typical format %H:%M:%S
# %p: AM/PM indicator

seq.Date()

