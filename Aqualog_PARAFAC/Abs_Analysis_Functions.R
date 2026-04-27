read_abs <- function(path_abs){
  
  ##read the data files from a folder 
  file_abs <- list.files(path_abs, pattern = "\\.dat$", full.names = TRUE, recursive = TRUE)
  
  data_abs <- lapply(file_abs, read.table, header = FALSE)
  
  ##name the data files 
  
  names(data_abs) <- sub("\\.dat$", "", basename(file_abs))

for (i in 1:length(data_abs)){
  
  colnames(data_abs[[i]]) <- c("wavelength", "abs")
  
  ##correct all negative values
  data_abs[[i]]$abs[data_abs[[i]]$abs < 0] <- 0
}

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
