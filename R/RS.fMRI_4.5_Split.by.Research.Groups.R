RS.fMRI_4.5_Split.by.Research.Groups = function(New_Combined_Subjects_Info.list, path_save, atlas){
  ##############################################################################
  # Extracting research groups
  ##############################################################################
  Research_Groups = New_Combined_Subjects_Info.list[[1]]$RESEARCH.GROUP
  unique_Research_Groups = unique(Research_Groups)



  ##############################################################################
  # Extract each groups' index
  ##############################################################################
  each_index.list = list()
  for(g in 1:length(unique_Research_Groups)){
    each_index.list[[g]] = which(Research_Groups == unique_Research_Groups[g])
  }



  ##############################################################################
  # Extracting Each groups' data
  ##############################################################################
  Grouped_data.list = lapply(each_index.list, FUN=function(ith_index, ...){
    # ith_index = each_index.list[[1]]
    ith_Group_data.list = list(New_Combined_Subjects_Info.list[[1]][ith_index,],
                               New_Combined_Subjects_Info.list[[2]][ith_index],
                               New_Combined_Subjects_Info.list[[3]][[1]][ith_index],
                               New_Combined_Subjects_Info.list[[3]][[2]][ith_index],
                               New_Combined_Subjects_Info.list[[4]][[1]][ith_index],
                               New_Combined_Subjects_Info.list[[4]][[2]][ith_index])
    names(ith_Group_data.list) = c("Subjects_information",
                                   "ROI_Signals",
                                   "Pearon_Correlation", "Pearson_Correlation_UpperTriangle",
                                   "FisherZ_Pearon_Correlation", "FisherZ_Pearson_Correlation_UpperTriangle")
    return(ith_Group_data.list)
  })
  names(Grouped_data.list) = unique_Research_Groups


  return(Grouped_data.list)
}
