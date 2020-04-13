
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
                        ),
            selectInput("Sex", "Choose sex", choices = c(levels(Titanic$Sex), "Both")   )
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("Tit_plot"),
           verbatimTextOutput("Nrpax")
        )
    )
)


######################################################


server <- function(input, output) {

    output$Tit_plot <- renderPlot({
        
              Titanic_subset <- Titanic %>% filter(Class == input$PassengerClass)
              
              if (input$Sex == "Male") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Male")}
              if (input$Sex == "Female") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Female")}
              if (input$Sex == "Both") {Titanic_subset <- Titanic_subset}
              
              ploteo <- ggplot(Titanic_subset, aes(x = Class, y = Freq, fill = Survived ) ) + 
                               geom_bar(stat = "identity", position = position_dodge() ) +
                               ylab("Number of passengers")
                              
              ploteo
                                })

    
    output$Nrpax <- renderPrint({
        
        Titanic_subset <- Titanic %>% filter(Class == input$PassengerClass)
        
        if (input$Sex == "Male") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Male")}
        if (input$Sex == "Female") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Female")}
        if (input$Sex == "Both") {Titanic_subset <- Titanic_subset}
        
        print(paste0(c("Total # of passengers chosen =", Titanic_subset %>% summarise(sum(Freq)) )) )
        
        
    })
    
    
 }

# Run the application 
shinyApp(ui = ui, server = server)
