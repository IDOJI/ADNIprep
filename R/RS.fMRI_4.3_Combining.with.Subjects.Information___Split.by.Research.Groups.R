RS.fMRI_4.3_Combining.with.Subjects.Information___Split.by.Research.Groups = function(Combined_by_RID.list){
  ### Extracting research groups
  each_RID_groups = sapply(Combined_by_RID.list, FUN=function(ith_RID){
    ith_RID[[1]]$RESEARCH.GROUP
  })
  groups = unique(each_RID_groups)


  ### Extract each groups' index
  each_index.list = list()
  for(g in 1:length(groups)){
    each_index.list[[g]] = which(each_RID_groups==groups[g])
  }


  ### Extracting Each groups' data
  selected_data.list = list()
  for(g in 1:length(each_index.list)){
    selected_data.list[[g]] = Combined_by_RID.list[each_index.list[[g]]]
  }
  names(selected_data.list) = groups

  return(selected_data.list)
}
