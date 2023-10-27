RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Median.FC___Extracting.Median.Coordinate = function(ith_VoxelwiseBoldSignals,
                                                                                                            kth_Region_Coordinate,
                                                                                                            j,
                                                                                                            k){
  #===========================================================================
  # Brain regions
  #===========================================================================
  Brain_Regions = names(ith_VoxelwiseBoldSignals)




  #===========================================================================
  # Signals
  #===========================================================================
  jth_Signals = ith_VoxelwiseBoldSignals[[j]]
  kth_Signals = ith_VoxelwiseBoldSignals[[k]]




  #===========================================================================
  # Compute functional connectivity of these indices
  #===========================================================================
  jk_FC = sapply(1:nrow(kth_Region_Coordinate), function(m){
    j_m_Signals = jth_Signals[kth_Region_Coordinate[m,1], ]
    k_m_Signals = kth_Signals[kth_Region_Coordinate[m,2], ]
    jk_cor = cor(j_m_Signals, k_m_Signals)
    jk_fisher_z = 0.5 * log((1 + jk_cor) / (1 - jk_cor))
  })






  #=========================================================================
  # FC median
  #=========================================================================
  jk_FC_sorted = sort(jk_FC)
  n = length(jk_FC_sorted)
  if(n %% 2 == 0){
    # If the number of elements is even, calculate the mean of the two middle values
    jk_FC_median = jk_FC_sorted[n/2]
  }else{
    # If the number of elements is odd, find the middle value
    jk_FC_median = jk_FC_sorted[(n + 1) / 2]
  }








  #=========================================================================
  # find median
  #=========================================================================
  jk_FC_median_index = kth_Region_Coordinate[which(jk_FC == jk_FC_median), ]
  jth_FC_median_Signal = jth_Signals[jk_FC_median_index[1],]
  kth_FC_median_Signal = kth_Signals[jk_FC_median_index[2],]

  jk_FC_median_New = cor(jth_FC_median_Signal, kth_FC_median_Signal)
  jk_FC_median_New = 0.5 * log((1 + jk_FC_median_New) / (1 - jk_FC_median_New))
  if(jk_FC_median_New != jk_FC_median){
    stop("the jk FC median is different")
  }


  list(jk_FC_median_New,
       rownames(jth_Signals)[jk_FC_median_index[1]],
       rownames(kth_Signals)[jk_FC_median_index[2]]) %>% setNames(c("FC", Brain_Regions[j], Brain_Regions[k]))
}







