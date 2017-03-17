library(shiny)

# Define UI for application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Document WordCloud!"),
  sidebarLayout(
    sidebarPanel(
      strong("Settings:"),
      checkboxInput("random", label = "Random Order", value = FALSE),
      checkboxInput("repeated", label = "Repeatable", value = FALSE),
      tags$hr(),
      fileInput("File", "Select File to upload", multiple = FALSE, 
                accept = c("text/plain", ".txt"), width = NULL),
      tags$hr(),
      sliderInput("min",
                  "Minimun Frequency",
                  min = 1,
                  max = 50,
                  value = 15),
      tags$hr(),
      sliderInput("rotate", "Rotation:",
                  min = 0.0, max = 1.0, value = 0.35),
      tags$hr(),
      sliderInput("max",
                  "Maximum Frequency",
                  min = 1,
                  max = 300,
                  value = 100)
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))