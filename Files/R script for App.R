

library(tidyverse)
library(shiny)
library(shinythemes)


data("Titanic")
Titanic <- as.data.frame(Titanic)

input <- "All"


######################################################

ifelse (input =="All", Titanic_subset <- Titanic, 
       Titanic_subset <- Titanic %>% filter(Class == input)
       )
       
        if (input$Sex == "Male") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Male")}
        if (input$Sex == "Female") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Female")}
        if (input$Sex == "Both") {Titanic_subset <- Titanic_subset}
        
        ploteo <- ggplot(Titanic_subset, aes(x = Class, y = Freq, fill = Survived ) ) + 
            geom_bar(stat = "identity", position = position_dodge() ) +
            ylab("Number of passengers")
        
        ploteo
    
    

####  RENDER del TOTAL DE PASAJEROS

        
        Titanic_subset <- Titanic %>% filter(Class == input$PassengerClass)
        
        if (input$Sex == "Male") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Male")}
        if (input$Sex == "Female") {Titanic_subset <- Titanic_subset %>% filter(Sex == "Female")}
        if (input$Sex == "Both") {Titanic_subset <- Titanic_subset}
        
        print(paste0(c("Total # of passengers chosen =", Titanic_subset %>% summarise(sum(Freq)) )) )
        
        