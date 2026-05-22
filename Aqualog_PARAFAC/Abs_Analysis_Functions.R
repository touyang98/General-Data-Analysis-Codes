read_abs <- function(path_abs) {
  file_abs <- list.files(path = path_abs, pattern = "\\.dat$", full.names = TRUE)
  
  # Read files, skipping the first 3 lines
  data_abs <- lapply(file_abs, function(f) {
    # skip = 3 ignores the three header rows
    # col.names allows us to define the column names immediately
    df <- read.table(f, skip = 3, header = FALSE, sep = "\t")
    
    # Assuming the first column is Wavelength (col 1) and XCorrect is the Absorbance (col 6)
    # Adjust the indices [ , c(1, 6)] if your column order is different
    df <- df[, c(1, 10)]
    
    colnames(df) <- c("wavelength", "abs")
    
    # Force conversion to numeric
    df$wavelength <- as.numeric(df$wavelength)
    df$abs <- as.numeric(df$abs)
    
    # Correct negative values
    df$abs[df$abs < 0] <- 0
    
    return(df)
  })
  
  names(data_abs) <- sub(".dat", "", basename(file_abs))
  return(data_abs)
}


blank_subtract <- function(blank, data){
  
  for(i in 1:length(data)){
    
    for (ii in 1:nrow(data[[i]])){
      
      data[[i]]$abs[ii] <- data[[i]]$abs[ii] -data[[blank]]$abs[ii]
      
    }
  }
  
  data <- data[-blank]
  
  return(data)
  
}

abs_parm_plus <- function(data){
  
  slope_parm <- list()
  
  for (i in 1:length(data)){
    
    slope_parm[[i]] <- abs_parms(data[[i]], cuvl = 1)
  
  }
  
  slope_parm <- data.frame(do.call(rbind, slope_parm))
  
  slope_parm$sample <- names(data)
  
  return(slope_parm)
}
