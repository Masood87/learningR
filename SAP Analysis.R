#### SAP analysis ####
require(feather)
require(data.table)
require(tidyr)
require(survey)
require(shiny)
require(shinydashboard)
require(dplyr)
sap <- 
sap$m6b[is.na(sap$m6b) & sap$m6a == 1] <- 1
sap$m6b[is.na(sap$m6b) & sap$m6a > 1] <- 2
sap <- sap[, sap %in% grep("G", names(sap), value = T)] %>% names()
sap.w <- svydesign(id = ~1, data = sap[!is.na(sap$MergeWgt10), ], weights = ~MergeWgt10)
svytable(~z1, sap.w) %>% prop.table() %>% data.frame()
svytable(~m8+z1, sap.w) %>% prop.table(margin = 2)

#
df <- data.frame(col1 = rnorm(20,0,1), col2 = rnorm(20,2,2), w = rnorm(20,1,.2))
df.w <- svydesign(id = ~1, data = df, weights = ~w)

ui <- fluidPage(
  fluidRow(
    box(selectInput("v1", "Choose X Variable", colnames(sap), selected = "z1")),
    box(selectInput("v2", "Choose Y Variable", colnames(sap), selected = "m8"))
  ),
  fluidRow(box(verbatimTextOutput("str1")),
           box(verbatimTextOutput("str2"))),
  fluidRow(tableOutput("table")),
  fluidRow(plotOutput("myplot"))
)
server <- function(input,output){
  output$str1 <- renderPrint({ str(sap[input$v1]) })
  output$str2 <- renderPrint({ str(sap[input$v2]) })
  data <- reactive({
    myformula <- as.formula(paste0("~", input$v1, "+", input$v2))
    temp <- svytable(myformula, sap.w) %>% prop.table(margin = 2)*100
    data.frame(temp) %>% spread(input$v2, Freq)
  })
  output$table <- renderTable({
    data()
  })
  output$myplot <- renderPlot({ plot(data()) })
}
shinyApp(ui, server)
#

# applying weights to tabulation
tw <- sum(sap$MergeWgt10, na.rm = T)
prop.table(table(sap$z1))
x <- sap[, sum(MergeWgt10), by = z1]
x$V1 <- (x$V1/tw)*100
# applying weights to cross-tab
table(sap$m8, sap$z1)
y <- sap[, sum(MergeWgt10), by = .(m8, z1)] %>% spread(z1, V1)
y$male <- (y$`1`/sum(y$`1`))*100
y$female <- (y$`2`/sum(y$`2`))*100
# line graph for right direction
library(ggplot2)
library(dplyr)
sap %>% filter(!is.na(MergeWgt10)) %>% group_by(m8) %>% summarise(right = mean(x4_m == 101)*100) %>% 
  ggplot(aes(x = m8, y = right)) + geom_line()
sap %>% filter(!is.na(MergeWgt10)) %>% group_by(m4, m8) %>% summarise(right = mean(x4_m == 101)*100) %>%
  ggplot(aes(x = m8, y = right, color = as.factor(m4))) + geom_line()
sap %>% filter(!is.na(MergeWgt10), m4 == 4 | m4 == 8) %>% group_by(m7, m8) %>% summarise(right = mean(x4_m == 101)*100, m4 = mean(m4)) %>%
  ggplot(aes(m8, right, color = as.factor(m7))) + geom_line() + facet_wrap(~ m4)

# Weighted using survey package
library(survey)
library(data.table)
sap <- na.omit(sap$MergeWgt10)
sap <- sap[m8==2017]
sap.w <- svydesign(ids = ~1, data = sap, weights = sap$MergeWgt10)
colnames(sap)
table(sap$m8)

