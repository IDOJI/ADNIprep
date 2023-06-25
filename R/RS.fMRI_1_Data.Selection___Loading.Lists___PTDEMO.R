RS.fMRI_1_Data.Selection___Loading.Lists___PTDEMO = function(Selected_RID, Subjects_PTDEMO, path_Subjects.Lists_Downloaded){
  #=============================================================================
  # csv?
  #=============================================================================
  path_Subjects_PTDEMO = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_PTDEMO)
  if(grep("csv", path_Subjects_PTDEMO) %>% length > 0){
    Data.df = read.csv(path_Subjects_PTDEMO)
  }else{
    Data.df = read.csv(paste0(path_Subjects_PTDEMO, ".csv"))
  }


  #=============================================================================
  # As date
  #=============================================================================
  Data.df$USERDATE = Data.df$USERDATE %>% as.Date()





  #=============================================================================
  # Intersect RID
  #=============================================================================
  Data_Intersect.df = Data.df %>% filter(RID %in% Selected_RID) %>% arrange(RID, USERDATE)
  Data_Intersect_Selected.df = Data_Intersect.df




  #=============================================================================
  # Selecting columns
  #=============================================================================




  #=============================================================================
  # Replace Names
  #=============================================================================
  # print_colnames(Data_Intersect_Selected.df)
  names(Data_Intersect_Selected.df) = names(Data_Intersect_Selected.df) %>% toupper
  selected_cols = c("ID", "SITEID","USERDATE", "USERDATE2", "PTSOURCE", "PTGENDER", "PTDOBMM", "PTDOBYY", "PTHAND", "PTMARRY", "PTEDUCAT", "PTWORKHS", "PTWORK", "PTWRECNT", "PTNOTRT", "PTRTYR", "PTHOME", "PTOTHOME", "PTTLANG", "PTPLANG", "PTPSPEC", "PTCOGBEG", "PTMCIBEG", "PTADBEG", "PTADDX", "PTETHCAT", "PTRACCAT", "UPDATE_STAMP")
  cols_index = which(names(Data_Intersect_Selected.df)%in% selected_cols )
  names(Data_Intersect_Selected.df)[cols_index] = paste0("PTDEMO___", selected_cols)
  #names(Data_Intersect_Selected.df) = paste0("PTDEMO___", names(Data_Intersect_Selected.df))



  #=============================================================================
  # Data  as list by RID
  #=============================================================================
  Data.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID,Data.df = Data_Intersect_Selected.df)


  return(Data.list)
}
