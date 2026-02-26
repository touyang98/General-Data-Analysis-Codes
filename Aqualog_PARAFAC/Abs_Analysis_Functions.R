read_abs <- function(path_abs){
  
  ##read the data files from a folder 
  file_abs <- list.files(path_abs,  pattern = "\\.dat$", full.names = TRUE)
data_abs <- lapply(file_abs, read.table, header = FALSE)

##name the data files 
names(data_abs) <- sub("\\.dat$", "", basename(file_abs))

for (i in 1:length(data_abs)){
  colnames(data_abs[[i]]) <- c("wavelength", "abs")
}

return(data_abs)

}
