rankall <- function(outcome, numb = "best") {
  ## Read outcome data
  outcomes <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Possible outcomes
  outs <- c("heart attack", "heart failure", "pneumonia")
  
  ## Check that state and outcome are valid
  if (!(outcome %in% outs)) stop("invalid outcome")
  
  if(outcome == "heart attack")   n = 11
  if(outcome == "heart failure")  n = 17
  if(outcome == "pneumonia")      n = 23
  
  results <- data.frame(hospital = character(length = 0), state = character(length = 0))
  results$hospital <- as.character(results$hospital)
  results$state <- as.character(results$state)
  u <- unique(outcomes$State)
  m <- 1
  
  ## Return hospital name in that state with the given rank 30-day death rate
  for(s in u){
    data <- subset(outcomes[,c(2,7,n)], s == State)
    data[,3] <- as.numeric(data[,3])
    orderData <- data[order(data[,3], data[,1]),]
    cc <- complete.cases(orderData[,3])
    orderData <- orderData[cc, ]
  
    num <- numb
    if(numb == "worst") num <- nrow(orderData)
    if(numb == "best") num <- 1
    
    a <- orderData[num, 1]
    
    results[m,1] <- a
    results[m,2] <- s
    
    m <- m + 1
  }
  
  finalresults <- results[order(results$state),]
  finalresults
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
}