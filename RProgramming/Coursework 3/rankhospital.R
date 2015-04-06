rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcomes <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Possible outcomes
  outs <- c("heart attack", "heart failure", "pneumonia")
  
  ## Check that state and outcome are valid
  if (!(state %in% outcomes[,7])) stop("invalid state")
  if (!(outcome %in% outs)) stop("invalid outcome")
  
  if(outcome == "heart attack")   n = 11
  if(outcome == "heart failure")  n = 17
  if(outcome == "pneumonia")      n = 23  
  
  ## Return hospital name in that state with the given rank 30-day death rate
  data <- subset(outcomes[,c(2,7,n)], state == State)
  data[,3] <- as.numeric(data[,3])
  orderData <- data[order(data[,3], data[,1]),]
  cc <- complete.cases(orderData[,3])
  orderData <- orderData[cc, ]
  
  if(num == "worst") num <- nrow(orderData)
  if(num == "best") num <- 1
  
  a <- orderData[num, 1]
  a
}