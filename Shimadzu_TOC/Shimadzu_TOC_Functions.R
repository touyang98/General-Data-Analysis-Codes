extract_cal <- function(data, std_conc){
  
  cal <- subset(data, Type == "Standard")
  
  cal_1 <- aggregate(Area ~ `Spl. No.`, data = cal, FUN = mean)
  
  cal_1$std_conc <- std_conc
  
  cal_1 <- cal_1[,2:3]
  
  return(cal_1)
}


plot_cal <- function(data, fit){
  
  eq <- paste0("y = ",round(coef(fit)[2],2), " x + ",round(coef(fit)[1],2))
  
  ggplot(data,aes(x = std_conc, y = Area)) + geom_point(size = 3) + geom_smooth(method = "lm", linetype = "dashed", linewidth = 1.5, color = "lightblue3") + theme_bw() + theme(panel.grid = element_line(color = "gray", linewidth = 0.2, linetype = "dashed"), axis.title = element_text(size = 12, face = "bold"), axis.text = element_text(size = 12)) + ylab("Instrumental Signals") + annotate(geom = "text", label = eq, x = -Inf, y = Inf, hjust = -0.1, vjust = 2,fontface = "bold",size = 4.5, color = "navy")
}