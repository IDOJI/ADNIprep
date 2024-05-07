RS.fMRI_1_Data.Selection___Loading.Lists___ADAS = function(Selected_RID, Subjects_ADAS, path_Subjects.Lists_Downloaded){
  #=============================================================================
  # csv?
  #=============================================================================
  path_Subjects_ADAS = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_ADAS)
  if(grep("csv", path_Subjects_ADAS) %>% length > 0){
    Data.df = read.csv(path_Subjects_ADAS)
  }else{
    Data.df = read.csv(paste0(path_Subjects_ADAS, ".csv"))
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
  # Select cols
  #=============================================================================
  selected_cols = c("Phase", "RID", "VISCODE", "VISCODE2", "USERDATE", "USERDATE2", "TOTSCORE","TOTAL13")
  Data_Intersect_Selected.df = Data_Intersect_Selected.df %>% select(all_of(selected_cols))
  names(Data_Intersect_Selected.df) = names(Data_Intersect_Selected.df) %>% toupper
  selected_cols_2 = c("USERDATE", "USERDATE2", "TOTSCORE","TOTAL13")
  Data_Intersect_Selected.df = change_colnames(Data_Intersect_Selected.df, from = selected_cols_2, to = paste0("ADAS___", selected_cols_2))




  #=============================================================================
  # Data  as list by RID
  #=============================================================================
  Data.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, Data_Intersect_Selected.df)
  return(Data.list)
}





























