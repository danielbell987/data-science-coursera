corr <- function(directory, threshold = 0) {

  ## Create a list of all csv files in 'directory'
  files <- list.files(directory, pattern = "*.csv", full.names = TRUE)
  
  ## Load all csv files into one data frame
  data <- lapply(files, read.csv, header = TRUE)
  data <- do.call(rbind, data)
  
  ## Create a table of all files that meet the threshold
  completeCases <- complete(directory, 1:332)
  completeCases <- subset(completeCases, nobs > threshold)
  
  ## Create a vector of correlations
  vec <- vector()
  for (id in completeCases$id){
    file <- subset(data, ID == id)
    file <- file[complete.cases(file),]
    corr <- cor(file$sulfate, file$nitrate)
    vec <- c(vec, corr)
  }

  ## Return a numeric vector of correlations
  vec
}