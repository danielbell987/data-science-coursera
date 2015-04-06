complete <- function(directory, id = 1:332) {
  
  ## Location of the data
  datadir <- paste(directory, "/", sep = "")
  
  ## Create a list of required files based on ids given
  filelist <- list()
  for(i in id){
    if(i > 99){
      filelist <- c(filelist, paste(i, ".csv", sep = ""))
    }
    else if(i > 9){
      filelist <- c(filelist, paste("0", i, ".csv", sep = ""))
    }
    else{
      filelist <- c(filelist, paste("00", i, ".csv", sep = ""))
    }
  }
  
  ## Load all csv files into one data frame
  data <- lapply(paste(datadir, filelist, sep = ""), read.csv, header = TRUE)
  data <- do.call(rbind, data)
  
  ## Create an empty data frame with columns 'id' & 'nobs'
  results <- data.frame(id = numeric(0), nobs = numeric(0))
  
  ## For each file add its id and number of complete cases to the data frame
  m <- 1
  for(i in id){
    results[m,1] <- i
    file <- subset(data, ID == i)
    results[m,2] <- sum(complete.cases(file))
    m <- m+1
  }
  
  results
}