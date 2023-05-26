RS.fMRI_4.2_Extracting.Results___Pearson.Correlation___Upper.Triangle.Elements = function(combined_ROICorr.list){
  half_vectorized.list = list()
  for(k in 1:length(combined_ROICorr.list)){
    half_vectorized.list[[k]] = lapply(combined_ROICorr.list[[k]], FUN=function(ith_Sub){
      # ith_Sub = combined_ROICorr.list[[k]][[1]]
      ith_corr = gdata::upperTriangle(ith_Sub, diag = F, byrow = F) %>% matrix(nrow=1) %>% as.data.frame
      
    })
  }
  names(half_vectorized.list) = names(combined_ROICorr.list)
  return(half_vectorized.list)
}
