RS.fMRI_1.4_Adding.Numbering.By.Manufacturers = function(Merged_Diagnosis.list){
  #=============================================================================
  # Data
  #=============================================================================
  Merged_Diagnosis_New.list = Merged_Diagnosis.list
  Merged.df = Merged_Diagnosis.list[[1]]



  #=============================================================================
  # Arranging by Manufacturer and RID
  #=============================================================================
  Merged.df$RID = Merged.df$RID %>% as.numeric
  Merged.df = Merged.df %>% arrange(Manufacturer_New, RID)



  #=============================================================================
  # 3.Adding Numbering A Col by Manufacturers
  #=============================================================================
  Manu = Merged.df$Manufacturer_New %>% unique

  New_Merged.list = lapply(Manu, FUN=function(ith_Manu, ...){
    ith_Merged.df = Merged.df %>% filter(Manufacturer_New == ith_Manu)
    ith_Sub_Num = paste0("Sub_", fit_length(1:nrow(ith_Merged.df), 3))
    ith_MT1_ID = ith_Merged.df$MT1___IMAGE_ID
    ith_EPI_ID = ith_Merged.df$EPI___IMAGE_ID

    File_Names = paste0(ith_Merged.df$Manufacturer_New, "___", ith_Sub_Num, "___", "RID_", fit_length(ith_Merged.df$RID, 4), "___", "EPI_", ith_EPI_ID, "___", "MT1", "_", ith_MT1_ID)
    cbind(File_Names, ith_Merged.df) %>% as_tibble() %>% return()
  })
  Merged_Diagnosis_New.list[[1]] = New_Merged.df = do.call(rbind, New_Merged.list)


  cat("\n", crayon::bgMagenta("STEP 1.4"), crayon::green("Adding Numbering and Filenames is done!"), "\n")
  return(Merged_Diagnosis_New.list)
}

