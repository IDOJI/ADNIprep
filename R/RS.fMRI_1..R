###############################################################################
# Step 01 : Selecting subjects from subjects list files
###############################################################################
# list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/ADNIprep/R", full.names = T) %>% walk(source)
# list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/refineR/R", full.names = T) %>% walk(source)

RS.fMRI_1. = function(path_Subjects.Lists_Downloaded,
                      path_Export_Subjects.Lists,
                      path_Export_Rda      = NULL,
                      Subjects_QC_ADNI2GO,
                      Subjects_QC_ADNI3,
                      Subjects_NFQ,
                      Subjects_search,
                      what.date            = 1,
                      Include_RID        = NULL,
                      Include_ImageID    = NULL,
                      Exclude_RID          = NULL,
                      Exclude_ImageID = NULL,
                      Exclude_Comments = NULL){
  # Only.This.RID : 지정된 RID에 해당하는 개체들에 대해서만 데이터 선택
  #============================================================================
  # 0.path
  #============================================================================
  path_Subjects.Lists_Downloaded = path_tail_slash(path_Subjects.Lists_Downloaded)
  path_Export_Subjects.Lists = path_tail_slash(path_Export_Subjects.Lists)
  dir.create(path_Subjects.Lists_Downloaded, showWarnings = F)
  dir.create(path_Export_Subjects.Lists, showWarnings = F)





  #============================================================================
  # 1.Loading Subjects
  #============================================================================
  Subjects.list = RS.fMRI_1.1_Load.Subjects.As.List(path_Subjects.Lists_Downloaded,
                                                    Subjects_QC_ADNI2GO,
                                                    Subjects_QC_ADNI3,
                                                    Subjects_NFQ,
                                                    Subjects_search,
                                                    what.date,
                                                    Include_RID,
                                                    Include_ImageID,
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
  RS.fMRI_1.3_Exporting.Lists(Merged_Lists.list,
                              path_Subjects.Lists_Downloaded,
                              path_Export_Subjects.Lists,
                              path_Export_Rda)




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
