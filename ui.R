
library(shiny)
library(plotly)
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Flip coin simulation"),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      
      tabsetPanel(id="tabs",
                  tabPanel("1 coin",
                           numericInput("prob1","Probability of Heads (from 0 to 1):",
                                        value = 0.5,step = 0.1,min = 0,max = 1),
                           sliderInput("toss","Number of times flipping:",
                                       min = 20, max = 60, step=5,value = 40)
                           
                  ),
                  tabPanel("Multiple coins",
                           helpText("Click Run to start!"),
                           numericInput("probM","Probability of Heads (from 0 to 1):",
                                        value = 0.5,step = 0.1,min = 0,max = 1),
                           selectInput("trial","Number of flipping trial",
                                       choices = list("5"=5,"15"=15,"30"=30),
                                       selected = 15 ),
                           
                           sliderInput("numCoin","Number of coins flipping:",
                                       min = 1, max = 100, step=1,value = 40,
                                       animate = T),
                           actionButton("refresh","Run")
                  )
      )
    ),
    
    #OutPut
    mainPanel(
      h3(textOutput("title")),
      plotlyOutput("plot"),
      tableOutput("table")
      
    )
  )
))

