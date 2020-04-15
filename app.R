
library(tidyverse)
library(shiny)
library(shinythemes)


data("Titanic")
Titanic <- as.data.frame(Titanic)


# Define UI for application that draws a histogram
ui <- fluidPage(

    theme = shinytheme("readable"),
    
    # Application title
    titlePanel("Plotting Titanic survivors"),

    # Sidebar with a sliders for Class and Sex 
    sidebarLayout(
        sidebarPanel(
            
            selectInput(inputId = "PassengerClass", label = "Enter passenger category",
                        choices = c(levels(Titanic$Class), "All")  ),
                        
            selectInput("Sex", "Choose sex", choices = c(levels(Titanic$Sex), "Both")   ),
            submitButton(text = "Show Plot")
            
                    ),

        # Show a plot of the generated distribution
        mainPanel(
                tabsetPanel(type = "tabs", 
                        tabPanel(icon = icon("bar-chart"),
                                 title = "Plot",
                                 plotOutput("Tit_plot"),
                                 verbatimTextOutput("Nrpax") 
                                ),
                        
                        tabPanel(icon = icon("newspaper-o"),
                                 title = "Instructions",
                                 mainPanel(includeMarkdown("Instructions.md"))
                                 ) 
                            )
                     )
                  ),

    )
######################################################


server <- function(input, output) {

    output$Tit_plot <- renderPlot({
        
              ifelse (input$PassengerClass =="All", Titanic_subset <- Titanic, 
                     Titanic_subset <- Titanic %>% filter(Class == input$PassengerClass)
                     )
              
              if (input$Sex == "Male") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Male")}
              if (input$Sex == "Female") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Female")}
              if (input$Sex == "Both") {Titanic_subset <- Titanic_subset}
              
              ploteo <- ggplot(Titanic_subset, aes(x = Class, y = Freq, fill = Survived ) ) + 
                               geom_bar(stat = "identity", position = position_dodge() ) +
                               ylab("Number of passengers")
                              
              ploteo
                                })

    
    output$Nrpax <- renderPrint({
        
        ifelse (input$PassengerClass =="All", Titanic_subset <- Titanic, 
                Titanic_subset <- Titanic %>% filter(Class == input$PassengerClass)
        )
        
        if (input$Sex == "Male") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Male")}
        if (input$Sex == "Female") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Female")}
        if (input$Sex == "Both") {Titanic_subset <- Titanic_subset}
        
        print(paste0(c("Total # of passengers chosen =", Titanic_subset %>% summarise(sum(Freq)) )) )
        
        
    })
    
    
 }

# Run the application 
shinyApp(ui = ui, server = server)
