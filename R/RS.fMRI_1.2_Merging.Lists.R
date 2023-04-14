RS.fMRI_1.2_Merging.Lists = function(Subjects.list){
  #=============================================================================
  # 1. QC & NFQ
  #=============================================================================
  Merged_QC_NFQ.list = RS.fMRI_1.2_Merging.Lists___QC.and.NFQ(Subjects.list)
  text = "1.2 : Merging QC & NFQ is done!"
  cat("\n", crayon::green(text), "\n")





  #=============================================================================
  # 2. Merging Search & QC by date having MT1 & EPB
  #=============================================================================
  Merging_Search.list = RS.fMRI_1.2_Merging.Lists___Search(Merged_QC_NFQ.list)
  text = "1.2 : Merging Search & QC is done!"
  cat("\n", crayon::green(text), "\n")




  #=============================================================================
  # 3. Protocol Split
  #=============================================================================
  Protocol_Splitted.list = RS.fMRI_1.2_Merging.Lists___Protocol.Split(Merging_Search.list)
  length(Merging_Search.list)
  cat("\n", crayon::green("1.2 : Splitting protocol is done."), "\n")






  #=============================================================================
  # 4. Adding cols : Slice.Order.Type, Band Type
  #=============================================================================
  Adding_cols.list = RS.fMRI_1.2_Merging.Lists___Adding.Cols(Merging_Search_and_QC.list)
  text = "1.2 : Adding cols is done!"
  cat("\n", crayon::green(text), "\n")




  #=====================================================================================
  # Move cols
  #=====================================================================================
  combined_EPB.df$T1_ACCELERATED = NULL
  New_combined_EPB.df = combined_EPB.df %>% relocate(ends_with("DESCRIPTION"), .after = last_col())
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("FMRI_"), .after = last_col())
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("QC_"), .after = last_col())
  New_combined_EPB.df = New_combined_EPB.df %>% relocate(starts_with("IMAGE"))
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___MEAN_SNR = FMRI_MEAN_SNR)
  New_combined_EPB.df = New_combined_EPB.df %>% rename(FMRI___PHASE_DIRECTION = FMRI_PHASE_DIRECTION)


  combined_MT1.df$FMRI_MEAN_SNR = NULL
  combined_MT1.df$FMRI_PHASE_DIRECTION = NULL
  New_combined_MT1.df = combined_MT1.df %>% relocate(ends_with("DESCRIPTION"), .after = last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("MRI_"), .after = last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("QC_"), .after = last_col())
  New_combined_MT1.df = New_combined_MT1.df %>% relocate(starts_with("IMAGE"))

  New_Subjects.list = list(EPB = New_combined_EPB.df, MT1 = New_combined_MT1.df)



  #=============================================================================
  # 5.Returning results
  #=============================================================================
  final.list = Adding_cols.list
  text = "1.2 : Merging.Lists is done!"
  cat("\n", crayon::bgMagenta(text), "\n")
  return(final.list)
}


#
# #=============================================================================
# # 1. Selecting data by RID & Dates & ImageID
# #=============================================================================
# Intersection.list = RS.fMRI_1.2_Merging.Lists___Intersect.By.RID.and.Dates.and.ImageID(Subjects.list)
# text = "1.2 : Extracting by RID & Dates is done!"
# cat("\n", crayon::green(text), "\n")

