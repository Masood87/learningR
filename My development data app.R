rm(list = ls())

require(readr)
require(tidyr)
require(data.table)
require(shiny)
require(ggplot2)
require(plotly)
require(rsconnect)

setwd("/Users/smsadat/Downloads/Data_Extract_From_World_Development_Indicators")
data <- read_csv("6fd24b5f-7396-4502-a3f9-5af0db0ee589_Data.csv", na = c("..", "NA"))
data <- data[!(data$`Country Name` %in% c("Data from database: World Development Indicators", "Last Updated: 10/30/2017", "")), ]
data <- gather(data, Year, values, -c(`Country Name`, `Country Code`, `Series Name`, `Series Code`))
data$Year <- as.numeric(substr(data$Year, 1, 4))
data <- setorder(data, `Country Name`, `Series Name`, Year)
data <- data[,c(1,3,5,6)]
names(data) <- c("country", "series", "year", "values")
write.csv(data, "data.csv", row.names = F)
# remove_series <- c("Annual freshwater withdrawals, total (% of internal resources)",
            "Electric power consumption (kWh per capita)",
            "Energy use (kg of oil equivalent per capita)",
            "Forest area (sq. km)",
            "High-technology exports (% of manufactured exports)",
            "Income share held by lowest 20%",
            "Net migration",
            "Poverty headcount ratio at $1.90 a day (2011 PPP) (% of population)",
            "Poverty headcount ratio at national poverty lines (% of population)",
            "Prevalence of HIV, total (% of population ages 15-49)",
            "Prevalence of underweight, weight for age (% of children under 5)",
            "Primary completion rate, total (% of relevant age group)",
            "Surface area (sq. km)",
            "Terrestrial and marine protected areas (% of total territorial area)")
# data <- data[!(data$series %in% remove_series), ]
# keep_series <- c("Population, total","GDP (current US$)","GDP growth (annual %)")
# data <- data[data$series %in% keep_series, ]
# keep_country <- c("Afghanistan", "India")
# data <- data[data$country %in% keep_country, ]
# data <- data[data$year %in% seq(2000, 2016), ]
unique(data$year)
head(data)


ui <- shinyUI(
  fluidPage(
    titlePanel("Development Data: South Asia"),
    sidebarLayout(
      sidebarPanel(
        selectInput("country", "Select country:", choices = as.character(levels(factor(data$country))), selected = "Afghanistan"),
        selectInput("indicator", "Select indicator:", choices = as.character(levels(factor(data$series))), selected = "GDP (current US$)"),
        sliderInput("yr", "Select Years:", min = min(data$year), max = max(data$year), value = c(min(data$year), max(data$year)))
      ),
      mainPanel(
        plotlyOutput("myplot")
      )
    )
  )
)

server <- shinyServer(function(input, output) {
  output$myplot <- renderPlotly({
    g <- data[c(data$country %in% input$country & data$series %in% input$indicator & data$year %in% input$yr[1]:input$yr[2]), ] %>% 
      ggplot() + geom_line(mapping = aes(x=year, y=values, color = country)) + labs(x = "Year", y = "Values") + theme_bw()
    ggplotly(g)
  })
})

shinyApp(ui = ui, server = server)