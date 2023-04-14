###############################################################################
# Step 01 : Selecting subjects from subjects list files
###############################################################################
# list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/ADNIprep/R", full.names = T) %>% walk(source)
# list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/refineR/R", full.names = T) %>% walk(source)
RS.fMRI_1. = function(path_Subjects.Lists.Downloaded   = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Downloaded"),
                      path_Subjects.Lists.Exported = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Exported"),
                      path_ExportRda       = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Data"),
                      subjects_QC_ADNI2GO  = "MAYOADIRL_MRI_IMAGEQC_12_08_15",
                      subjects_QC_ADNI3    = "MAYOADIRL_MRI_QUALITY_ADNI3",
                      subjects_NFQ         = "MAYOADIRL_MRI_FMRI_NFQ_04_06_22",
                      subjects_search      = "idaSearch_4_11_2023",
                      what.date            = 1,
                      Exclude_RID          = NULL,
                      Exclude_ImageID = c("I1173062", "I971099", "I1021034", "I1606245", "I1329385", "I1557905", "I1567175", "I1628478", "I1173060", "I971096", "I1021033", "I1606240", "I1329390", "I1557901", "I1567174", "I1628474"),
                      Exclude_Comments = NULL){
  #============================================================================
  # 0.path
  #============================================================================
  path_Subjects.Lists.Downloaded = path_tail_slash(path_Subjects.Lists.Downloaded)
  path_Subjects.Lists.Exported = path_tail_slash(path_Subjects.Lists.Exported)





  #============================================================================
  # 1.Loading Subjects
  #============================================================================
  Subjects.list = RS.fMRI_1.1_Load.Subjects.As.List(path_Subjects.Lists.Downloaded,
                                                    subjects_QC_ADNI2GO,
                                                    subjects_QC_ADNI3,
                                                    subjects_NFQ,
                                                    subjects_search,
                                                    what.date,
                                                    Exclude_RID,
                                                    Exclude_ImageID,
                                                    Exclude_Comments)




  #============================================================================
  # 2. Merging lists
  #============================================================================
  Merged_Lists.list = RS.fMRI_1.2_Merging.Lists(Subjects.list)





  #============================================================================
  # 3.Exporting Results
  #============================================================================
  RS.fMRI_1.3_Exporting.Lists(Merged_Lists.list, path_Subjects.Lists.Downloaded, path_Subjects.Lists.Exported, path_ExportRda)


  ### returning results
  text = paste("\n","Step 1 is all done !","\n")
  cat(crayon::bgRed(text))
}





















#
# dim(new_EPB)
# new_EPB = read.csv("C:\\Users\\lleii\\Dropbox\\Github\\Rpkgs\\0.All_Subjects\\[Final_Selected]_Subjects_list_EPB_(0.All_Subjects).csv")
# new_MT1 = read.csv("C:\\Users\\lleii\\Dropbox\\Github\\Rpkgs\\0.All_Subjects\\[Final_Selected]_Subjects_list_MT1_(0.All_Subjects).csv")
#
# old_EPB = read.csv("C:\\Users\\lleii\\Dropbox\\Github\\Rpkgs\\ADNIprep\\Subjects_Lists_Exported\\0.All_Subjects\\[Final_Selected]_Subjects_list_EPB_(0.All_Subjects).csv")
# old_MT1 = read.csv("C:\\Users\\lleii\\Dropbox\\Github\\Rpkgs\\ADNIprep\\Subjects_Lists_Exported\\0.All_Subjects\\[Final_Selected]_Subjects_list_MT1_(0.All_Subjects).csv")
# dim(old_EPB)
# sum(old_EPB$IMAGE_ID %in% new_EPB$IMAGE.ID)
#============================================================================
# Path
#============================================================================
# path_ADNI                =   path_ADNI %>% path_tail_slash()
# path_Subjects            =   paste(path_ADNI, "ADNI_Subjects", sep="") %>% path_tail_slash()
# path_Subjects_Downloaded =   paste(path_Subjects, "Downloaded", sep="") %>% path_tail_slash()
