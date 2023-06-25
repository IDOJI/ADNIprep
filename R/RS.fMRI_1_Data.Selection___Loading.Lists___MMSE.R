RS.fMRI_1_Data.Selection___Loading.Lists___MMSE = function(Selected_RID, Subjects_MMSE, path_Subjects.Lists_Downloaded){
  #=============================================================================
  # csv?
  #=============================================================================
  path_Subjects = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_MMSE)
  if(grep("csv", path_Subjects) %>% length > 0){
    Data.df = read.csv(path_Subjects)
  }else{
    Data.df = read.csv(paste0(path_Subjects, ".csv"))
  }


  #=============================================================================
  # As date
  #=============================================================================
  Data.df$USERDATE = Data.df$USERDATE %>% as.Date()





  #=============================================================================
  # Intersect RID
  #=============================================================================
  Data_Intersect.df = Data.df %>% filter(RID %in% Selected_RID) %>% arrange(RID, USERDATE)
  names(Data_Intersect.df) = names(Data_Intersect.df) %>% toupper




  #=============================================================================
  # Select cols
  #=============================================================================
  # print_colnames(Data_Intersect.df)
  selected_cols = c("PHASE", "RID", "VISCODE", "VISCODE2", "USERDATE", "USERDATE2", "EXAMDATE", "MMSCORE")
  Data_Intersect_Selected.df = Data_Intersect.df %>% select(all_of(selected_cols))
  selected_cols_2 = c("USERDATE", "USERDATE2", "EXAMDATE", "MMSCORE")
  Data_Intersect_Selected.df = change_colnames(Data_Intersect_Selected.df, from = selected_cols_2, to = paste0("MMSE___", selected_cols_2))




  #=============================================================================
  # Data  as list by RID
  #=============================================================================
  Data.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, Data_Intersect_Selected.df)


  return(Data.list)




}
