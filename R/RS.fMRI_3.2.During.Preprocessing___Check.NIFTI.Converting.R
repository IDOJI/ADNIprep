RS.fMRI_3.2.During.Preprocessing___Check.NIFTI.Converting = function(manu_path, move=T){
  manu_path = manu_path %>% path_tail_slash()
  path_FunImg = paste0(manu_path, "FunImg")
  path_T1Img = paste0(manu_path, "T1Img")


  ### FunImg
  No_FunImg_Sub = lapply(list.files(path_FunImg, full.names = T), FUN=function(ith_path_FunImg){
    nii_files = list.files(ith_path_FunImg, pattern = "\\.nii")
    if(! length(nii_files)>0){
      ith_splitted = strsplit(ith_path_FunImg, split = "/")[[1]]
      return(ith_splitted[length(ith_splitted)])
    }
  }) %>% unlist


  ### TImg
  No_T1Img_Sub = lapply(list.files(path_T1Img, full.names = T), FUN=function(ith_path_T1Img){
    nii_files = list.files(ith_path_T1Img, pattern = "\\.nii")
    if(! length(nii_files)>0){
      ith_splitted = strsplit(ith_path_T1Img, split = "/")[[1]]
      return(ith_splitted[length(ith_splitted)])
    }
  }) %>% unlist


  ### No Img Sub
  No_Img_Sub = union(No_FunImg_Sub, No_T1Img_Sub)


  if(move){
    RS.fMRI_3.2.During.Preprocessing___Excludinig.Sub.Folders(manu_path, suffix = "NIFTI", which.sub.num = No_Img_Sub)
  }else{
    return(No_Img_Sub)
  }
}
