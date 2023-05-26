RS.fMRI_4.5_Split.by.Research.Groups = function(New_Combined_Subjects_Info.list){
  ##############################################################################
  # Extracting research groups
  ##############################################################################
  Research_Groups = New_Combined_Subjects_Info.list$Subjects_Information$RESEARCH.GROUP


  ##############################################################################
  # divide research group
  ##############################################################################
  which_is_many = table(Research_Groups) > 200
  unique_Research_Groups = names(table(Research_Groups))
  New_Combined_Subjects_Info.list$Subjects_Information$RESEARCH.GROUP_New = NA
  for(i in 1:length(which_is_many)){
    if(which_is_many[i]){
      div_num = table(Research_Groups)[i] %>%  as.character %>% substr(1,1) %>% as.numeric + 1

      New_ith_group = list()
      for(k in 1:div_num){
        if(k < div_num){
          New_ith_group[[k]] = rep(paste0(unique_Research_Groups[i], "_", k), 100)
        }else{
          New_ith_group[[k]] = rep(paste0(unique_Research_Groups[i], "_", k), table(Research_Groups)[i] - 100*(div_num-1))
        }
      }
      New_ith_group = unlist(New_ith_group)
      New_Combined_Subjects_Info.list$Subjects_Information$RESEARCH.GROUP_New[Research_Groups == unique_Research_Groups[i]] = New_ith_group
    }else{
      New_Combined_Subjects_Info.list$Subjects_Information$RESEARCH.GROUP_New[Research_Groups == unique_Research_Groups[i]] = unique_Research_Groups[i]
    }
  }

  Research_Groups = New_Combined_Subjects_Info.list$Subjects_Information$RESEARCH.GROUP_New
  unique_Research_Groups = New_Combined_Subjects_Info.list$Subjects_Information$RESEARCH.GROUP_New %>% unique

  ##############################################################################
  # Extract each groups' index
  ##############################################################################
  each_index.list = list()
  for(g in 1:length(unique_Research_Groups)){
    each_index.list[[g]] = which(Research_Groups == unique_Research_Groups[g])
  }
  names(each_index.list) = unique_Research_Groups



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
                                   "Pearon_Correlation",
                                   "Pearson_Correlation_UpperTriangle",
                                   "FisherZ_Pearon_Correlation",
                                   "FisherZ_Pearson_Correlation_UpperTriangle")
    return(ith_Group_data.list)
  })
  names(Grouped_data.list) = unique_Research_Groups

  return(Grouped_data.list)
}
