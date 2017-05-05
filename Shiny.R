#### Shiny ####

library(shiny)


### user interface ui tells how to the html looks like, such as fonts, background color
ui <- fluidPage(
  titlePanel("here is the title"),
  sidebarLayout(
    sidebarPanel(
      #code for header 3
      h3("Fiji earthquake data"),
      #code for slidebar input
      sliderInput(
        inputId = "sld01_Mag",
        label = "Show earthquakes of magnitude:",
        min = min(df$var),
        max = max(df$var),
        value = c(min(df$var), max(df$var)),
        step = 0.1
      )
    ),
    mainPanel(
      #code to position plot output
      plotOutput(
        outputId = "hist01"
      )
    )
  )
)



### server is how to build the shiny app
server <- shinyServer(function(input, output) {
  #code to create and render the plot
  output$hist01 <- renderPlot({
    dfSub <- df[df$var >= input$sld01_mag[1] & df$var <= input$sld01_mag[2],]
    ggplot(dfSub, aes(x = var)) + geom_histogram() + xlab("xlab") + xlim(min(df$var2), max(df$var2)) + ylab("ylab") + ggtitle("title")
  })
})



shinyApp(ui = ui, server = server)

