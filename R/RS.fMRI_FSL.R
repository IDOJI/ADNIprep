# # Load necessary packages
# library(oro.nifti)
#
# # Set input and output filenames
# input <- "resting_state.nii.gz"
# output <- "resting_state_preprocessed.nii.gz"
#
# # Motion correction
# system(paste("mcflirt -in", input, "-out", "rest_mc.nii.gz -plots -rmsrel -rmsabs"))
#
# # Slice timing correction
# system(paste("slicetimer -i rest_mc.nii.gz -o rest_stc.nii.gz --tcustom=custom.txt"))
#
# # Brain extraction
# system(paste("bet rest_stc.nii.gz rest_brain.nii.gz -F"))
#
# # Registration to MNI space
# system(paste("flirt -in rest_brain.nii.gz -ref MNI152_T1_2mm_brain.nii.gz -omat rest2mni.mat -dof 12"))
#
# # Normalization
# system(paste("fnirt --in=rest_brain.nii.gz --aff=rest2mni.mat --cout=rest2mni_warp --ref=MNI152_T1_2mm.nii.gz --iout=rest_norm.nii.gz"))
#
# # Smoothing
# system(paste("fslmaths rest_norm.nii.gz -s 6 rest_smooth.nii.gz"))
#
# # Bandpass filtering
# system(paste("fslmaths rest_smooth.nii.gz -bptf 0.01 0.1 rest_filtered.nii.gz"))
#
# # Save preprocessed data as NIfTI file
# system(paste("fslchfiletype NIFTI_GZ rest_filtered.nii.gz", output))
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
