library(tidyverse)
library(vroom)
library(shiny)

injuries <- vroom::vroom("neiss/injuries.tsv.gz")
products <- vroom::vroom("neiss/products.tsv")
population <- vroom::vroom("neiss/population.tsv")

# create named vector
test_struct <- setNames(products$prod_code, products$title)
class(test_struct)

#<< ui
ui <- fluidPage(
  fluidRow(
    column(6,
      # input so need to handle input$ID >>> input$code
      selectInput("code", "Product", setNames(products$prod_code, products$title))
    )
  ),

  # outputs ... so referenced in server() function
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location"))
  ),
  fluidRow(
    column(12, plotOutput("age_sex"))
  ) # fluidRow
) # fluid page







#<< server
server <- function(input, output, session) {

  # we are searching for "code" portion of input$code
  # this "code" is the id of selectInput
  selected <- reactive(injuries %>% filter(prod_code == input$code))

  output$diag <- renderTable(
    # selected is the injuries data.frame subset by the product code
    # grouped by diagnosis
    selected() %>% count(diag, wt = weight, sort = TRUE)
  )
  
  output$body_part <- renderTable(
    # selected is the injuries data.frame subset by the product code
    # grouped by body part
   selected() %>% count(body_part, wt = weight, sort = TRUE)
  )
  
  output$location <- renderTable(
    # grouped by location
    selected() %>% count(location, wt = weight, sort = TRUE)
  )

  # create data.frame called "summary"
  # create a "rate" column based on demographic information.
  # summary() is only used by a single reactive consumer.

  # the reactive() function will be executed each time the associated
  # input changes its value.
  
  summary <- reactive({
    selected() %>%
      count(age, sex, wt = weight) %>%
      left_join(population, by = c("age", "sex")) %>%
      mutate(rate = n / population * 1e4)
  })

  
  output$age_sex <- renderPlot({
    summary() %>%
      ggplot(aes(age, n, colour = sex)) +
      geom_line() +
      labs(y = "Estimated number of injuries")
  }, res = 96)
}
#>>

shinyApp(ui, server)
