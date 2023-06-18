RS.fMRI_1.3_Diagnosis___Combine.Data.Frames = function(Merged_Lists.df,
                                                       path_Subjects_BLCHANGE,
                                                       path_Subjects_DX.Summary){
  #===============================================================================
  # Base Line (BL) Change
  #===============================================================================
  BLCHANGE.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___BLCHANGE(Merged_Lists.df, path_Subjects_BLCHANGE)




  #===============================================================================
  # DX Summary
  #===============================================================================
  DXSUM.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___DX.Summary(Merged_Lists.df, path_Subjects_DX.Summary)



  #===============================================================================
  # Demographics
  #===============================================================================
  PTDEMO.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___PTDEMO(Merged_Lists.df, path_Subjects_PTDEMO)




  #===============================================================================
  # ADNIMERGE 패키지 : ADNIMERGE
  #===============================================================================
  ADNIMERGE.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___ADNIMERGE.Package___ADNIMERGE(Merged_Lists.list)




  #===============================================================================
  # ADNIMERGE 패키지 : CLIELG
  #===============================================================================
  CLIELG.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___ADNIMERGE.Package___CLIELG(Merged_Lists.list)





  #===============================================================================
  # ADNIMERGE 패키지 : PTDEMOG
  #===============================================================================
  # PTDEMOG.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___ADNIMERGE.Package___PTDEMOG(Merged_Lists.list)






  #===============================================================================
  # Combine By RID
  #===============================================================================
  Decided_Diagnosis.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___Combine.by.RID(Merged_Lists.df, BLCHANGE.list, DXSUM.list, PTDEMO.list, ADNIMERGE.list, CLIELG.list)







  #===============================================================================
  # arrange by exam date
  #===============================================================================
  Rearranged.list = lapply(Decided_Diagnosis.list, function(ith_RID.df){
    ith_RID.df %>% arrange(NEW_EXAMDATE)
  })





  #===============================================================================
  # Merging with MT1
  #===============================================================================
  # Merged_with_MT1.list = RS.fMRI_1.3_Diagnosis___Combine.Data.Frames___MT1(Diagnosis_Combined.list = Dicided_Diagnosis.list, MT1.df = Merged_Lists.list[[2]])




  cat("\n", crayon::bgMagenta("STEP 1.3"), crayon::green("Deciding Diagnosis is done!") ,"\n")
  return(Rearranged.list)
}











