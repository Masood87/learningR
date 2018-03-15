### dates and times: with lubridate, zoo, xts


# dates (ISO 8601: YYYY-MM-DD... it doesn't have to be sep. by -):

# as.Date() takes date in character string in ISO 8601 standard format and turns it as date object
as.Date("2003-05-23")

# packages that read date objects: readr, anytime
anytime(c("September 10 2009", "Sep 11 2009", "10 Sep 2009", "1-09-2009", "2009-02-05"))

# ISO 8601: HH:MM:MM
# POSIXlt: list with named compoments
# POSIXct: seconds since 1970-01-01 00:00:00
# as.POSIXct() takes date-time in character string in ISO 8601 standard format and turns it into POSIXct object
as.POSIXct("1970-01-01 00:00:00")

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

###### DataCamp: Working with Dates and Times in R (Charlotte Wickham)

### library(lubridate)
# functions to read date
ymd("2010 Sep 10") # or ymd("2010/Sep/10"), ymd("2010-Sep-10"), ymd("2010-01-18")
mdy("Aug 22 2010") # or mdy("Aug,22,2010"), mdy("Aug_22_2010"), mdy("Aug.22.2010")
hms("13-10-10") # or hms("13:10:10"), hms("13 10 10"), hms("13.10.10")
dmy_hms("27.10.2017 11:00:01pm") # ymd_hms(), ymd_hm(), ymd_h(), year(), month(), day(), weekdays(), quarter()

# make dates flexibly with different formats
parse_date_time(c("2007/02/01", "Sep 10, 2017", "27th Feb 2009"), orders = c("ymd", "mdy", "dmy"))

# make date from its components
make_date(year = 2000, month = 2, day = 21)
make_datetime(year = 2000, month = 2, day = 21, hour = 10, min = 22, sec = 0)

# extract part of date
year(ymd("2010 Sep 10")) # month(x, label = T, abbr = F), day()
hour(ymd("2010 Sep 10")) # minute(), second()
wday(ymd("2010 Sep 10")) # yday(), tz()
quarter(ymd("2010 Sep 10")) # semester()

# change part of date and time
x <- ymd("2010 Sep 10")
year(x) <- 2011

# other useful functions: returns TRUE or FALSE
leap_year(ymd("2010 Sep 10"))
am(ymd_hms("2010 Sep 10 13:10:30")) # pm()
dst(ymd_hms("2010 July 10 13:10:30")) #daylight savings
days_in_month(3)
today() # return the current date in system's timezone
now() # return the current date and time in system's timezone

# rounding dates and time
round_date(x, unit = "year") # round to nearest... possible units: second, minute, hour, day, week, month, bimonth, quarter, halfyear, year, or "2 years", "5 minutes"
ceiling_date(x, unit = "month") # round up
floor_date(x, unit = "quarter") # round down

# adding and subtracting time: PERIOD (as humans would measure time) or DURATION (as stopwatch would measure time)
now() + hours(2) #PERIOD: years, months, weeks, days, hours, minutes, seconds
now() + dhours(2) #DURATION: dyears, dweeks, ddays, dhours, dminutes, dseconds

# Arithmetic with Dates and Times
difftime(time1, time2, units = "secs") # similar to time1 - time2... units = secs, mins, hours, days, weeks
3*(ddays(1) + dhours(1))
today() + 1:10 * days(1) # generating sequences of datetimes

# exercise: last day of months
months(1) * 1:12
ymd("2018-01-31") + (months(1)*1:12) #31st doesn't exist for every month, therefore returning NA
ymd("2018-01-31") %m+% (months(1)*1:12) #using %m+%
ymd("2018-01-31") %m-% (months(1)*1:12) #using %m+%

# INTERVALS
x <- dmy("22-09-2010") %--% ymd("2018-01-01") #create interval
y <- interval(start = dmy("31-01-2005"), end = ymd("2009-05-21")) #create interval
int_start(x) #extracts start of interval
int_end(x) #extracts end of interval
int_length(x) #length of interval in second
int_overlaps(x, y)
mdy("10-11-2000") %within% x
as.period(x) #as.duration(x)

# TIME ZONES: OlsonNames()
force_tz(x, tzone = "Asia/Kabul") #changes timezone without changging the clock time
with_tz(x, tzone = "America/New_York") #view the same instant in a different timezone
with_tz(now(), tzone = "Europe/Prague") - force_tz(now(), tzone = "Asia/Kabul")

# time without date: library(hms)
as.hms(x)

#### SPEEDING READING AND WRITING DATETIME
# library(fasttime)
fastPOSIXct("2017-10-22") #reads datetime fast conditional that datetime is in ISO 8601 format
fast_strptime(x, format = "%Y-%m-%d") #lubridate's faster method to read datetime. Instead of taking order like parse_date_time(), it takes format..
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

### stamp() from lubridate
stamp("Sep 20, 2010")(today()) #creates a function based on a string date format, which can be used to turn dates in that format
stamp("11/20/2010")(today())
stamp("I finished 'Dates and Times in R' on Sunday, March 11, 2018!")(today())
