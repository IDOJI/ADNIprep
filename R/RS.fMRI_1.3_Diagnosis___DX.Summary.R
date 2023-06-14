RS.fMRI_1.3_Diagnosis___DX.Summary = function(Subjects_List_BLCHANGE.list, path_Subjects_DX.Summary){
  #=============================================================================
  # Load
  #=============================================================================
  if(grep("csv", path_Subjects_DX.Summary) %>% length > 1){
    DX.df = read.csv(path_Subjects_DX.Summary)
  }else{
    DX.df = read.csv(paste0(path_Subjects_DX.Summary, ".csv"))
  }
  DX.df$EXAMDATE = DX.df$EXAMDATE %>% as.Date


  #=============================================================================
  # EPB, MT1
  #=============================================================================
  EPB_BLCHANGE.list = Subjects_List_BLCHANGE.list[[1]]
  MT1.df = Subjects_List_BLCHANGE.list[[2]]




  #=============================================================================
  # Extract nearest
  #=============================================================================
  Combined.list = lapply(EPB_BLCHANGE.list, function(y, ...){
    ith_RID = y[[1]]$RID
    ith_Study.Date = y[[1]]$STUDY.DATE %>% as.Date

    ith_DX = DX.df %>% filter(RID==ith_RID)

    if(nrow(ith_DX)>0){
      ith_DX_Date = ith_DX$EXAMDATE
      minium_index = difftime(ith_DX_Date, ith_Study.Date, units = "days") %>% abs %>% which.min
      ith_DX_Min.Date = ith_DX %>% filter(EXAMDATE == ith_DX_Date[minium_index])

      ith_List = c(y, list(ith_DX_Min.Date), list(ith_DX))
    }else{
      ith_List = c(y, list(NA), list(NA))
    }

    names(ith_List)[4:5] = paste0("RID_", ith_RID, "___",c("Nearest_DX", "DX"))
    return(ith_List)
  })




  return(list(EPB_combined = Combined.list, MT1 = MT1.df))
}
