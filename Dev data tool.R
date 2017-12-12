# rm(list = ls())
# 
# require(readr)
# require(tidyr)
# require(data.table)
# require(dplyr)
# require(shiny)
# require(ggplot2)
# require(plotly)
# require(rsconnect)

# setwd("/Users/macbookair/Downloads/All countries, income and region")
# # files <- list.files(pattern = "csv")
# # names <- c("east.asia.pacific", "europe.central.asia", "high.income", "latin.america.caribbean", "low.income", "lower.middle.income", "middle.east.north.africa", "north.america", "south.asia", "sub.saharan.africa", "upper.middle.income")
# 
# high.income <- read_csv("High income.csv")[,1]
# low.income <- read_csv("Low income.csv")[,1]
# lower.middle.income <- read_csv("Lower middle income.csv")[,1]
# upper.middle.income <- read_csv("Upper middle income.csv")[,1]
# east.asia.pacific <- read_csv("East Asia & Pacific.csv")[,1]
# europe.central.asia <- read_csv("Europe & Central Asia.csv")[,1]
# latin.america.caribbean <- read_csv("Latin America & Caribbean.csv")[,1]
# middle.east.north.africa <- read_csv("Middle East & North Africa.csv")[,1]
# north.america <- read_csv("North America.csv")[,1]
# south.asia <- read_csv("South Asia.csv")[,1]
# sub.saharan.africa <- read_csv("Sub-Saharan Africa.csv")[,1]
# 
# all.countries <- bind_rows(high.income, low.income, lower.middle.income, upper.middle.income)
# 
# all.countries$income[all.countries$`Country Name` %in% high.income$`Country Name`] <- "High income"
# all.countries$income[all.countries$`Country Name` %in% low.income$`Country Name`] <- "Low income"
# all.countries$income[all.countries$`Country Name` %in% lower.middle.income$`Country Name`] <- "Lower middle income"
# all.countries$income[all.countries$`Country Name` %in% upper.middle.income$`Country Name`] <- "Upper middle income"
# 
# all.countries$region[all.countries$`Country Name` %in% east.asia.pacific$`Country Name`] <- "East Asia & Pacific"
# all.countries$region[all.countries$`Country Name` %in% europe.central.asia$`Country Name`] <- "Europe & Central Asia"
# all.countries$region[all.countries$`Country Name` %in% latin.america.caribbean$`Country Name`] <- "Latin America & Caribbean"
# all.countries$region[all.countries$`Country Name` %in% middle.east.north.africa$`Country Name`] <- "Middle East & North Africa"
# all.countries$region[all.countries$`Country Name` %in% north.america$`Country Name`] <- "North America"
# all.countries$region[all.countries$`Country Name` %in% south.asia$`Country Name`] <- "South Asia"
# all.countries$region[all.countries$`Country Name` %in% sub.saharan.africa$`Country Name`] <- "Sub-Saharan Africa"
# 
# names(all.countries) <- c("country", "Income", "Region")
# write_csv(all.countries, "All Countries, income and regions.csv")
# 
# 
# rm(list = ls())
# setwd("/Users/macbookair/Downloads/World Development Indicators Data")
# # list.files(pattern = "csv")
# east.asia.pacific.p1 <- read_csv("East Asia & Pacific p1.csv", na = c("..", "NA"))
# east.asia.pacific.p2 <- read_csv("East Asia & Pacific p2.csv", na = c("..", "NA"))
# east.asia.pacific <- bind_rows(east.asia.pacific.p1, east.asia.pacific.p2)
# east.asia.pacific <- east.asia.pacific[!(east.asia.pacific$`Country Name` %in% c("Data from database: World Development Indicators", "Last Updated: 11/21/2017", "")), ]
# write_csv(east.asia.pacific, "cleaned/East Asia & Pacific.csv")
# 
# europe.central.asia.p1 <- read_csv("Europe & Central Asia p1.csv", na = c("..", "NA"))
# europe.central.asia.p2 <- read_csv("Europe & Central Asia p2.csv", na = c("..", "NA"))
# europe.central.asia.p3 <- read_csv("Europe & Central Asia p3.csv", na = c("..", "NA"))
# europe.central.asia <- bind_rows(europe.central.asia.p1, europe.central.asia.p2, europe.central.asia.p3)
# europe.central.asia <- europe.central.asia[!(europe.central.asia$`Country Name` %in% c("Data from database: World Development Indicators", "Last Updated: 11/21/2017", "")), ]
# write_csv(europe.central.asia, "cleaned/Europe & Central Asia.csv")
# 
# latin.america.caribbean.p1 <- read_csv("Latin America & Caribbean p1.csv", na = c("..", "NA"))
# latin.america.caribbean.p2 <- read_csv("Latin America & Caribbean p2.csv", na = c("..", "NA"))
# latin.america.caribbean <- bind_rows(latin.america.caribbean.p1, latin.america.caribbean.p2)
# latin.america.caribbean <- latin.america.caribbean[!(latin.america.caribbean$`Country Name` %in% c("Data from database: World Development Indicators", "Last Updated: 11/21/2017", "")), ]
# write_csv(latin.america.caribbean, "cleaned/Latin America & Caribbean.csv")
# 
# middle.east.north.africa <- read_csv("Middle East & North Africa.csv", na = c("..", "NA"))
# middle.east.north.africa <- middle.east.north.africa[!(middle.east.north.africa$`Country Name` %in% c("Data from database: World Development Indicators", "Last Updated: 11/21/2017", "")), ]
# write_csv(middle.east.north.africa, "cleaned/Middle East & North Africa.csv")
# 
# north.america <- read_csv("North America.csv", na = c("..", "NA"))
# north.america <- north.america[!(north.america$`Country Name` %in% c("Data from database: World Development Indicators", "Last Updated: 11/21/2017", "")), ]
# write_csv(north.america, "cleaned/North America.csv")
# 
# south.asia <- read_csv("South Asia.csv", na = c("..", "NA"))
# south.asia <- south.asia[!(south.asia$`Country Name` %in% c("Data from database: World Development Indicators", "Last Updated: 11/21/2017", "")), ]
# write_csv(south.asia, "cleaned/South Asia.csv")
# 
# sub.saharan.africa.p1 <- read_csv("Sub-Saharan Africa p1.csv", na = c("..", "NA"))
# sub.saharan.africa.p2 <- read_csv("Sub-Saharan Africa p2.csv", na = c("..", "NA"))
# sub.saharan.africa <- bind_rows(sub.saharan.africa.p1, sub.saharan.africa.p2)
# sub.saharan.africa <- sub.saharan.africa[!(sub.saharan.africa$`Country Name` %in% c("Data from database: World Development Indicators", "Last Updated: 11/21/2017", "")), ]
# write_csv(sub.saharan.africa, "cleaned/Sub-Saharan Africa.csv")
# 
# all.countries.data <- bind_rows(east.asia.pacific, europe.central.asia, latin.america.caribbean, middle.east.north.africa, north.america, south.asia, sub.saharan.africa)
# write_csv(all.countries.data, "cleaned/All countries data.csv")

# 
# rm(list = ls())
# setwd("/Users/macbookair/Downloads/World Development Indicators Data")
# all.countries <- read_csv("/Users/macbookair/Downloads/All countries, income and region/All Countries, income and regions.csv")
# data <- read_csv("cleaned/All countries data.csv")
# data <- gather(data, Year, values, -c(`Country Name`, `Country Code`, `Series Name`, `Series Code`))
# data$Year <- as.numeric(substr(data$Year, 1, 4))
# data <- data[,c(1,3,5,6)]
# names(data) <- c("country", "series", "year", "values")
# 
# head(data)
# head(all.countries)
# anti_join(data, all.countries, by = "country")
# 
# data <- full_join(data, all.countries, by = "country")
# head(data)
# 
# unique(data$series)
# keepSeries <- c("GDP (current US$)", "Life expectancy at birth, female (years)", "Life expectancy at birth, male (years)")
# data <- data[(data$series %in% keepSeries), ]
# nrow(data)


ui <- fluidPage(
  titlePanel("Explore Development Data"),
  sidebarLayout(
    sidebarPanel(
      wellPanel(
        checkboxGroupInput("checkbox", "Filter by:", choices = c("region", "income"), choiceValues = c(F,F), inline = T),
        conditionalPanel(
          condition = "input.checkbox=='By Region'",
          selectInput("rgn", "Select Region:", choices = as.character(levels(factor(data$Region))), selected = "South Asia", multiple = T)
        ),
        conditionalPanel(
          condition = "input.checkbox=='By Income'",
          selectInput("inc", "Select Income:", choices = as.character(levels(factor(data$Income))), selected = "Low Income", multiple = F)
        ),
        selectInput("cntry", "Select Countr(ies):", choices = as.character(levels(factor(data$country))), selected = "Afghanistan", multiple = T),
        selectInput("ndkr", "Select Indicator:", choices = as.character(levels(factor(data$series))), selected = "GDP (current US$)", multiple = F),
        sliderInput("yrs", "Select Period", min = min(data$year), max = max(data$year), value = c(min(data$year), max(data$year)))
      )
    ),
    mainPanel(plotlyOutput("myplot"))
  )
)
server <- shinyServer(function(input, output){
  output$myplot <- renderPlotly({
    g <- data[c(data$country %in% input$cntry & data$series %in% input$ndkr & data$year %in% input$yrs[1]:input$yrs[2]), ] %>%
      ggplot() + geom_line(mapping = aes(x=year, y=values, col=country)) + labs(x="Year",y=input$ndkr) + theme_bw()
    ggplotly(g)
  })
})
shinyApp(ui = ui, server = server)
