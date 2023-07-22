
# If you haven't installed the package yet, do so with this line:
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("neuRosim")

# Load the necessary package
library(neuRosim)

# Set the parameters for your simulation
n_voxels <- 50 # number of voxels
n_timepoints <- 120 # number of timepoints
n_subjects <- 1 # number of subjects

# Initialize a 4D array to store the simulated data
sim_data <- array(0, dim = c(n_voxels, n_voxels, n_voxels, n_timepoints))

# Fill the 4D array with simulated fMRI data
for (subject in 1:n_subjects) {
  sim_data <- create_data(dim = c(n_voxels, n_voxels, n_voxels, n_timepoints))
}

# Now, 'sim_data' is a 4D array that represents the fMRI data for a subject


# If you haven't installed the package yet, do so with this line:
# install.packages("neuroim")

# Load the necessary package
library(neuRoism)

# Set the parameters
n_scans = 120 # Number of timepoints
tr = 2 # Time between scans in seconds
voxel_size = c(3, 3, 3) # Size of voxels in mm
n_slices = 20 # Number of slices
matrix_size = c(64, 64, n_slices) # Dimensions of the brain image
n_subjects = 20 # Number of subjects

# Generate a mask
mask <- create_mask(dim = matrix_size, vox_dim = voxel_size)

# Use the 'generate_bold' function to simulate the BOLD response
sim_data <- lapply(1:n_subjects, simprepTemporal(totaltime, regions = NULL, onsets, durations,
                                                 TR, effectsize, accuracy=0.1,
                                                 hrf = c("gamma", "double-gamma", "Balloon"),
                                                 param = NULL)
                   function(x) {
  generate_bold(n_scans = n_scans, mask = mask, tr = tr)
})

# Now, 'sim_data' is a list of 4D arrays, where each array represents the BOLD response for a subject



seed1 <- NULL seed0 <- NULL

n1 <-n2 <-
  
  
  n <- n1 + n2
SNR <-
  #Evaluate and store results for ith observation for (i in 1:n1){
  seedi<-sample(1:10000,1)
seed1[[i]] <- seedi
}
for (i in 1:n2){
  seedi<-sample(1:10000,1)
  seed0[[i]] <- seedi
}
library(neuRosim)
#Parameters
dimx <- 20
dimy <- 20

dimz <- 10
nscan <- 100
TR <- 2
total <- TR*nscan
os <- seq(1, total, 20)
dur <- 7
regions <- simprepSpatial(regions = 2, coord = list(c(2, 2, 2),c(-2,-3,1)), radius = c(3,1), form = "sphere")

onset <- list(os,os)

duration <- list(dur, dur)

effect1 <- list(7, 15) effect2 <- list(12, 8)

design1 <- simprepTemporal (regions = 2, onsets = list(os,os), durations = duration, TR = TR, hrf = "double-gamma", effectsize = effect1, totaltime=total)
design2 <- simprepTemporal (regions = 2, onsets = list(os,os), durations = duration, TR = TR, hrf = "double-gamma", effectsize effect2, totaltime=total)
#Subjects 1-25

data <- NULL a <- NULL



for(i in 1:n1){
  set.seed(seed1[i])
  a <- simVOLfmri(design = design1, image = regions, base = 100, dim= c(dimx,dimy,dimz),SNR = SNR, noise = "mixture", type = "rician", rho.temp = c(0.142,0.108,0.084), rho.spat = 0.4, w= c(0.05,0.1,0.01,0.09,0.05,0.7))
  data[[i]] <- a
}



#Subjects 26-50 for(i in 1:n2){

set.seed(seed0[i])
a <- simVOLfmri(design = design2, image = regions, base = 100, dim= c(dimx,dimy,dimz),SNR = SNR, noise = "mixture", type = "rician", rho.temp = c(0.142,0.108,0.084), rho.spat = 0.4, w= c(0.05,0.1,0.01,0.09,0.05,0.7))
data[[i+n1]] <- a
}




################################################################################





















# If you haven't installed the package yet, do so with this line:
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("neuRosim")

# Load the necessary package
library(neuRosim)

# Set the parameters for your simulation according to the ADNI3 protocol
n_slices <- 48 # number of slices
slice_thickness <- 3.3 # slice thickness in mm
matrix_size <- c(64, 64) # matrix size (x and y dimensions)
n_timepoints <- 187 # number of timepoints
tr <- 3 # repetition time in seconds
te <- 30 # echo time in milliseconds

# Initialize a 4D array to store the simulated data
sim_data <- array(0, dim = c(matrix_size[1], matrix_size[2], n_slices, n_timepoints))


# Fill the 4D array with simulated fMRI data
for (timepoint in 1:n_timepoints) {
  sim_data[, , , timepoint] <- create_data(dim = c(matrix_size[1], matrix_size[2], n_slices))
}

# Now, 'sim_data' is a 4D array that represents the simulated fMRI data for a subject
#===============================================================================

## Generate fMRI slice for block design with activation in 2 regions

out <- simTSrestingstate(nscan=187, TR=3, SNR=1, noise="none") 
plot(out, type="l")















# load neuRosim library
library(neuRosim)



## Generate fMRI slice for block design with activation in 2 regions
design <- simprepTemporal(totaltime=200, onsets=seq(1,200,40),
                          durations=20, TR=2, effectsize=1, hrf="double-gamma")

design <- simTSrestingstate()

out <- simTSrestingstate(nscan=187, TR=3, SNR=1, noise="none") 
plot(out, type="l")

region <- simprepSpatial(regions=2, coord=list(c(32,15),c(57,45)),
                         radius=c(10,7), form="sphere")

out <- simVOLfmri(design=design, image=region, dim=c(64,64),
                  SNR=1, noise="none")
plot(out[32,15,], type="l")



