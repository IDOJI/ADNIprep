RS.fMRI_1_Data.Selection___Loading.Lists___Registry = function(Selected_RID, Subjects_Registry, path_Subjects.Lists_Downloaded){
  #=============================================================================
  # Loading data
  #=============================================================================
  Registry.df = read.csv(paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_Registry, ".csv"))



  #=============================================================================
  # names change
  #=============================================================================
  # print_colnames(Registry.df)
  selected_cols = c("ID", "SITEID","USERDATE", "USERDATE2", "PTSTATUS", "RGSTATUS", "VISTYPE", "EXAMDATE", "RGCONDCT", "RGREASON", "RGOTHSPE", "RGSOURCE", "RGRESCRN", "RGPREVID", "CHANGTR", "CGTRACK", "CGTRACK2", "update_stamp")
  cols_index = which(names(Registry.df)  %in% selected_cols)
  names(Registry.df)[cols_index] = paste0("REGISTRY___", selected_cols)
  names(Registry.df) = names(Registry.df) %>% toupper


  #=============================================================================
  # as list
  #=============================================================================
  Registry.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, Registry.df)

  return(Registry.list)
}
