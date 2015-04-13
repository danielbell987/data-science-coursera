best <- function(state, outcome) {
  ## Read outcome data
  outcomes <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Possible outcomes
  outs <- c("heart attack", "heart failure", "pneumonia")
  
  ## Check that state and outcome are valid
  if (!(state %in% outcomes[,7])) stop("invalid state")
  if (!(outcome %in% outs)) stop("invalid outcome")
  
  ## Return hospital name in that state with lowest 30-day death rate
  best <- NULL
  
  if(outcome == "heart attack")   n = 11
  if(outcome == "heart failure")  n = 17
  if(outcome == "pneumonia")      n = 23
    
  data <- subset(outcomes, state == State)
  c<- as.numeric(data[,n])
  bestc <- min(c, na.rm = TRUE)
  best <- sort(data[which(c == bestc), 2])
  best[1]
  
  best
}