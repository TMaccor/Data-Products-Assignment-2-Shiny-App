
library(tidyverse)
library(shiny)

data("Titanic")
Titanic <- as.data.frame(Titanic)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Plotting Titanic survivors"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            
            selectInput(inputId = "PassengerClass", label = "Enter Passenger Class",
                        choices = levels(Titanic$Class)
                        )
            
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("Tit_plot")
        )
    )
)


######################################################


server <- function(input, output) {

    output$Tit_plot <- renderPlot({
        
              Titanic_subset <- Titanic %>% filter(Class == input$PassengerClass)
              
              ploteo <- ggplot(Titanic_subset, aes(x = Class, y = Freq, fill = Survived ) ) + 
                               geom_bar(stat = "identity", position = position_dodge() 
                              )
              ploteo
                                })

 }

# Run the application 
shinyApp(ui = ui, server = server)
