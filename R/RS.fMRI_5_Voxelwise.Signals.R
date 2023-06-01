RS.fMRI_5_Voxelwise.Signals = function(path_Preprocessing.Completed,
                                       what.result.folder = "FunImgARCWSF",
                                       Atlas = c("AAL1"),
                                       Standardization.Method=c("NULL", "Z.standardization"),
                                       save_path,
                                       RID, Include.Raw){
  # Clipboard_to_path()
  # path_Preprocessing.Completed = "E:/ADNI/ADNI_RS.fMRI___SB/(완료)Preprocessing___MNI_EPI___AuotoMask___X___Philips___AAL1"
  # save_path = "E:/test_GroupMasking_After_Normalization_MNI/Voxelwise_BOLD_Signals"
  # what.result.folder = "FunImgARCWSF"
  #=============================================================================
  # Extracting volumes path
  #=============================================================================
  path_Subjects = fs::dir_ls(paste0(path_Preprocessing.Completed, "/", what.result.folder), type = "dir") %>% sort
  Subjects = basename(path_Subjects)
  path_Volumes = sapply(path_Subjects, function(y){ list.files(y, full.names=T) })




  #=============================================================================
  # Extracting FC ROI path
  #=============================================================================
  path_FCROI = list.files(paste0(path_Preprocessing.Completed, "/Masks"), pattern = "FCROI", full.names=T) %>% sort





  #=============================================================================
  # Extracting BOLD signals
  #=============================================================================
  path_BOLD_Signals = list.files(paste0(path_Preprocessing.Completed, "/Results", "/ROISignals_", what.result.folder), pattern = "ROISignals_Sub", full.names=T) %>% sort %>% filter_by(include = "\\.txt", any_include = T, exact_include = F, exclude = "\\.mat", any_exclude = T, exact_exclude = F)




  #=============================================================================
  # Extracting ROI Order keys
  #=============================================================================
  path_ROI_Order_Keys = list.files(paste0(path_Preprocessing.Completed, "/Results", "/ROISignals_", what.result.folder), pattern = "ROI_OrderKey_Sub", full.names=T) %>% sort





  #=============================================================================
  # Extracting volumes & Exporting
  #=============================================================================
  Voxels_Coordinates.list = RS.fMRI_5_Voxelwise.Signals___Extractor(RID, Subjects, Atlas, Standardization.Method,
                                                                    path_Volumes, path_FCROI, path_BOLD_Signals, path_ROI_Order_Keys, save_path, Include.Raw)




  #=============================================================================
  # Exporting Report
  #=============================================================================
  saveRDS(object = Voxels_Coordinates.list, file = paste0(save_path, "/Each_RID_Voxels_Coordinates.rds"))



  cat("\n", crayon::bgMagenta("Step 5"),crayon::blue("Extracting and Saving Voxel-wise BOLD signals is done!"), "\n")
}












#
# Clipboard_to_path()
#
# path_volume = paste0("E:/ADNI/ADNI_RS.fMRI_2/Completed/GE.MEDICAL.SYSTEMS_SB___Sub_045___RID_4506/@Original_EPI/FunImgARCF/Sub_045/Filtered_4DVolume.nii")
#
# path_mask = paste0("E:/ADNI/ADNI_RS.fMRI_2/Completed/GE.MEDICAL.SYSTEMS_SB___Sub_045___RID_4506/@Original_EPI/Masks/WarpedMasks/", "Sub_045_GreyMask_02_91x109x91.nii")
# # Load the brain mask and the filtered 4D volume:
# Brain_Mask = RNifti::readNifti(path_mask)
# Filtered_4D_Volume = RNifti::readNifti(path_volume)
# dim(brain_mask)
# dim(filtered_4d_volume)
#
# test= Brain_Mask * Filtered_4D_Volume[,,,1]
#
# install.packages("corrplot")
# corrplot::corrplot(test[,,30])
# test[,,1] %>% corplot
# setwd("C:/Users/lleii/Desktop/test2")
# tictoc::tic()
# saveRDS(object = Filtered_4D_Volume, file = "test.RDS")
# tictoc::toc()
#
#
#
# # Load required packages
# library(ggplot2)
# library(reshape2)
# install.packages("reshape2")
# # Generate a random correlation matrix
# set.seed(123)
# n <- 10
# random_matrix <- matrix(runif(n * n), nrow = n)
# colnames(random_matrix) <- paste0("V", 1:n)
# rownames(random_matrix) <- paste0("V", 1:n)
#
# # Create a heatmap
# heatmap_data <- melt(test)
# colnames(heatmap_data) <- c("Var1", "Var2", "value")
#
#
# View(heatmap_data)
# ggplot(heatmap_data, aes(x = Var1, y = Var2, fill = value)) +
#   geom_tile() +
#   scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0.5) +
#   theme_minimal() +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
#
#
#
# #===========================================================================
# # Compare Brain Mask & Filterd_4D_Volume Dimension
# #===========================================================================
# if(sum(dim(Brain_Mask) == dim(Filtered_4D_Volume[,,,1])) == 3){
#   n_x = dim(Brain_Mask)[1]
#   n_y = dim(Brain_Mask)[2]
#   n_z = dim(Brain_Mask)[3]
# }else{
#   stop("The dimension of 'Brain_Mask' and 'Filtered_4D_Volume' is different.")
# }


#
#
# #===========================================================================
# # Compare Brain Mask & Filterd_4D_Volume
# #===========================================================================
# Is_Zero_Region_by_Brain_Maks_Same_with_Filtered_4D_Volume = c()
# Regions_Coordinates = c()
#
# 635
# x = 1
# y = 14
# z = 11
# tictoc::tic()
# for (x in 1:n_x) {
#   for (y in 1:n_y) {
#     for (z in 1:n_z) {
#       if(Brain_Mask[x, y, z] == 0){
#        Is_Zero_Region_by_Brain_Maks_Same_with_Filtered_4D_Volume = c(Is_Zero_Region_by_Brain_Maks_Same_with_Filtered_4D_Volume,
#                                                                      sum(as.numeric(Filtered_4D_Volume[x,y,z,]) == as.numeric(Brain_Mask[x, y, z])) == length(Filtered_4D_Volume[x,y,z,]))
#        Regions_Coordinates = c(Regions_Coordinates, paste(x,y,z,sep="_"))
#       }
#     }
#   }
# }
# tictoc::toc()





#
#
#
# # Apply the brain mask to the filtered 4D volume:
# masked_filtered_4d_volume <- filtered_4d_volume * brain_mask
#
#
# # Extract the voxel-wise signals and organize them in a matrix format:
# dims <- dim(masked_filtered_4d_volume)
# num_timepoints <- dims[4]
#
# # Create an empty matrix
# voxel_signals_matrix <- matrix(nrow = prod(dims[1:3]), ncol = num_timepoints)
#
# # Loop through the time points and extract the voxel-wise signals
# for (t in 1:num_timepoints) {
#   voxel_signals_matrix[, t] <- as.vector(masked_filtered_4d_volume[, , , t])
# }
#
# # Assign row names based on the x, y, z coordinates
# row_names_list <- expand.grid(x = 1:dims[1], y = 1:dims[2], z = 1:dims[3])
# row_names(voxel_signals_matrix) <- apply(row_names_list, 1, function(coord) paste(coord, collapse = "_"))
#
#
#
# # Remove rows with only zeros, which correspond to non-brain regions:
# non_zero_rows <- apply(voxel_signals_matrix, 1, function(x) any(x != 0))
# voxel_signals_matrix_cleaned <- voxel_signals_matrix[non_zero_rows, ]
#
# # Now, you have a matrix (voxel_signals_matrix_cleaned)
# # with columns representing time points and rows named with x, y, z coordinates, excluding non-brain regions.
#
#
#













# #=============================================================================
# # Extracting Mask path
# #=============================================================================
# RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Extract.Mask.Path = function(path_Preprocessing.Completed, DPABI.Template = "Original_EPI"){
#   #=============================================================================
#   # path & folders
#   #=============================================================================
#   path_Preprocessing.Completed = path_Preprocessing.Completed %>% path_tail_slash()
#   folders = list.files(path_Preprocessing.Completed)
#   folders_path = list.files(path_Preprocessing.Completed, full.names = T)
#
#
#
#
#   #=============================================================================
#   # template path & folders
#   #=============================================================================
#   template_path = sapply(folders_path, FUN=function(y,...){list.files(y, pattern = DPABI.Template, full.names = T)})
#
#
#
#   #=============================================================================
#   # Results path & folders
#   #=============================================================================
#   Results_path = sapply(template_path, FUN=function(y){list.files(y, pattern = what.result.folder, full.names = T)})
#   having_no_folder_named_what.result.folder = as.logical("0" %in% sapply(Results_path, length) %>% table %>% names)
#   if(having_no_folder_named_what.result.folder){
#     cat("\n", template_path[sapply(Results_path, length)==0], "\n")
#     stop("Therer are folders having no folder named 'what result.folder' !")
#   }
#
# }


