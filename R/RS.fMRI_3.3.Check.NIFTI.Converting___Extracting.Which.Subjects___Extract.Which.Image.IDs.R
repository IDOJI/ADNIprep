RS.fMRI_3.2.Check.NIFTI.Converting___Extracting.Which.Subjects___Extract.Which.Image.IDs = function(which_sub_dont_have_nii, subjects_list_csv_path){
  # which_sub_dont_have_nii = which_Fun_sub_dont_have_nii
  which_sub_dont_have_nii_split = strsplit(which_sub_dont_have_nii, "_")
  which_rows_dont_have_nii = sapply(which_sub_dont_have_nii_split, FUN=function(x){
    # x = which_sub_dont_have_nii_split[[1]]
    x[2] %>% as.numeric %>% return
  })

  csv = read.csv(subjects_list_csv_path)
  return(csv[which_rows_dont_have_nii,c("LONI_SERIES", "IMAGE_ID")])
}
