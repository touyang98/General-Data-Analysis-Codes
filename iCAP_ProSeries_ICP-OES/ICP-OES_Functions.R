read_xml <- function(path){
  doc <- xmlParse(path)
  ns <- c(ss = "urn:schemas-microsoft-com:office:spreadsheet")
  
  rows <- getNodeSet(doc, "//ss:Worksheet/ss:Table/ss:Row", namespaces = ns)
  
  parse_row <- function(row) {
    cells <- getNodeSet(row, "./ss:Cell", namespaces = ns)
    
    out <- character(0)
    col_pos <- 1
    
    for (cell in cells) {
      # Check whether this cell has an explicit column index
      idx <- xmlGetAttr(cell, "ss:Index", default = NA)
      if (is.na(idx)) {
        idx <- xmlGetAttr(cell, "Index", default = NA)
      }
      
      if (!is.na(idx)) {
        col_pos <- as.integer(idx)
      }
      
      data_node <- getNodeSet(cell, "./ss:Data", namespaces = ns)
      value <- if (length(data_node) > 0) xmlValue(data_node[[1]]) else NA_character_
      
      out[col_pos] <- value
      col_pos <- col_pos + 1
    }
    
    out
  }
  
  data_list <- lapply(rows, parse_row)
  
  max_len <- max(lengths(data_list))
  
  data_list <- lapply(data_list, function(x) {
    length(x) <- max_len
    x
  })
  
  df <- as.data.frame(do.call(rbind, data_list), stringsAsFactors = FALSE)
  
  # first row as header, if appropriate
  colnames(df) <- as.character(df[1, ])
  df <- df[-1, , drop = FALSE]
  rownames(df) <- NULL
  
  # optional: convert numeric-looking columns
  df[] <- lapply(df, type.convert, as.is = TRUE)
  

return(df)

}

extract_inst <- function(data){
  
  cols <- which(grepl("Y \\(cps\\)", data[3, ]))
  
  data_i <- data[,cols]
  
  data_i <- data_i[, grepl("Raw\\.Average", colnames(data_i), ignore.case = TRUE)]
  
  data_i <- cbind(data[,2], data_i)
  
  colnames(data_i) <- data_i[2,]
  colnames(data_i)[1] <- "sample"
  data_i <- data_i[4:nrow(data_i),]
  
  return(data_i)
  
}


extract_ion <- function(ion, data) {
  
  pattern <- paste0("^", ion, "\\b")
  
  data_ion <- data[, grepl(pattern, colnames(data), ignore.case = TRUE), drop = FALSE]
  
  data_ion <- cbind(data$sample, data_ion)
  
  colnames(data_ion)[1] <- "sample"
  
  return(data_ion)
}


cal_curve <- function(data,std_row, iFR_col){
  
  cal <- data[std_row,c(1,iFR_col)]
  
  cal[,1] <- as.numeric(cal[,1])
  cal[,2] <- as.numeric(cal[,2])
  
  fit <- lm(cal[,2] ~ cal[,1])
  
  return(fit)
  
}

sample_conc <- function(fit, dilution_factor, data, iFR_col){
  
  data[,iFR_col] <- as.numeric(data[,iFR_col])
  
  conc <- ((data[,iFR_col]-coef(fit)[1])/coef(fit)[2])*dilution_factor
  
  return(conc)
  
}


