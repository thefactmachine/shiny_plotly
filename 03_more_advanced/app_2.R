library(shiny)
library(ggplot2)


ui <- fluidPage(
  plotOutput("plot", click = "click"),
  tableOutput("data")
)


server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  }, res = 96)

  output$data <- renderTable({
    nearPoints(mtcars, input$click, xvar = "wt", yvar = "mpg")
  })
}



shinyApp(ui, server)
