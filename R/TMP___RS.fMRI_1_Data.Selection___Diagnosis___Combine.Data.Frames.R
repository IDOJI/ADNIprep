RS.fMRI_1.3_Diagnosis___Combine.Data.Frames = function(Merged_Lists.df,
                                                       path_Subjects_BLCHANGE,
                                                       path_Subjects_DX_Summary){





  #===============================================================================
  # Combine By RID
  #===============================================================================
  Combined.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Combine.by.RID(Merged_Lists.df, BLCHANGE.list, DXSUM.list, PTDEMO.list, ADNIMERGE.list, CLIELG.list)







  #===============================================================================
  # arrange by exam date
  #===============================================================================
  Rearranged.list = lapply(Combined.list, function(ith_RID.df){
    ith_RID.df %>% arrange(NEW_EXAMDATE)
  })





  #===============================================================================
  # Merging with MT1
  #===============================================================================
  # Merged_with_MT1.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___MT1(Diagnosis_Combined.list = Dicided_Diagnosis.list, MT1.df = Merged_Lists.list[[2]])




  cat("\n", crayon::bgMagenta("STEP 1.3"), crayon::green("Deciding Diagnosis is done!") ,"\n")
  return(Rearranged.list)
}











