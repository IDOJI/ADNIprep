RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Extract.Arrange.RID = function(data.df, Exclude_RID = NULL){
  # data.df = Search_1.df

  #=============================================================================
  # Extract RID
  #=============================================================================
  RID =  sapply(Search_1.df$SUBJECT.ID, FUN=function(jth_ID){
    strsplit(jth_ID, split = "_")[[1]][3] %>% as.numeric
  })
  RID_data.df = cbind(RID = RID, data.df) %>% as_tibble %>% arrange(RID)



  #=============================================================================
  # Exclude RID
  #=============================================================================
  Exclude_RID = Exclude_RID %>% as.numeric
  RID_data.df = RID_data.df %>% filter(!RID %in% Exclude_RID)


  return(RID_data.df)
}
