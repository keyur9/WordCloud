library(shiny)
library(SnowballC)
library(wordcloud)
library(tm)

# Define server logic
shinyServer(function(input, output) {
  
  d <- reactive({
    validate(
      need((!is.null(input$File)),
           "Please give me some text to work upon!"
      )
    )  
    
    if(!is.null(input$File)){
      a <- input$File$datapath
      doc <- readLines(a)
    }
  })
  
  wc_repeat <- reactive({
    if (input$repeated) wordcloud_rep <- repeatable(wordcloud)
    else wordcloud_rep <- wordcloud
  })

  make_cloud <- reactive ({
    
    wordcloud_rep <- wc_repeat()
    png("wordcloud.png", width=10, height=8, units="in", res=350)
    w <- wordcloud_rep(d(),
                   scale=c(5, 0.5),
                   min.freq=input$min,
                   max.words=input$max,
                   use.r.layout=FALSE,
                   rot.per=input$rotate,
                   random.order=input$random,
                   colors=brewer.pal(8, "Dark2"))
    dev.off()
    
    filename <- "wordcloud.png"
  })
  
  output$distPlot <- renderImage({
    list(src=make_cloud(), alt="Image being generated!", height=450)
  },
  deleteFile = FALSE)
  
})