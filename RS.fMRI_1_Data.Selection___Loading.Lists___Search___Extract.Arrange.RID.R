RS.fMRI_1_Data.Selection___Loading.Lists___Search___Extract.Arrange.RID = function(data.df, Selected_RID){
  # data.list = Search_1.list

  #=============================================================================
  # Extract RID
  #=============================================================================
  RID =  sapply(data.df$SUBJECT.ID, FUN=function(jth_ID){
    strsplit(jth_ID, split = "_")[[1]][3] %>% as.numeric
  })
  RID_data.df = cbind(RID = RID, data.df) %>% as_tibble %>% arrange(RID) %>% filter(RID %in% Selected_RID)



  return(RID_data.df)

}
