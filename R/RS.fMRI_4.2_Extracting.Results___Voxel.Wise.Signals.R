RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals = function(path_Preprocessing.Completed, what.result.folder = "FunImgARCF"){
  #=============================================================================
  # Extracting volumes path
  #=============================================================================
  path_Volumes = RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Extract.Volume.Path(path_Preprocessing.Completed, what.result.folder)



  #=============================================================================
  # Extracting Mask path
  #=============================================================================
  RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Extract.Mask.Path = function(path_Preprocessing.Completed, DPABI.Template = "Original_EPI"){
    #=============================================================================
    # path & folders
    #=============================================================================
    path_Preprocessing.Completed = path_Preprocessing.Completed %>% path_tail_slash()
    folders = list.files(path_Preprocessing.Completed)
    folders_path = list.files(path_Preprocessing.Completed, full.names = T)




    #=============================================================================
    # template path & folders
    #=============================================================================
    template_path = sapply(folders_path, FUN=function(y,...){list.files(y, pattern = DPABI.Template, full.names = T)})



    #=============================================================================
    # Results path & folders
    #=============================================================================
    Results_path = sapply(template_path, FUN=function(y){list.files(y, pattern = what.result.folder, full.names = T)})
    having_no_folder_named_what.result.folder = as.logical("0" %in% sapply(Results_path, length) %>% table %>% names)
    if(having_no_folder_named_what.result.folder){
      cat("\n", template_path[sapply(Results_path, length)==0], "\n")
      stop("Therer are folders having no folder named 'what result.folder' !")
    }

  }





  #=============================================================================
  # packages
  #=============================================================================
  # install.packages("RNifti")
  # library(RNifti)










  #=============================================================================
  # Mask files path
  #=============================================================================





  #=============================================================================
  # Loading & saving volume files
  #=============================================================================
  RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Loading(path)
  RS.fMRI_4.2_Extracting.Results___Voxel.Wise.Signals___Saving(save.path)


  sapply(path_folders, FUN=function(ith_path_folder, ...){
    # ith_path_folder = path_folders[1]
    volume_path = list.files(path = paste0(ith_path_folder, "/", what.result.folder), recursive = T, full.names = T)

    volume = RNifti::readNifti(volume_path)


    n_x = dim(volume)[1]
    n_y = dim(volume)[2]
    n_z = dim(volume)[3]
    n_t = dim(volume)[4] # TR

    bold_signals = array(0, dim = c(n_x * n_y * n_z, n_t))

    tictoc::tic()
    for (x in 1:n_x) {
      for (y in 1:n_y) {
        for (z in 1:n_z) {
          voxel_index = (x - 1) * n_y * n_z + (y - 1) * n_z + z
          bold_signals[voxel_index, ] = volume[x, y, z, ]
        }
      }
    }
    tictoc::toc()
    matplot(bold_signals, type = 'l')


    #===========================================================================
    # Timepoints
    #===========================================================================
    dims = dim(volume)
    num_timepoints = dims[4]

    # Create an empty matrix
    voxel_signals_matrix = matrix(nrow = prod(dims[1:3]), ncol = num_timepoints)

    # Loop through the time points and extract the voxel-wise signals
    for (t in 1:num_timepoints) {
      voxel_signals_matrix[, t] = as.vector(volume[, , , t])
    }

    # Assign row names based on the x, y, z coordinates
    row_names_list = expand.grid(x = 1:dims[1], y = 1:dims[2], z = 1:dims[3])
    rownames(voxel_signals_matrix) = apply(row_names_list, 1, function(coord) paste(coord, collapse = "_"))
    voxel_signals_matrix %>% View
    matplot(voxel_signals_matrix, type="l")
    dim(voxel_signals_matrix)



  })




}


Clipboard_to_path()

path_volume = paste0("E:/ADNI/ADNI_RS.fMRI_2/Completed/GE.MEDICAL.SYSTEMS_SB___Sub_045___RID_4506/@Original_EPI/FunImgARCF/Sub_045/Filtered_4DVolume.nii")

path_mask = paste0("E:/ADNI/ADNI_RS.fMRI_2/Completed/GE.MEDICAL.SYSTEMS_SB___Sub_045___RID_4506/@Original_EPI/Masks/WarpedMasks/", "Sub_045_GreyMask_02_91x109x91.nii")
# Load the brain mask and the filtered 4D volume:
Brain_Mask = RNifti::readNifti(path_mask)
Filtered_4D_Volume = RNifti::readNifti(path_volume)
dim(brain_mask)
dim(filtered_4d_volume)

Brain_Mask * Filtered_4D_Volume[,,,1]



#===========================================================================
# Compare Brain Mask & Filterd_4D_Volume
#===========================================================================
Brain_Mask[30,30,1]
Filtered_4D_Volume[30,30,1,]


tictoc::tic()
Brain_Mask_Vectorized = list()
for (x in 1:n_x) {
  for (y in 1:n_y) {
    for (z in 1:n_z) {
      Brain_Mask_Vectorized = volume[x, y, z, ]
    }
  }
}
 = sapply(1:dim(Brain_Mask)[1], FUN=function(x, ...)){
                          sapply(1:dim(Brain_Mask)[2], FUN=function(y, ...){
                            sapply(1:dim(Brain_Mask)[3], FUN=function(z, ...){
                              Brain_Mask[x,y,z,]
                            })
                          })
                        }
tictoc::toc()










# Apply the brain mask to the filtered 4D volume:
masked_filtered_4d_volume <- filtered_4d_volume * brain_mask


# Extract the voxel-wise signals and organize them in a matrix format:
dims <- dim(masked_filtered_4d_volume)
num_timepoints <- dims[4]

# Create an empty matrix
voxel_signals_matrix <- matrix(nrow = prod(dims[1:3]), ncol = num_timepoints)

# Loop through the time points and extract the voxel-wise signals
for (t in 1:num_timepoints) {
  voxel_signals_matrix[, t] <- as.vector(masked_filtered_4d_volume[, , , t])
}

# Assign row names based on the x, y, z coordinates
row_names_list <- expand.grid(x = 1:dims[1], y = 1:dims[2], z = 1:dims[3])
row_names(voxel_signals_matrix) <- apply(row_names_list, 1, function(coord) paste(coord, collapse = "_"))



# Remove rows with only zeros, which correspond to non-brain regions:
non_zero_rows <- apply(voxel_signals_matrix, 1, function(x) any(x != 0))
voxel_signals_matrix_cleaned <- voxel_signals_matrix[non_zero_rows, ]

# Now, you have a matrix (voxel_signals_matrix_cleaned)
# with columns representing time points and rows named with x, y, z coordinates, excluding non-brain regions.


