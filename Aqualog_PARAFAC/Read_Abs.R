read_abs <- function(path_abs){
  
  ##read the data files from a folder 
  file_abs <- list.files(path_abs,  pattern = "\\.dat$", full.names = TRUE)
data_abs <- lapply(file_abs, read.table, header = TRUE)

##name the data files 
names(data_abs) <- sub("\\.dat$", "", basename(file_abs))

return(data_abs)

}
