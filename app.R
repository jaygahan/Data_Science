library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
data <- read.csv("data/Iris.csv")


ui <- dashboardPage(
        dashboardHeader(title = "Iris Data"),

        dashboardSidebar(
          sidebarMenu(
            menuItem("Iris Petals and Sepals"),
          
          selectInput("select", h3("Choose your Iris!"),
                      choices = c("Iris Setosa",
                                  "Iris Versicolor",
                                  "Iris Virginica")))),
  
        dashboardBody(
          
          fluidRow(
            img(src ="Iris_Pic.png", height = 140, width = 400),
            
          fluidRow(
           box(textOutput ("selected_select"))),
          
          fluidRow(
           box(textOutput("Setosa_text"))),
          fluidRow(
           box(textOutput("Versicolor_text"))),
          fluidRow(
           box(textOutput("Virginica_text"))),
          
          fluidRow(
            box(plotOutput("plot1")),
            box(plotOutput("plot2"))))))
          
server <- function(input, output){
  
  output$Setosa_text <- renderText({
    paste("Iris Setosa displayed in black")
  })
    
  output$Versicolor_text <-renderText({
    paste("Iris Versicolor displayed in red")
  })
  output$Virginica_text <- renderText({
    paste("Iris Virginica displayed in green")
  })
  
  output$selected_select <- renderText({
    paste("You have selected", input$select)
    
  })
  
  data <- reactive({
    get(iris$Petal.Legth, iris$Petal.Width, iris$Species)
  })
  
  output$plot1 <- renderPlot({
    plot(x = iris$Petal.Length,
        y = iris$Petal.Width,
        main = "Iris Petal Length/Width",
        col = as.numeric(iris$Species),
        xlab = "Petal Length",
        ylab = "Petal Width")
 })
  
  data <- reactive({
    get(iris$Sepal.Length, iris$Sepal.width, iris$Species)
  })
  
  output$plot2 <- renderPlot({
    hist(x = iris$Petal.Length,
         main = "Iris Petal Length",
         col = (iris$Species),
         xlab = "Petal Length")
  })
}
         
shinyApp(ui, server)