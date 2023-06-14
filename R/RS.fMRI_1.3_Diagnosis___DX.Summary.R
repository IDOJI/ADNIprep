RS.fMRI_1.3_Diagnosis___DX.Summary = function(Merged_Lists.list, path_Subjects_DX.Summary){
  #=============================================================================
  # csv?
  #=============================================================================
  if(grep("csv", path_Subjects_DX.Summary) %>% length > 0){
    DXSUM.df = read.csv(path_Subjects_DX.Summary)
  }else{
    DXSUM.df = read.csv(paste0(path_Subjects_DX.Summary, ".csv"))
  }


  #=============================================================================
  # As date
  #=============================================================================
  DXSUM.df$EXAMDATE = DXSUM.df$EXAMDATE %>% as.Date()





  #=============================================================================
  # EPB, MT1
  #=============================================================================
  EPB.df = Merged_Lists.list[[1]]
  MT1.df = Merged_Lists.list[[2]]




  #=============================================================================
  # Intersect RID
  #=============================================================================
  RID_BL = DXSUM.df$RID %>% unique %>% sort
  RID_EPB = EPB.df$RID %>% sort
  RID_Intersect = intersect(RID_BL, RID_EPB) %>% sort


  DXSUM_Intersect.df = DXSUM.df %>% filter(RID %in% RID_Intersect) %>% arrange(RID, EXAMDATE)





  #=============================================================================
  # Selecting columns
  #=============================================================================
  # RS.fMRI_1.3_Diagnosis___Data.Dictionary("DIAGNOSIS")
  DXSUM_Intersect_Selected.df = DXSUM_Intersect.df %>% select(c("RID", "VISCODE", "VISCODE2", "EXAMDATE",
                                                                "DXCHANGE", "DXCURREN", "DXCONV", "DXCONTYP", "DXREV",
                                                                "DXNORM", "DXMCI", "DXAD","DXADES", "DXAPP", "DXOTHDEM", "DIAGNOSIS"))




  #=============================================================================
  # Change Description
  #=============================================================================
  # RS.fMRI_1.3_Diagnosis___Data.Dictionary("BCPREDX")
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DIAGNOSIS", from = c(1,2,3,-4, NA), to = c("CN", "MCI", "Dementia", "NA", "NA"))





  #=============================================================================
  # Replace Names
  #=============================================================================
  names(DXSUM_Intersect_Selected.df) = paste0("DXSUM___", names(DXSUM_Intersect_Selected.df))



  #=============================================================================
  # DXSUM  as list by RID
  #=============================================================================
  DXSUM.list = as_list_by(DXSUM_Intersect_Selected.df, by =  "DXSUM___RID")


  return(DXSUM.list)
}
