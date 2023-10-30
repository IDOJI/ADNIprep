RS.fMRI_5_Euclidean.Distance___Voxelwise.BOLD.Signals___Center.Coordinates___Split.Coordinates.As.DF = function(coordinates){
  x = as.integer(sub("_.*", "", coordinates))
  y = as.integer(sub(".*_(\\d+)_.*", "\\1", coordinates))
  z = as.integer(sub(".*_(\\d+)$", "\\1", coordinates))
  data.frame(x,y,z)
}
