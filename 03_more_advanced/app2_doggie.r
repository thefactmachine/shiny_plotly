library(shiny)
library(ggplot2)
library(tidyverse)


puppies <- tibble::tribble(
  ~breed, ~ id, ~author,
  "corgi", "eoqnr8ikwFE","alvannee",
  "labrador", "KCdYn0xu2fU", "shaneguymon",
  "spaniel", "TzjMd7i5WQI", "_redo_"
)


ui <- fluidPage(
  # choices is a named (2nd arg) actual element is first arg
  selectInput("id", "Pick a breed", 
              choices = setNames(puppies$id, puppies$breed), 
              selected = "corgi"),

  htmlOutput("source"),

  imageOutput("photo")
  
)


server <- function(input, output, session) {
  
  
  
  # the actual photo
  output$photo <- renderImage({
    list(
      src = file.path("puppy-photos", paste0(input$id, ".jpg")),
      contentType = "image/jpeg",
      width = 500,
      height = 650
    )
  }, deleteFile = FALSE)
  

  
  
  # html output
  output$source <- renderUI({

    info <- puppies[puppies$id == input$id, , drop = FALSE]


    HTML(glue::glue("<p>
      <a href='https://unsplash.com/photos/{info$id}'>original</a> by
      <a href='https://unsplash.com/@{info$author}'>{info$author}</a>
    </p>"))
  })
  # renderUI
}


shinyApp(ui, server)
