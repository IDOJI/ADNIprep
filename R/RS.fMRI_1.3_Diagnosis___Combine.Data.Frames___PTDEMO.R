RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___PTDEMO = function(Merged_Lists.df, path_Subjects_PTDEMO){
  #=============================================================================
  # csv?
  #=============================================================================
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
  RID_BL = Data.df$RID %>% unique %>% sort
  RID_EPB = Merged_Lists.df$RID %>% sort
  RID_Intersect = intersect(RID_BL, RID_EPB) %>% sort


  Data_Intersect.df = Data.df %>% filter(RID %in% RID_Intersect) %>% arrange(RID, USERDATE)
  Data_Intersect_Selected.df = Data_Intersect.df




  #=============================================================================
  # Selecting columns
  #=============================================================================




  #=============================================================================
  # Replace Names
  #=============================================================================
  names(Data_Intersect_Selected.df) = paste0("PTDEMO___", names(Data_Intersect_Selected.df))



  #=============================================================================
  # Data  as list by RID
  #=============================================================================
  Data.list = as_list_by(Data_Intersect_Selected.df, by =  "PTDEMO___RID")

  cat("\n", crayon::bgMagenta("Step 1.3 "),crayon::green("Diagnosis subjects selection is done : "), crayon::red("PTDEMO"),"\n")

  return(Data.list)
}
