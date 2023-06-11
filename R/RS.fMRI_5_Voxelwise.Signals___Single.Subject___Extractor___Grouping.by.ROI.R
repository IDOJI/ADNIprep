RS.fMRI_5_Voxelwise.Signals___Single.Subject___Extractor___Grouping.by.ROI = function(Volume.mat, FC_Mask.vec, BOLD_Signals=NULL){
  ### Label
  FC_Mask_Label = FC_Mask.vec %>% table %>% names %>% as.numeric %>% sort
  FC_Mask_Label = FC_Mask_Label[FC_Mask_Label!=0]



  ### Voxel Coordinates
  FC_Mask_Voxel_Coordinates = names(FC_Mask.vec)


  #=========================================================================
  # select by ROIs
  #=========================================================================
  Voxelwise_ROI_BOLD_Signals.list = lapply(seq_along(FC_Mask_Label), function(i, ...){
    ith_ROI = FC_Mask_Label[i]
    which_ith_ROI_Voxels = which(FC_Mask.vec==ith_ROI)

    ### ith ROI voxels in Volume
    ith_ROI_Volume = Volume.mat[which_ith_ROI_Voxels, ]


    ### Check Voxel Coordinates
    ith_ROI_Coordinates = rownames(Volume.mat)[which_ith_ROI_Voxels]
    ith_ROI_Voxel_Coordinates = FC_Mask_Voxel_Coordinates[which_ith_ROI_Voxels]
    if(sum(ith_ROI_Voxel_Coordinates == ith_ROI_Coordinates) != length(ith_ROI_Coordinates)){
      stop(paste0(ROI, "different coordinates voxels exist"))
    }


    ### as matrix
    if(!is.matrix(ith_ROI_Volume) & is.vector(ith_ROI_Volume)){
      ith_ROI_Volume = matrix(ith_ROI_Volume, nrow=1)
      colnames(ith_ROI_Volume) = colnames(Volume.mat)
      rownames(ith_ROI_Volume) = ith_ROI_Coordinates
    }



    #### Averaged BOLD singnals
    ith_ROI_Averaged_BOLD = apply(ith_ROI_Volume, MARGIN=2, mean)


    ### Check BOLD signals averaging
    if(!is.null(BOLD_Signals)){
      ith_ROI_BOLD_Signals_DPABI = BOLD_Signals[, i]

      num_for_floor = 10^5
      ith_ROI_Averaged_BOLD_floor = floor(ith_ROI_Averaged_BOLD*num_for_floor)/num_for_floor
      ith_ROI_BOLD_Signals_DPABI_floor = floor(ith_ROI_BOLD_Signals_DPABI*num_for_floor)/num_for_floor

      ith_ROI_BOLD_Combined.df = data.frame(ith_ROI_Averaged_BOLD_floor, ith_ROI_BOLD_Signals_DPABI_floor, ith_ROI_Averaged_BOLD_floor == ith_ROI_BOLD_Signals_DPABI_floor)

      if(sum(ith_ROI_BOLD_Combined.df[,3]) != nrow(ith_ROI_BOLD_Combined.df)){
        stop(paste0(ith_ROI, "different BOLD signals"))
      }
    }
    return(ith_ROI_Volume)
  })
  return(Voxelwise_ROI_BOLD_Signals.list)
}


# ROI_FCMap_Sub_001[,1]
# ROI_FCMap_Sub_001 =read.table("E:/ADNI/ADNI_RS.fMRI___SB/(완료)Preprocessing___MNI_EPI___AuotoMask___X___Philips___AAL1/Results/FC_FunImgARCWSF/ROI_FCMap_Sub_001.txt")
# ROI_1 = readNIfTI("E:/ADNI/ADNI_RS.fMRI___SB/(완료)Preprocessing___MNI_EPI___AuotoMask___X___Philips___AAL1/Results/FC_FunImgARCWSF/zROI1FCMap_Sub_001.nii")
# as.vector(ROI_1)[which_ROI_Voxels]
