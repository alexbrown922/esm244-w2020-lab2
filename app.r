# Attach packages

library(tidyverse)
library(shiny)
library(shinythemes)
library(here)

#Read in spooky_data.csv

spooky <- read_csv(here("data", "spooky_data.csv"))

# Create my user interface

ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("RCP in Austin, Texas"),
  sidebarLayout(
    sidebarPanel("My widgets are here",
                 selectInput(inputId = "state_select",
                             label = "Choose a state:",
                             choices = unique(spooky$state)
                 )
                 ),
    mainPanel("My outputs are here!",
              tableOutput(outputId = "candy_table")
              )
  )
)

server <- function(input, output) {

  state_candy <- reactive({
    spooky %>%
      filter(state == input$state_select) %>%
      select(candy, pounds_candy_sold)
  })

  output$candy_table <- renderTable({
    state_candy()
  })
}

shinyApp(ui = ui, server = server)
