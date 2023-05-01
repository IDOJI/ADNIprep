RS.fMRI_2.7_Check.and.Rename.Sub.Numbering = function(path_ADNI.Unzipped.Folders){
  #===========================================================================================
  # path & folders
  #===========================================================================================
  Unzipped.Folders = list.files(path_ADNI.Unzipped.Folders)
  path_Unzipped.Folders = list.files(path_ADNI.Unzipped.Folders, full.names = T)



  #===========================================================================================
  # Renaming by Sub_xxx folders
  #===========================================================================================
  RS.fMRI_2.7_Check.and.Rename.Sub.Numbering___Change.Sub.Num(path_Unzipped.Folders, only_folders = T)



  #===========================================================================================
  # Renaming Sub_xxx numbering for each files
  #===========================================================================================
  RS.fMRI_2.7_Check.and.Rename.Sub.Numbering___Change.Sub.Num(path_Unzipped.Folders[-c(1:153)], only_folders = F, pattern_exclude = "\\.dcm$")



  cat("\n", crayon::red("Step 2.7"), crayon::blue("Check and rename Sub numbering"), "\n")
}
