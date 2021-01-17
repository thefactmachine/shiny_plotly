# https://www.aridhia.com/blog/using-shiny-modules-to-simplify-building-complex-apps/

# more comprehensive here:
# https://shiny.rstudio.com/articles/modules.html


# A shiny module is a piece of a Shiny application.  It CANNOT be directly
# run. Modules can represent input, output ... or both...

# Once created, a Shiny module can easily be reused. Whether accross
# different apps or multiple times in a single app. 

# CREATING UI
# A module's UI function should be given a name that is suffixed with 
# Input, Output or UI.


# following is some stuff to make it easier to understand the code

id <- "counter1"
ns <- NS(id)
label <- "something"

# tagList converts the contents into an html list
htmltools::tagList(
  # generates <button id="counter1-button" .......>something</button>
  actionButton(ns("button"), label = label),
  
  # look how we are generating
  # generates <pre id="counter1-mark" ..... </pre>
  verbatimTextOutput(ns("mark"))
)


# ===========================================================================
# ===========================================================================

library(shiny)


fn_counterButton <- function(id, label = "Counter") {
  ns <- NS(id)
  
  # tagList converts the contents into an html list
  htmltools::tagList(
    actionButton(ns("button"), label = label),
    verbatimTextOutput(ns("out"))
  )

}

counterServer <- function(id) {
 moduleServer(
    id,
    function(input, output, session) {
      
      count <- reactiveVal(3)
      
      # when input$button does something ... then do something...
      observeEvent(input$button, { count(count() + 1) })
      
      # send something to verbatimTextOutput()
      output$out <- renderText({ count() })
      
      return(count)
    } # function
  ) # moduleServer
} # counterServer


ui <- fluidPage(fn_counterButton("counter1", "Counter #1"))

server <- function(input, output, session) {
  counterServer("counter1")
}

shinyApp(ui, server)
