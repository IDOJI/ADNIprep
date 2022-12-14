RS.fMRI_3.2.Check.NIFTI.Converting___Extracting.Which.Subjects = function(manu_path, path_Subjects){
  # manu_path = "D:/ADNI/ADNI_RS.fMRI/1.SIEMENS_MB/"
  #===========================================================================
  # folder list and its path
  #===========================================================================
  manu_path = path_tail_slash(manu_path)
  FunImg_path = paste0(manu_path, "FunImg/")
  MT1Img_path = paste0(manu_path, "T1Img/")


  FunImg_folders = list.files(FunImg_path)
  MT1Img_folders = list.files(MT1Img_path)



  #===========================================================================
  # No nii files on Fun/MT1
  #===========================================================================
  which_Fun_sub_dont_have_nii = RS.fMRI_3.2.Check.NIFTI.Converting___Extracting.Which.Subjects___Which.Dont.Have.Nii(FunImg_path, FunImg_folders)
  which_MT1_sub_dont_have_nii = RS.fMRI_3.2.Check.NIFTI.Converting___Extracting.Which.Subjects___Which.Dont.Have.Nii(MT1Img_path, MT1Img_folders)



  #===========================================================================
  # Extract image ID
  #===========================================================================
  # manu_folder_name = strsplit(manu_path, "/")[[1]]
  # if(length(which_Fun_sub_dont_have_nii)>0){
  #   EPB_csv_path = list.files(paste0(path_Subjects, manu_folder_name[length(manu_folder_name)]), pattern = "EPB", full.names = T)
  #   EPB_ImageIDs = RS.fMRI_3.1.Check.NIFTI.Converting___Extracting.Which.Subjects___Extract.Which.Image.IDs(which_Fun_sub_dont_have_nii, EPB_csv_path)
  # }else{
  #   EPB_ImageIDs = NULL
  # }
  # if(length(which_MT1_sub_dont_have_nii)>0){
  #   MT1_csv_path = list.files(paste0(path_Subjects, manu_folder_name[length(manu_folder_name)]), pattern = "MT1", full.names = T)
  #   MT1_ImageIDs = RS.fMRI_3.1.Check.NIFTI.Converting___Extracting.Which.Subjects___Extract.Which.Image.IDs(which_MT1_sub_dont_have_nii, MT1_csv_path)
  # }else{
  #   MT1_ImageIDs = NULL
  # }



  #===========================================================================
  # Exporting image IDs
  #===========================================================================
  # if(!is.null(EPB_ImageIDs)){
  #   RS.fMRI_1.3_Exporting.List___SUB_Exporting.Image.ID(ImageID = EPB_ImageIDs$IMAGE_ID, filename = "[EPB] ImageIDs having converting-trouble", path = manu_path)
  #   EPB.df = data.frame(Sub_folders = which_Fun_sub_dont_have_nii,
  #                       ImageIDs    = EPB_ImageIDs$IMAGE_ID,
  #                       LONI_SERIES = EPB_ImageIDs$LONI_SERIES)
  #   write.csv(x = EPB.df, file = paste0(manu_path,"[EPB] ImageIDs with Subfolders.csv"))
  # }
  # if(!is.null(MT1_ImageIDs)){
  #   RS.fMRI_1.3_Exporting.List___SUB_Exporting.Image.ID(ImageID = MT1_ImageIDs$IMAGE_ID, filename = "[MT1] ImageIDs having converting-trouble", path = manu_path)
  #   MT1.df = data.frame(Sub_folders = which_MT1_sub_dont_have_nii,
  #                       ImageIDs    = MT1_ImageIDs$IMAGE_ID,
  #                       LONI_SERIES = MT1_ImageIDs$LONI_SERIES)
  #   write.csv(x = MT1.df, file = paste0(manu_path,"[MT1] ImageIDs with Subfolders.csv"))
  # }
  return(union(which_Fun_sub_dont_have_nii, which_MT1_sub_dont_have_nii))
  cat("\n", crayon::red("ImageIDs having trouble on converting to NIFTI is exported. Download this as NIFTI files."),"\n")
}
