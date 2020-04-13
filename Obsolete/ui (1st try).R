
library(tidyverse)
library(shiny)

shinyUI(fluidPage(
  (pageWithSidebar(
  headerPanel("Input data to generate the Patient Visit calculator"),
  sidebarPanel(
    numericInput('Nr_visits', 'Enter # of Study Visits', 0, min = 0, max = 50, step = 1),
    
    vector_visits <- vector(mode = "numeric", length = output$oNr_visits),
    for(i in output$oNr_visits) {
      numericInput('Window_visit [i]', 'Enter # days until next Study Visit')
    }
    
    dateInput("date", "Date of randomizacion:")  
  ),
  
  mainPanel(
        h3('Illustrating outputs'),
        h4('You entered'),
        verbatimTextOutput("oid1"),
        h4('You entered'),
        verbatimTextOutput("oid2"),
        h4('You entered'),
        verbatimTextOutput("odate")
  )
  ))
))
