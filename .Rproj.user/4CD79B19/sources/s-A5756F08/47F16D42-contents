library(shiny)
library(ggplot2)

ui <- basicPage(
  # id is plot. reffered to as output$plot
  # we register the "plot_click" event. This becomes input$plot_click
  # note that the object is a sink for output graphics but a source for
  # click events.
  plotOutput("plot", click = "plot_click"),

  # id is info. refferred to as output$info
  verbatimTextOutput("info")
)

server <- function(input, output) {

  output$plot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  }, res = 96) # renderPlot



  # renderPrint()
  output$info <- renderPrint({

    # if any of the args is not truthy
    req(input$plot_click)

    x <- round(input$plot_click$x, 2)

    y <- round(input$plot_click$y, 2)

    cat("[", x, ", ", y, "]", sep = "")
  }) # renderPrint


} # server

shinyApp(ui, server)
