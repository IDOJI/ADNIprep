RS.fMRI_1.3_Exporting.Lists = function(data.list,
                                       path_Subjects.Lists.Downloaded,
                                       path_Subjects.Lists.Exported,
                                       path_Export_Rda){
  # data.list = Merged_Lists.list
  #=============================================================================
  # Path
  #=============================================================================
  path_Subjects.Lists.Downloaded = path_Subjects.Lists.Downloaded %>% path_tail_slash()
  path_Subjects.Lists.Exported = path_Subjects.Lists.Exported %>% path_tail_slash()



  #=============================================================================
  # Export All Subjects Info
  #=============================================================================
  Export_all_subjects.list = RS.fMRI_1.3_Exporting.Lists___Export.All.Subjects.Info(data.list, path_Subjects.Lists.Exported, path_Export_Rda)
  text = "1.3 : Exporting All Subjects Info is done."
  cat("\n", crayon::green(text), "\n")



  #=============================================================================
  # Split by Manufacturer
  #=============================================================================
  Combine_by_manufacturer.list = RS.fMRI_1.3_Exporting.Lists___Combine.by.Manufacturer(Export_all_subjects.list)
  text = "1.3 : Combining by 'Manufacturer' is done."
  cat("\n", crayon::green(text), "\n")




  #=============================================================================
  # Export info by Manufacturer
  #=============================================================================
  Export_info_by_manufacturer.list = RS.fMRI_1.3_Exporting.Lists___Export.Each.Manufacturer.Info(Combine_by_manufacturer.list,
                                                                                                 path_Subjects.Lists.Exported)
  text = "1.3 : Exporting Subjects' Information by 'Manufacturer' is done."
  cat("\n", crayon::green(text), "\n")


  ### returning results
  text = paste("\n","Step 1.3 is done !","\n")
  cat(crayon::bgMagenta(text))
}











