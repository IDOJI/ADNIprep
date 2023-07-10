RS.fMRI_5_BOLD.Signals___ROI___Standardization = function(path_BOLD.Signals, method = "Z"){
  BOLD.df = readRDS(path_BOLD.Signals)
  BOLD.mat = as.matrix(BOLD.df)
  if(method == "Z"){
    Standardized.mat = (BOLD.mat - mean(BOLD.mat))/sd(BOLD.mat)
    Standardized.df = data.frame(Standardized.mat)
    return(Standardized.df)
  }else{
    stop("")
  }



}
