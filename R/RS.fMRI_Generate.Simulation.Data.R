# # Load necessary packages
# library(oro.nifti)
# library(neuRosim)
#
# # Set simulation parameters
# n_voxels <- 10000
# n_TR <- 200
# tr_duration <- 2
# noise_level <- 0.1
# signal_freqs <- c(0.01, 0.03)
#
# # Generate noise and signal time courses
# noise <- rnorm(n_voxels * n_TR, sd = noise_level)
# signal <- apply(sin(2 * pi * tr_duration * outer(1:n_TR, signal_freqs, "*")), 2, sum)
#
# # Combine noise and signal into fMRI time course
# fMRI <- matrix(0, nrow = n_voxels, ncol = n_TR)
# fMRI[] <- noise + signal
#
# # Save fMRI data as NIfTI file
# fMRI_array <- array(fMRI, dim = c(91, 109, 91, n_TR))
# fMRI_nii <- nifti(fMRI_array, type = "float")
#
# dim(fMRI_nii) <- list(91, 109, 91, n_TR)
#
# attributes(fMRI_nii)$pixdim <- c(2, 2, 2, tr_duration)
#
# fMRI_nii$intent_code <- 1007
# fMRI_nii$intent_name <- "NIFTI_INTENT_CONNECTIVITY_ESTIMATE"
# oro.nifti::writeNIfTI(fMRI_nii, filename = "resting_state_simulated.nii.gz")
#
#
#
#
# length(fMRI_nii)
#
#
#
