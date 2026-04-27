eem_corr <- function(data, blank){
  
  for(i in 1:length(data)){
    
    data[[i]][["x"]] = data[[i]][["x"]] - data[[blank]][["x"]]
    
    data[[i]][["x"]][data[[i]][["x"]] < 0] <- 0
    
  }
  
  data <- data[-blank]
  
  # restore eemlist class (critical)
  class(data) <- unique(c("eemlist", class(data)))
  
  return(data)
  
}


eem_indice <- function(data, output_name){
  
  bix <- eem_biological_index(data)
  coble_peaks <- eem_coble_peaks(data)
  fi <- eem_fluorescence_index(data)
  hix <- eem_humification_index(data)
  output_name <- bix %>%
    full_join(coble_peaks, by = "sample") %>%
    full_join(fi, by = "sample") %>%
    full_join(hix, by = "sample")
  
  return(output_name)
  
}


PARAFAC_output <- function(data_PARAFAC, data_name, model){
  
  data_name <- as.data.frame(data_PARAFAC[[model]][["A"]])
  
  data_name$sample <- rownames(data_name)
  
  return(data_name)
  
}


extract_inst <- function(data){
  
  data <- subset(data, data[])
  
}