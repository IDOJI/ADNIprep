RS.fMRI_3.1.Before.Preprocessing___Check.Subjects.Folders = function(manu_path){
  ##############################################################################
  # path
  ##############################################################################
  manu_path = manu_path %>% path_tail_slash
  path_Fun_Folders = list.files(manu_path, "Fun", full.names = T)
  path_MT1_Folders = list.files(manu_path, "T1", full.names = T)
  path_Folders = c(path_Fun_Folders, path_MT1_Folders)



  ##############################################################################
  # Folders
  ##############################################################################
  Fun_Folders = list.files(manu_path, "Fun")
  MT1_Folders = list.files(manu_path, "T1")
  Folders = c(Fun_Folders, MT1_Folders)



  ##############################################################################
  # Exclude FunImgARCovs
  ##############################################################################
  have_FunImgARCovs = grep("FunImgARCovs", path_Folders)
  if(length(have_FunImgARCovs)>0){
    path_Folders = path_Folders[-have_FunImgARCovs]
    Folders = Folders[-have_FunImgARCovs]
  }



  ##############################################################################
  # The number of Sub folders
  ##############################################################################
  Each_Sub_Folders.list = lapply(path_Folders, FUN=function(ith_folder_path){
    list.files(ith_folder_path)
  })
  names(Each_Sub_Folders.list) = Folders



  ##############################################################################
  # Check the number of sub_folders of each folder pair
  ##############################################################################
  intersection_Sub = intersect_list(Each_Sub_Folders.list)
  setdiff_Sub = sapply(Each_Sub_Folders.list, FUN=function(ith_Sub_folder, ...){
    setdiff(ith_Sub_folder, intersection_Sub)
  })

  cat("\n", crayon::yellow("The list of Subjects to be removed"), "\n")
  return(setdiff_Sub)
}






















