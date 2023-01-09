RS.fMRI_4.2_Extracting.Results___ROI.Signals___Matplot.for.Each.ROI.Signals = function(data.list, save.path, group.name){
  # data.list = Combined_ROI_df.list[[1]]
  save.path %>% setwd

  for(i in 1:length(data.list)){
    png(paste0(group.name, "_", names(data.list)[i], ".png"))
    matplot(data.list[[i]], type="l", xlab = names(data.list)[i], ylab="BOLD signals")
    dev.off()
  }
}
