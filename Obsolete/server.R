
library(shiny)
shinyServer(
  function(input, output) 
    {
    
    output$sliders <- renderUI({
      numIndividuals <- as.integer(input$numIndividuals)
      lapply(1:numIndividuals, function(i) {
        sliderInput(inputId = i, label = "Window") })
    
    output$oid2 <- renderPrint({input$id2})
    
    output$odate <- renderPrint({input$date})
    })
  }
)
