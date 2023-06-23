RS.fMRI_1.1_Load.Subjects.As.List___Search.List___Extract.Arrange.RID = function(data.list){
  # data.list = Search_1.list

  #=============================================================================
  # Extract RID
  #=============================================================================
  RID_combined = c()
  data_New.list = lapply(data.list, function(data.df, ...){
    RID =  sapply(data.df$SUBJECT.ID, FUN=function(jth_ID){
      strsplit(jth_ID, split = "_")[[1]][3] %>% as.numeric
    })
    RID_combined <<- c(RID_combined, RID) %>% unique
    RID_data.df = cbind(RID = RID, data.df) %>% as_tibble %>% arrange(RID)
    return(RID_data.df)
  })

  data_New_2.list = lapply(data_New.list, function(y, ...){
    y %>% filter(RID %in% RID_combined)
  })




  return(data_New_2.list)
}
