RS.fMRI_1_Data.Selection___Loading.Lists___DXSUM = function(Selected_RID, Subjects_DX_Summary, path_Subjects.Lists_Downloaded){
  #=============================================================================
  # csv?
  #=============================================================================
  path_Subjects_DX_Summary = paste0(path_tail_slash(path_Subjects.Lists_Downloaded), Subjects_DX_Summary)
  if(grep("csv", path_Subjects_DX_Summary) %>% length > 0){
    DXSUM.df = read.csv(path_Subjects_DX_Summary)
  }else{
    DXSUM.df = read.csv(paste0(path_Subjects_DX_Summary, ".csv"))
  }


  #=============================================================================
  # As date
  #=============================================================================
  DXSUM.df$EXAMDATE = DXSUM.df$EXAMDATE %>% as.Date()






  #=============================================================================
  # Intersect RID
  #=============================================================================
  DXSUM_Intersect.df = DXSUM.df %>% filter(RID %in% Selected_RID) %>% arrange(RID, EXAMDATE)





  #=============================================================================
  # Selecting columns
  #=============================================================================
  # RS.fMRI_1.3_Diagnosis___Data.Dictionary("DIAGNOSIS")
  DXSUM_Intersect_Selected.df = DXSUM_Intersect.df %>% select(c("Phase", "RID", "VISCODE", "VISCODE2", "EXAMDATE",
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
  selected_cols = c("EXAMDATE", "DXCHANGE", "DXCURREN", "DXCONV", "DXCONTYP", "DXREV", "DXNORM", "DXMCI", "DXAD", "DXADES", "DXAPP", "DXOTHDEM", "DIAGNOSIS")
  cols_index = which(names(DXSUM_Intersect_Selected.df) %in% selected_cols)
  # print_colnames(DXSUM_Intersect_Selected.df)
  names(DXSUM_Intersect_Selected.df)[cols_index] = paste0("DXSUM___", selected_cols)
  names(DXSUM_Intersect_Selected.df) = DXSUM_Intersect_Selected.df %>% names %>% toupper



  #=============================================================================
  # DXSUM  as list by RID
  #=============================================================================
  DXSUM.list = RS.fMRI_1_Data.Selection___Loading.Lists___SUB___Making.List(Selected_RID, DXSUM_Intersect_Selected.df)

  return(DXSUM.list)
}
