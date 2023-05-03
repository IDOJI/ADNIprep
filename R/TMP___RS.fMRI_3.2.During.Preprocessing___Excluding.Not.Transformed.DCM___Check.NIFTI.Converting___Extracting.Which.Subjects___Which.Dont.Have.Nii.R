RS.fMRI_3.2.During.Preprocessing___Check.NIFTI.Converting___Extracting.Which.Subjects___Which.Dont.Have.Nii = function(path, folders){
  which_sub_dont_have_nii = sapply(folders, FUN=function(x,...){
    # x = FunImg_folders[1]
    ith_files = list.files(paste0(path, x))
    have_nii  = grep(".nii", ith_files)
    if(length(have_nii)==0){
      return(x)
    }
  })
  which_sub_dont_have_nii = unlist(which_sub_dont_have_nii)
  names(which_sub_dont_have_nii)=NULL
  cat("\n", crayon::red("Check these Sub folders"),"\n")
  return(which_sub_dont_have_nii)
}
