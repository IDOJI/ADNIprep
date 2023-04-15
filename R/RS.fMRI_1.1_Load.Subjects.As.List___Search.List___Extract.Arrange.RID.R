RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Extract.Arrange.RID = function(data.df){
  # data.df = Search_1.df

  #=============================================================================
  # Extract RID
  #=============================================================================
  RID =  sapply(data.df$SUBJECT.ID, FUN=function(jth_ID){
    strsplit(jth_ID, split = "_")[[1]][3] %>% as.numeric
  })
  RID_data.df = cbind(RID = RID, data.df) %>% as_tibble %>% arrange(RID)


  return(RID_data.df)
}
