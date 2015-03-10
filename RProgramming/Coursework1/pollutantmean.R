pollutantmean <- function(directory, pollutant, id = 1:332) {
  
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

  ## Calculate and return mean of selected pollutant
  if(pollutant == "nitrate"){
    polmean <- mean(na.omit(data$nitrate))
  }
  if(pollutant == "sulfate"){
    polmean <- mean(na.omit(data$sulfate))
  }

  polmean
}