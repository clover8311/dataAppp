library(shiny)
shinyUI(
  fluidPage(
    headerPanel("Check and Predict Stock Price"),
    h3("Enter Stock Information"),
    column(4, wellPanel(
      dateInput('date',
                label = 'Date input: yyyy-mm-dd',
                value = Sys.Date()
      ),
      selectInput("stockCode", "Stock code:", choices = c('GOOG' = 'GOOG', 'AAPL' = 'AAPL', 'ORCL' = 'ORCL', 'FB' = 'FB')),
      selectInput("timing", "Stock info type:", choices = c('open' = 'open', 'high' = 'hign', 'close' = 'close', 'low' = 'low', 'volume' = 'volume')),
      actionButton("goButton", "Check")
     )),
    column(6,
    h3("Stock Information"),
    verbatimTextOutput("dateText"),
    verbatimTextOutput("stockCodeText"),
    verbatimTextOutput("timingText"),
    verbatimTextOutput("certainDateText"),
    h3("Predict next 20 days stock price"),
    plotOutput("newHist"),
    dataTableOutput("forecastText")
    )
    
))