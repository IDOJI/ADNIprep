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
rm(list=ls())
require(dplyr)
require(tidyverse)
list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/ADNIprep/R", full.names = T) %>% walk(source)
list.files("C:/Users/IDO/Dropbox/Github/Rpkgs/refineR/R", full.names = T) %>% walk(source)


path_results = "C:/Users/IDO/Desktop/test/DPABI_results/Results/" %>% path_tail_slash
path_reulsts_Signals = paste0(path_results,  "ROISignals_FunImgARCWSF") %>% path_tail_slash()


ROI_Signals_files = list.files(path_reulsts_Signals, pattern = "ROISignals_Sub_", full.name=T)
ROI_Signals_txt_files = ROI_Signals_files[grep(".txt", ROI_Signals_files)]


#
# ROI_Signals_files.list = lapply(ROI_Signals_txt_files, FUN=function(ith_path, ...){
#   # ith_path = ROI_Signals_txt_files[1]
#   ith_Signals = read.table(ith_path)
#   names(ith_Signals) = paste0("ROI_", 1:ncol(ith_Signals))
#   return(ith_Signals)
# })

#
# ### Extracting Pearson correlation
# _Extracting.Pearson.Correlation = function(ROI_Signals_files.list, save.path){
#   lapply(ROI_Signals_files.list, FUN=function(ith_Signals, ...){
#     ith_cormat = cor(ith_Signals, method="pearson")
#     png()
#     corrplot::corrplot(ith_cormat, method="color",  tl.pos='n')
#     dev.off()
#     ith_cormat_FisherZ = DescTools::FisherZ(rho = ith_cormat) # pearson's corr
#     write.csv()
#   })
# }




### 각 correlation 행렬 결과 그림으로 내보내기




