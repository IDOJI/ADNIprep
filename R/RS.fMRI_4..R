# Step_5_Extract_Results = function(path_ADNI.folder="E:/ADNI", All_Subjects=F){
#   #============================================================================
#   # Packages
#   #============================================================================
#   # require(dplyr)
#   # require(refineR)
#   # require(ADNIprep)
#   # detach(ADNIprep)
#   # devtools::install_github("IDOJI/ADNIprep", force=T)
#   #
#
#   #============================================================================
#   # Path
#   #============================================================================
#   path_ADNI =  path_ADNI.folder %>% path_tail_slash()
#   path_Subjects = paste(path_ADNI, "ADNI_Subjects", sep="") %>% path_tail_slash()
#   path_fMRI = paste(path_ADNI, "ADNI_fMRI", sep="") %>% path_tail_slash()
#
#
#
#   #============================================================================
#   # folders list
#   #============================================================================
#   folders = list.files(path_fMRI)
#   folders_manu = have_this(folders, this=paste(c(0:3), "_", sep=""))
#   if(All_Subjects){
#     folders_manu = folders_manu[1]
#   }else{
#     folders_manu = folders_manu[-1]
#   }
#
#   #============================================================================
#   # Extracting Results
#   #============================================================================
#
#
#   extract_FC()
#   extract_ROI_Signals()
#
#   merge_with_TR_info()
# }
#
# # TR info 읽어오기
