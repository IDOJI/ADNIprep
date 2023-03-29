RS.fMRI_1.2_Merging.Lists = function(Subjects.list, path_ExportRda, what.date){
  #=============================================================================
  # 1. Selecting data by RID & Dates & ImageID
  #=============================================================================
  Intersection.list = RS.fMRI_1.2_Merging.Lists___Intersect.By.RID.and.Dates.and.ImageID(Subjects.list)
  text = "1.2 : Extracting by RID & Dates is done!"
  cat("\n", crayon::green(text), "\n")




  #=============================================================================
  # 2. Merging Search & QC by date having MT1 & EPB
  #=============================================================================
  Merging_Search_and_QC.list = RS.fMRI_1.2_Merging.Lists___Merging.Search.and.QC(Intersection.list, what.date)
  text = "1.2 : Merging Search & QC is done!"
  cat("\n", crayon::green(text), "\n")




  #=============================================================================
  # 3. Merging NFQ
  #=============================================================================
  Merging_NFQ.list = RS.fMRI_1.2_Merging.Lists___Merging.With.NFQ(Merging_Search_and_QC.list)
  text = "1.2 : Merging with NFQ is done!"
  cat("\n", crayon::green(text), "\n")



  #=============================================================================
  # 4. Extracting Slice.Order.Type
  #=============================================================================
  Slice.Order.Type_Extracted.list = RS.fMRI_1.2_Merging.Lists___Slice.Order.Info(Merging_NFQ.list)
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



