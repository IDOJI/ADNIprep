###############################################################################
# Step 01 : Selecting subjects from subjects list files
###############################################################################
# list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/ADNIprep/R", full.names = T) %>% walk(source)
# list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/refineR/R", full.names = T) %>% walk(source)
RS.fMRI_1. = function(path_ADNI            = "D:/ADNI/",
                      path_Rda             =  "C:/Users/IDO/Dropbox/Github/Rpkgs/ADNIprep/data",
                      subjects_search_fMRI = "idaSearch_12_02_2022_fMRI",
                      subjects_search_MRI  = "idaSearch_12_02_2022_MRI",
                      subjects_QC_ADNI2GO  = "MAYOADIRL_MRI_IMAGEQC_12_08_15",
                      subjects_QC_ADNI3    = "MAYOADIRL_MRI_QUALITY_ADNI3",
                      subjects_NFQ         = "MAYOADIRL_MRI_FMRI_11_01_22",
                      what.date            = 1,
                      Have_Previous_Study  = F){
  #============================================================================
  # Path
  #============================================================================
  path_ADNI                =   path_ADNI %>% path_tail_slash()
  path_Subjects            =   paste(path_ADNI, "ADNI_Subjects", sep="") %>% path_tail_slash()
  path_Subjects_Downloaded =   paste(path_Subjects, "Downloaded", sep="") %>% path_tail_slash()


  #============================================================================
  # 1.Loading Subjects
  #============================================================================
  Subjects.list = RS.fMRI_1.1_Load.Subjects.As.List(path_Subjects,
                                                    path_Subjects_Downloaded,
                                                    path_Rda,
                                                    subjects_search_fMRI,
                                                    subjects_search_MRI,
                                                    subjects_QC_ADNI2GO,
                                                    subjects_QC_ADNI3,
                                                    subjects_NFQ,
                                                    Have_Previous_Study)


  #============================================================================
  # 2. Merging lists
  #============================================================================
  Merged_Lists.list = RS.fMRI_1.2_Merging.Lists(Subjects.list, path_Rda, what.date)



  #============================================================================
  # 3.Exporting Results
  #============================================================================
  RS.fMRI_1.3_Exporting.Lists(Merged_Lists.list, path_Subjects, path_Rda)


  ### returning results
  text = paste("\n","Step 1 is all done !","\n")
  cat(crayon::bgRed(text))
}






