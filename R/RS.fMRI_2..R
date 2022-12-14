RS.fMRI_2. = function(path_ADNI = "D:/ADNI", All.Subjects=F){
  ##############################################################################
  # 0. Creating path
  ##############################################################################
  path_ADNI                =   path_ADNI                                     %>% path_tail_slash()
  path_Subjects            =   paste(path_ADNI,     "ADNI_Subjects", sep="") %>% path_tail_slash()
  path_Subjects_RS.fMRI    =   paste(path_ADNI,     "ADNI_RS.fMRI",  sep="") %>% path_tail_slash()
  path_Subjects_Downloaded =   paste(path_Subjects, "Downloaded",    sep="") %>% path_tail_slash()




  ##############################################################################
  # 1. Checking missing files
  ##############################################################################
  RS.fMRI_2.1_Check.Missing.On.Unzipped.Files(path_Subjects_RS.fMRI, path_Subjects)
  text1 = crayon::blue("2.1 : ")
  text2 = crayon::red("Checking Missing Files on Unzipped Folders")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")




  ##############################################################################
  # 2. Moving Slice Order file
  ##############################################################################
  RS.fMRI_2.2_Moving.Slice.Order.Info(path_Subjects, path_Subjects_RS.fMRI, All.Subjects)
  text1 = crayon::blue("2.2 : ")
  text2 = crayon::red("Moving Slice Order files")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")




  ##############################################################################
  # 3. Creating Folder for DPABI
  ##############################################################################
  Path_of_Created_Folders.list = RS.fMRI_2.3_Creating.Folders.for.DPABI(path_Subjects, path_Subjects_RS.fMRI, All.Subjects) %>% suppressWarnings()
  text1 = crayon::blue("2.3 : ")
  text2 = crayon::red("Creating 'Sub' Folders")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")



  ##############################################################################
  # 4. Extracting files Path for each ID
  ##############################################################################
  Extracted_ImageID_Folders_Path.list = RS.fMRI_2.4_Extracting.ImageID.Folders.Path.for.Each.Manufacturer(path_Subjects, path_Subjects_RS.fMRI)
  text1 = crayon::blue("2.4 : ")
  text2 = crayon::red("Extarcting ImageID folders Path for each ID")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")



  ##############################################################################
  # 5. Moving DCM Files
  ##############################################################################
  RS.fMRI_2.5_Moving.DCM.Files(path_Subjects_RS.fMRI, Path_of_Created_Folders.list, Extracted_ImageID_Folders_Path.list)
  text1 = crayon::blue("2.5 : ")
  text2 = crayon::red("Creating Folders")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")


  ##############################################################################
  # 5. final
  ##############################################################################
  text1 = crayon::bgMagenta("STEP 2")
  text2 = crayon::red("Moving DCM files")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")
}
