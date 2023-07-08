# Clipboard_to_path()
# path_Voxelwise.Signals.Raw = "C:/Users/lleii/Dropbox/Github/Papers___Data/Papers___Data___ADNI___RS.fMRI___BOLD.Signals___Voxelwise___AAL3/Data___MNI__Raw"
# path_Export = "C:/Users/lleii/Dropbox/Github/Papers___Data/Papers___Data___ADNI___RS.fMRI___BOLD.Signals___ROI___AAL3/Data___MNI___Raw"
# RS.fMRI_5_ROI.BOLD.Signals___Calculating.From.Voxelwise.Signals = function(path_Voxelwise.Signals.Raw, path_Export){
#   #=============================================================================
#   # list files path
#   #=============================================================================
#   path_Files = list.files(path_Voxelwise.Signals.Raw, pattern = "\\.rds", full.names=T)
#
#
#
#   #=============================================================================
#   # Extracting Brain Region Labels from the first data
#   #=============================================================================
#   BOLD = readRDS(path_Files[1])
#   ROI_Label = names(BOLD)
#   ROI_Label_Rep = sapply(seq_along(ROI_Label), function(k, ...){
#     rep(ROI_Label[k], nrow(BOLD[[k]]))
#   }) %>% unlist
#
#
#
#
#   #=============================================================================
#   # Combining as list
#   #=============================================================================
#   for(i in seq_along(path_Files)){
#     ith_BOLD.list = readRDS(path_Files[i])
#     ith_Averaged_BOLD.list = lapply(ith_BOLD.list, function(y){
#       apply(y, 2, mean)
#     })
#   }
#
#
#   Combined.list = lapply(path_Files, function(ith_file, ...){
#     for()
#
#     tictoc::tic()
#     ith_BOLD.df = do.call(rbind, )
#     rownames(ith_BOLD.df) = paste(ROI_Label_Rep, rownames(ith_BOLD.df), sep = "___")
#     tictoc::toc()
#
#     head(ith_BOLD.df )
#
#     return(ith_BOLD.df)
#   })
#
#
#
#   lapply(path_Files, function(y, ...){
#     ith_Data = readRDS(y)
#
#
#   })
#
#
#
# }
#
# # files path list
# files = list.files("F:/Extracted_Results/Voxelwise_BOLD_Signals", full.names = T, pattern = "Z.standardization")
#
#
