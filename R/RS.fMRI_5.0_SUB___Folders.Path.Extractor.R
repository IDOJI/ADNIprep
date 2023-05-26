RS.fMRI_4.0_SUB___Folders.Path.Extractor = function(Each_Folders_Path){
  split_path = strsplit(Each_Folders_Path, split = "/")
  folders = sapply(split_path, FUN=function(y){
    #y = split_path[[1]]
    y[length(y)]
  })
  return(folders)
}
