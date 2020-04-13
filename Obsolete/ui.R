
library(tidyverse)
library(shiny)

shinyUI(fluidPage(
  (pageWithSidebar(
  headerPanel("Input data to generate the Patient Visit calculator"),
  sidebarPanel(
  selectInput("numIndividuals", "Enter # of Study Visits", choices = 1:100),
  uiOutput("sliders"),
  
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
