RS.fMRI_1_Data.Selection___Exporting.Lists = function(data.list,
                                       path_Export_Subjects.Lists){
  # data.list = Final.list
  #=============================================================================
  # Path
  #=============================================================================
  path_Export_Subjects.Lists = path_Export_Subjects.Lists %>% path_tail_slash()
  ### Creating directory =======================================================
  dir.create(path_Export_Subjects.Lists, showWarnings = F)



  #=============================================================================
  # Export All Subjects Info
  #=============================================================================
  ## Image ID ==================================================================
  All_ImageID = c(data.list[[1]]$MT1___IMAGE_ID, data.list[[1]]$EPI___IMAGE_ID)
  RS.fMRI_1_Data.Selection___Exporting.Lists___SUB_Exporting.Image.ID(All_ImageID, filename = paste0("[Final_Selected]_ImageID"), path_Export_Subjects.Lists)



  ### csv file ==========================================================================
  # Selected
  RS.fMRI_1_Data.Selection___Exporting.Lists___SUB_Exporting.Subjects.List.CSV(data.list[[1]], path_Export_Subjects.Lists, paste0("[Final_Selected]_Subjects_list"))
  # Full
  RS.fMRI_1_Data.Selection___Exporting.Lists___SUB_Exporting.Subjects.List.CSV(data.list[[2]], path_Export_Subjects.Lists, paste0("[Final_Selected]_Subjects_list_(Full_History)"))

  text = "Exporting All Subjects Info is done."
  cat("\n", crayon::green(text), "\n")


  ### returning results
  text = paste("\n","Step 1.7 is done !","\n")
  cat(crayon::bgMagenta(text))
  return(data.list)
}













# Export_all_subjects.list = RS.fMRI_1.5_Exporting.Lists___Export.All.Subjects.Info(data.list, path_Subjects.Lists.Exported, path_Export_Rda)






#=============================================================================
# Split by Manufacturer
#=============================================================================
# Combine_by_manufacturer.list = RS.fMRI_1.5_Exporting.Lists___Combine.by.Manufacturer(Export_all_subjects.list)
# text = "1.3 : Combining by 'Manufacturer' is done."
# cat("\n", crayon::green(text), "\n")




#=============================================================================
# Export info by Manufacturer
#=============================================================================
# Export_info_by_manufacturer.list = RS.fMRI_1.5_Exporting.Lists___Export.Each.Manufacturer.Info(Combine_by_manufacturer.list,
#                                                                                                path_Subjects.Lists.Exported)
# text = "1.3 : Exporting Subjects' Information by 'Manufacturer' is done."
# cat("\n", crayon::green(text), "\n")










# # Exporting list
# #===============================================================================
# write.csv(Binded.list[[1]], file = paste0(path_Export, "/Selected_Subjects_List.csv"), row.names = F)
# write.csv(Binded.list[[2]], file = paste0(path_Export, "/Full_Subjects_List.csv"), row.names = F)
# cat("\n", crayon::green("Exporting subjects lists is done!") ,"\n")
