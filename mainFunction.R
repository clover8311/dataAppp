library(quantmod)
library(forecast)
GrabExchange <- function(stockCode, timingType) {
  # get the stock data
  getSymbols(stockCode);
  periods <- 20
  # clean the data
  if(stockCode == "GOOG") {
    df <- data.frame(Date=time(GOOG), GOOG, check.names=FALSE, row.names=NULL)
  } else if (stockCode == "AAPL") {
    df <- data.frame(Date=time(AAPL), AAPL, check.names=FALSE, row.names=NULL)
  } else if (stockCode == "ORCL") {
    df <- data.frame(Date=time(ORCL), ORCL, check.names=FALSE, row.names=NULL)
  } else if (stockCode == "FB") {
    df <- data.frame(Date=time(FB), FB, check.names=FALSE, row.names=NULL)
  }
  print(timingType)
  if(timingType == "open") {
    stockDat <- df[,2];
  } else if (timingType == "high") {
    stockDat <- df[,3];
  } else if (timingType == "close") {
    stockDat <- df[,5];
  } else if (timingType == "volume") {
    stockDat <- df[,6];
  } else if (timingType == "low") {
    stockDat <- df[,4];
  } 
  
  ts1 <- ts(stockDat, frequency = 261);
  preData <- stlf(ts1)
  #stockPlot <- plot(ts1, xlab = "Months+1", ylab = stockCode);
  fcst <- forecast(preData, h = periods);
  lastDay <- df[length(df[,1]),1];
  dateCol <- seq(as.Date(lastDay + 1), by = "day", length.out = periods);
  fcst <- data.frame(fcst);
  fcstValue <- cbind(data.frame(time=dateCol), fcst$Point.Forecast);
  colnames(fcstValue) <- c("time", "forecast")
  return(fcstValue)
}

grubDate <- function(stockCode, timingType, selectDate){
  # get the stock data
  getSymbols(stockCode);
  selectDate <- as.Date(selectDate);
  # clean the data
  if(stockCode == "GOOG") {
    selectStockDate <- GOOG[selectDate];
  } else if (stockCode == "AAPL") {
    selectStockDate <- AAPL[selectDate];
  } else if (stockCode == "ORCL") {
    selectStockDate <- ORCL[selectDate];
  } else if (stockCode == "FB") {
    selectStockDate <- FB[selectDate];
  }
  df <- data.frame(selectStockDate)
  if(timingType == "open") {
    stockDat <- df[,1];
  } else if (timingType == "high") {
    stockDat <- df[,2];
  } else if (timingType == "close") {
    stockDat <- df[,4];
  } else if (timingType == "volume") {
    stockDat <- df[,5];
  } else if (timingType == "low") {
    stockDat <- df[,3];
  } 
  print(stockDat)
  if (length(stockDat) > 0) {
    return(stockDat)
  } else {
    return("not available")
  }
  
}


