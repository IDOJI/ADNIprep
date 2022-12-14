RS.fMRI_1.2_Merging.Lists = function(Subjects.list, path_Rda, what.date){
  #=============================================================================
  # 1. Selecting data by RID and Dates
  #=============================================================================
  Intersect_by_RID.list = RS.fMRI_1.2_Merging.Lists___Intersect.By.RID(Subjects.list)
  text = "1.2 : Extracting by RID & Dates is done!"
  cat("\n", crayon::green(text), "\n")



  #=============================================================================
  # 2. Merging by dates having both EPB & MT1 by what.date
  #=============================================================================
  Merged_by_dates.list = RS.fMRI_1.2_Merging.Lists___Merging.By.Date(Intersect_by_RID.list, what.date)
  text = "1.2 : Merging by dates is done!"
  cat("\n", crayon::green(text), "\n")



  #=============================================================================
  # 3. combining by series type
  #=============================================================================
  Combined_by_SeriesType.list = RS.fMRI_1.2_Merging.Lists___Combining.By.Series.Type(Merged_by_dates.list)
  text = "1.2 : Combining by Series.Type is done!"
  cat("\n", crayon::green(text), "\n")


  #=============================================================================
  # 4. Extracting Slice.Order.Type
  #=============================================================================
  Slice.Order.Type_Extracted.list = RS.fMRI_1.2_Merging.Lists___Slice.Order.Info(Combined_by_SeriesType.list)
  text = "1.2 : Extracting Slice.Order.Type by Series.Type is done!"
  cat("\n", crayon::green(text), "\n")




  #=============================================================================
  # 5. saving data
  #=============================================================================
  # if(!is.null(path_Rda)){
  #   saving_data("RS.fMRI_EPB_selected_subjects", Slice.Order.Type_Extracted.list[[1]], path_Rda)
  #   saving_data("RS.fMRI_MT1_selected_subjects", Slice.Order.Type_Extracted.list[[2]], path_Rda)
  #   text = "1.2 : Extracting Slice.Order.Type by Series.Type is done!"
  #   cat("\n", crayon::green(text), "\n")
  # }



  #=============================================================================
  # 6.Returning results
  #=============================================================================
  text = "1.2 : Merging.Lists is done!"
  cat("\n", crayon::bgMagenta(text), "\n")
  return(Slice.Order.Type_Extracted.list)
}



