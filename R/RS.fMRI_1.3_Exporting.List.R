RS.fMRI_1.3_Exporting.Lists = function(data.list=Merged_Lists.list, path_Subjects, path_Rda){


  ### Export All Subjects Info
  Export_all_subjects.list = RS.fMRI_1.3_Exporting.List___Export.All.Subjects.Info(data.list, path_Subjects, path_Rda)
  text = "1.3 : Exporting All Subjects Info is done."
  cat("\n", crayon::green(text), "\n")


  ### Export Each Manufacturer Info
  Combine_by_manufacturer.list = RS.fMRI_1.3_Exporting.List___Combine.by.Manufacturer(data.list)
  text = "1.3 : Combining by 'Manufacturer' is done."
  cat("\n", crayon::green(text), "\n")


  ### Export info by Manufacturer
  Export_info_by_manufacturer.list = RS.fMRI_1.3_Exporting.List___Export.Each.Manufacturer.Info(Combine_by_manufacturer.list, path_Subjects, path_Rda)
  text = "1.3 : Exporting Subjects' Information by 'Manufacturer' is done."
  cat("\n", crayon::green(text), "\n")


  ### returning results
  text = paste("\n","Step 1.3 is done !","\n")
  cat(crayon::bgMagenta(text))
}










