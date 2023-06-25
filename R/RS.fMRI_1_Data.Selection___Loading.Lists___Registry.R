RS.fMRI_1_Data.Selection___Loading.Lists___Registry = function(Selected_RID, Subjects_Registry, path_Subjects.Lists_Downloaded){
  #=============================================================================
  # Loading data
  #=============================================================================
  Registry.df = read.csv(paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_Registry, ".csv"))



  #=============================================================================
  # names change
  #=============================================================================
  names(Registry.df) = paste0("REGISTRY___", names(Registry.df) %>% toupper)


  #=============================================================================
  # as list
  #=============================================================================
  Registry.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, Registry.df)

  return(Registry.list)
}
