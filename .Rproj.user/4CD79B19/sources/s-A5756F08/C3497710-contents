library(shiny)
library(ggplot2)
library(tidyverse)


ui <- fluidPage(
  actionButton("goodnight", "Good night")
)

server <- function(input, output, session) {

  
    observeEvent(input$goodnight, {
    
    # these print a message down the bottom of the screen
    # message stays on for 3 seconds and then dissapears.
    showNotification("So long", duration = 3, type = "error")
#    Sys.sleep(5)
 #   showNotification("Farewell")
  #  Sys.sleep(1)
  #  showNotification("Auf Wiedersehen")
   # Sys.sleep(1)
  #  showNotification("Adieu")
  
    })

  
}

shinyApp(ui, server) 
