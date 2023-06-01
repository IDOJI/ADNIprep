RS.fMRI_5_Extracting.Results___Voxel.Wise.Signals___Extract.Voxel.BOLD.Signals.Grouped.by.ROI = function(ith_Volume.mat, ith_FC_Mask.vec, ith_BOLD_Signals){
  ### Label
  ith_FC_Mask_Label = ith_FC_Mask.vec %>% table %>% names %>% as.numeric %>% sort
  ith_FC_Mask_Label = ith_FC_Mask_Label[-1]




  ### Voxel Coordinates
  ith_FC_Mask_Voxel_Coordinates = names(ith_FC_Mask.vec)


  #=========================================================================
  # select by ROIs
  #=========================================================================
  ith_ROI_BOLD_Signals.list = lapply(ith_FC_Mask_Label, function(ith_ROI, ...){
    ith_ROI = 100
    which_ith_ROI_Voxels = which(ith_FC_Mask.vec==ith_ROI)

    ### ith ROI voxels in Volume
    ith_ROI_Volume = ith_Volume.mat[which_ith_ROI_Voxel, ]


    ### Check Voxel Coordinates
    ith_ROI_Voxel_Coordinates = ith_FC_Mask_Voxel_Coordinates[which_ith_ROI_Voxel]
    if(sum(ith_ROI_Voxel_Coordinates == rownames(ith_ROI_Volume)) != length(ith_ROI_Voxel_Coordinates)){
      stop(paste0(ith_ROI, "different coordinates voxels exist"))
    }


    ### Check BOLD signals averaging
    ith_ROI_Averaged_BOLD = apply(ith_ROI_Volume, MARGIN=2, mean)
    ith_ROI_BOLD_Signals_DPABI = ith_BOLD_Signals[, ith_ROI]
    if(sum(round(ith_ROI_Averaged_BOLD, 8) == round(ith_ROI_BOLD_Signals_DPABI, 8)) != length(ith_ROI_BOLD_Signals_DPABI)){
      stop(paste0(ith_ROI, "different BOLD signals"))
    }


    return(ith_ROI_Volume)
  })


  return(ith_ROI_BOLD_Signals.list)
}


# ROI_FCMap_Sub_001[,1]
# ROI_FCMap_Sub_001 =read.table("E:/ADNI/ADNI_RS.fMRI___SB/(완료)Preprocessing___MNI_EPI___AuotoMask___X___Philips___AAL1/Results/FC_FunImgARCWSF/ROI_FCMap_Sub_001.txt")
# ROI_1 = readNIfTI("E:/ADNI/ADNI_RS.fMRI___SB/(완료)Preprocessing___MNI_EPI___AuotoMask___X___Philips___AAL1/Results/FC_FunImgARCWSF/zROI1FCMap_Sub_001.nii")
# as.vector(ROI_1)[which_ith_ROI_Voxels]









folders = fs::dir_ls("E:/ADNI/ADNI_RS.fMRI___SB/Preprocessing___MNI_EPI___AuotoMask___O___Philips/FunImgARCWSF")
n_files =  sapply(folders, function(y){
    path_sym = list.files(y, full.names=T, pattern = "sym")
    fs::file_delete(path_sym)
  })

Clipboard_to_path()



