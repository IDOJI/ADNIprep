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
  test = read.csv("D:/ADNI/ADNI_Subjects/2.SIEMENS_SB/[Final_Selected]_Subjects_list_EPB_(SIEMENS_SB).csv")
  grep("phase",test$SERIES_DESCRIPTION)








  ##############################################################################
  # 5. final
  ##############################################################################
  text1 = crayon::bgMagenta("STEP 2")
  text2 = crayon::red("Moving DCM files")
  text3 = crayon::blue("is done!")
  cat("\n", text1, text2, text3,"\n")
}





