library(shiny)
source("mainFunction.R")
shinyServer(
  function(input, output, session) {
    
  output$dateText  <- renderText({
    paste("Stock of the day", as.character(input$date))
  })
  output$stockCodeText  <- renderText({
    paste("Selected stock", as.character(input$stockCode))
  })
  output$timingText <- renderText({
    paste("Stock information type", as.character(input$timing))
  })
  
  output$certainDateText <- renderText({
    input$goButton
    isolate(paste("Stock price", as.character(grubDate(input$stockCode, input$timing, input$date))))
  })
  
  output$newHist <- renderPlot({
    fcstStock <- GrabExchange(input$stockCode, input$timing)
    plot(fcstStock, xlab = "time", ylab = "forecast",type = "l", col = "blue")
  })
   output$forecastText <- renderDataTable({
     input$goButton
     isolate(GrabExchange(input$stockCode, input$timing))
   })
  
  
  }
)
