###############################################################################
# Step 01 : Selecting subjects from subjects list files
###############################################################################
# list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/ADNIprep/R", full.names = T) %>% walk(source)
# list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/refineR/R", full.names = T) %>% walk(source)
RS.fMRI_1. = function(# path_Subjects.Lists.Downloaded   = "F:/ADNI/ADNI_Subjects/Downloaded",
                      path_Subjects.Lists.Downloaded = "/Users/Ido/Dropbox/Github/Rpkgs/ADNIprep/Downloaded_Subjects_Lists",
                      path_Subjects.Lists.Exported = "/Users/Ido/Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported",
                      path_ExportRda       =  "/Users/Ido/Dropbox/Github/Rpkgs/ADNIprep/Downloaded_Subjects_Lists",
                      subjects_search_fMRI = "idaSearch_3_26_2023_fMRI",
                      subjects_search_MRI  = "idaSearch_3_26_2023_MRI",
                      subjects_QC_ADNI2GO  = "MAYOADIRL_MRI_IMAGEQC_12_08_15",
                      subjects_QC_ADNI3    = "MAYOADIRL_MRI_QUALITY_ADNI3",
                      subjects_NFQ         = "MAYOADIRL_MRI_FMRI_NFQ_04_06_22",
                      what.date            = 1,
                      Exclude_RID          = NULL){
  #============================================================================
  # 0.path
  #============================================================================
  path_Subjects.Lists.Downloaded = path_tail_slash(path_Subjects.Lists.Downloaded)





  #============================================================================
  # 1.Loading Subjects
  #============================================================================
  Subjects.list = RS.fMRI_1.1_Load.Subjects.As.List(path_Subjects.Lists.Downloaded,
                                                    path_ExportRda,
                                                    subjects_search_fMRI,
                                                    subjects_search_MRI,
                                                    subjects_QC_ADNI2GO,
                                                    subjects_QC_ADNI3,
                                                    subjects_NFQ,
                                                    Exclude_RID)





  #============================================================================
  # 2. Merging lists
  #============================================================================
  Merged_Lists.list = RS.fMRI_1.2_Merging.Lists(Subjects.list, path_ExportRda, what.date)



  #============================================================================
  # 3.Exporting Results
  #============================================================================
  RS.fMRI_1.3_Exporting.Lists(Merged_Lists.list, path_Subjects.Lists.Downloaded, path_Subjects.Lists.Exported, path_ExportRda)


  ### returning results
  text = paste("\n","Step 1 is all done !","\n")
  cat(crayon::bgRed(text))
}






#============================================================================
# Path
#============================================================================
# path_ADNI                =   path_ADNI %>% path_tail_slash()
# path_Subjects            =   paste(path_ADNI, "ADNI_Subjects", sep="") %>% path_tail_slash()
# path_Subjects_Downloaded =   paste(path_Subjects, "Downloaded", sep="") %>% path_tail_slash()
