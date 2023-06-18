RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___DX.Summary = function(Merged_Lists.df, path_Subjects_DX.Summary){
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
  # Intersect RID
  #=============================================================================
  RID_BL = DXSUM.df$RID %>% unique %>% sort
  RID_EPB = Merged_Lists.df$RID %>% sort
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
  # replace elements
  #=============================================================================
  # RS.fMRI_1.3_Diagnosis___Data.Dictionary("BCPREDX")
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DIAGNOSIS", from = c(1,2,3,-4, NA), to = c("CN", "MCI", "Dementia", "NA", "NA"))
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXCHANGE", from = -4, to = NA)
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXCURREN", from = c(1,2,3,-4), to = c("CN", "MCI", "AD", NA))
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXCONV", from = -4, to = NA)
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXCONTYP", from = -4, to = NA)
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXREV", from = -4, to = NA)
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXNORM", from = -4, to = NA)
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXMCI", from = -4, to = NA)
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXAD", from = -4, to = NA)
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXAPP", from = -4, to = NA)
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DXOTHDEM", from = -4, to = NA)
  DXSUM_Intersect_Selected.df = replace_elements(DXSUM_Intersect_Selected.df, col_name = "DIAGNOSIS", from = c(1,2,3, -4, NA), to = c("CN", "MCI", "Dementia", "NA", "NA"))

  cols = c("DIAGNOSIS", "DXCHANGE", "DXCURREN", "DXCONV", "DXCONTYP", "DXREV", "DXNORM", "DXMCI", "DXAD", "DXAPP", "DXOTHDEM", "DIAGNOSIS")
  for(k in seq_along(cols)){
    DXSUM_Intersect_Selected.df[ ,cols[k]][DXSUM_Intersect_Selected.df[ ,cols[k]]=="NA"]=NA
  }

  DXSUM_Intersect_Selected.df$DXCURREN = DXSUM_Intersect_Selected.df$DXCURREN %>% as.character()

  #=============================================================================
  # Replace Names
  #=============================================================================
  names(DXSUM_Intersect_Selected.df) = paste0("DXSUM___", names(DXSUM_Intersect_Selected.df))



  #=============================================================================
  # DXSUM  as list by RID
  #=============================================================================
  DXSUM.list = as_list_by(DXSUM_Intersect_Selected.df, by =  "DXSUM___RID")

  cat("\n", crayon::bgMagenta("Step 1.3 "),crayon::green("Diagnosis subjects selection is done : "), crayon::red("DX Summary"),"\n")

  return(DXSUM.list)
}
