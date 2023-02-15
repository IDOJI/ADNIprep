RS.fMRI_4.6_Exclude.Subjects.With.Not.Defined.ROIs = function(Split_by_Research_Groups.list){
  ############################################################################
  ### finding max ROI number
  ############################################################################
  defined_ROIs.list = list()
  for(g in 1:length(Split_by_Research_Groups.list)){
    defined_ROIs.list[[g]] = lapply(Split_by_Research_Groups.list[[g]]$Pearson_Correlation_UpperTriangle, FUN=function(gth_Corr, ...){
      # gth_Corr = Split_by_Research_Groups.list[[g]]$Pearson_Correlation_UpperTriangle[[1]]
      ncol(gth_Corr)
    })
  }
  max_ROIs = defined_ROIs.list %>% unlist %>% unlist %>% table %>% which.max %>% names %>% as.numeric


  ############################################################################
  ### index
  ############################################################################
  selected.list = list()
  for(g in 1:length(defined_ROIs.list)){
    gth_num.col = defined_ROIs.list[[g]] %>% unlist
    selected.list[[g]] = list(Split_by_Research_Groups.list[[g]]$Subjects_information[gth_num.col == max_ROIs, ],
                              Split_by_Research_Groups.list[[g]]$ROI_Signals[gth_num.col == max_ROIs],
                              Split_by_Research_Groups.list[[g]]$Pearon_Correlation[gth_num.col == max_ROIs],
                              Split_by_Research_Groups.list[[g]]$Pearson_Correlation_UpperTriangle[gth_num.col == max_ROIs],
                              Split_by_Research_Groups.list[[g]]$FisherZ_Pearon_Correlation[gth_num.col == max_ROIs],
                              Split_by_Research_Groups.list[[g]]$FisherZ_Pearson_Correlation_UpperTriangle[gth_num.col == max_ROIs])
    names(selected.list[[g]]) = names(Split_by_Research_Groups.list[[g]])
  }
  names(selected.list) = names(Split_by_Research_Groups.list)

  return(selected.list)
}
