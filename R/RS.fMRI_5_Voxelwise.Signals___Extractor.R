RS.fMRI_5_Voxelwise.Signals___Extractor = function(RID, Subjects, Atlas, Standardization.Method=NULL, path_Volumes, path_FCROI, path_BOLD_Signals, path_ROI_Order_Keys, save_path, Include.Raw = T){
  Voxels_Coordinate.list = lapply(seq_along(path_FCROI), function(i, ...){
    #===========================================================================
    # Subjects
    #===========================================================================
    ith_RID = RID[i]
    ith_Sub = Subjects[i]



    #===========================================================================
    # 4D Volume
    #===========================================================================
    tictoc::tic()
    ith_path_Volume = path_Volumes[i]
    ith_Volume.mat = RS.fMRI_5_Voxelwise.Signals___Extractor___Matrix.From.4DVolume(path_4DVolume.nii = ith_path_Volume)
    tictoc::toc()
    cat("\n", crayon::yellow("Make 4DVolume.nii A Matrix :"), crayon::red(ith_Sub),"\n")




    #===========================================================================
    # FC ROI
    #===========================================================================
    tictoc::tic()
    ith_path_FCROI = path_FCROI[i]
    ith_FC_Mask.vec = RS.fMRI_5_Voxelwise.Signals___Extractor___Vectorize.FC.ROI.Mask(path_Mask = ith_path_FCROI)
    tictoc::toc()
    cat("\n", crayon::yellow("Vectorize FCROI.nii :"), crayon::red(ith_Sub),"\n")




    #===========================================================================
    # Standardization
    #===========================================================================
    tictoc::tic()
    if(!is.null(Standardization.Method)){
      ith_Volume_Standardized.mat = RS.fMRI_5_Voxelwise.Signals___Extractor___Standardization(ith_Volume.mat, ith_FC_Mask.vec, Standardization.Method)
      cat("\n", crayon::yellow("Standardization 4DVolume.nii :"), crayon::red(ith_Sub),"\n")
    }
    tictoc::toc()





    #===========================================================================
    # Grouping Voxels by ROIs : Comparing with DPABI ROI signals
    #===========================================================================
    tictoc::tic()
    ith_BOLD_Signals = read.table(path_BOLD_Signals[i])
    ith_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list = RS.fMRI_5_Voxelwise.Signals___Extractor___Grouping.by.ROI(ith_Volume.mat, ith_FC_Mask.vec, ith_BOLD_Signals)
    if(!is.null(Standardization.Method)){
      ith_Voxelwise_BOLD_Signals_Grouped_by_ROIs_Standardized.list = RS.fMRI_5_Voxelwise.Signals___Extractor___Grouping.by.ROI(ith_Volume_Standardized.mat, ith_FC_Mask.vec, ith_BOLD_Signals)
    }
    tictoc::toc()
    cat("\n", crayon::yellow("Grouping Voxelwise BOLD signals by ROI :"), crayon::red(ith_Sub),"\n")




    #===========================================================================
    # Labeling Brain Region by ROI order keys
    #===========================================================================
    tictoc::tic()
    ith_path_ROI_Order_Keys = path_ROI_Order_Keys[i]
    ith_Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list = RS.fMRI_5_Voxelwise.Signals___Extractor___ROI.Labeling(ith_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, ith_path_ROI_Order_Keys, Atlas)
    if(!is.null(Standardization.Method)){
      ith_Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs_Standardized.list = RS.fMRI_5_Voxelwise.Signals___Extractor___ROI.Labeling(ith_Voxelwise_BOLD_Signals_Grouped_by_ROIs_Standardized.list, ith_path_ROI_Order_Keys, Atlas)
    }
    tictoc::toc()
    cat("\n", crayon::yellow("Labeling Grouped Voxelwise BOLD signals by ROI :"), crayon::red(ith_Sub),"\n")






    #===========================================================================
    # Exporting
    #===========================================================================
    tictoc::tic()
    # Raw
    if(Include.Raw){
      RS.fMRI_5_Voxelwise.Signals___Extractor___Saving.RDS.Data(ith_RID, filename_suffix=NULL, save_path, ith_Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list)
    }
    # Standardized
    if(!is.null(Standardization.Method)){
      RS.fMRI_5_Voxelwise.Signals___Extractor___Saving.RDS.Data(ith_RID, filename_suffix=Standardization.Method, save_path, ith_Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list)
    }
    tictoc::toc()
    cat("\n", crayon::yellow("Exporting RDS data :"), crayon::red(ith_Sub),"\n")



    #===========================================================================
    # the number of voxels of each ROI & Coordinates
    #===========================================================================
    # ith_n_Voxels = lapply(ith_Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, nrow)
    ith_Voxels_Coordinates = lapply(ith_Labeled_Voxelwise_BOLD_Signals_Grouped_by_ROIs.list, rownames)


    #===========================================================================
    # Returning
    #===========================================================================
    cat("\n", crayon::blue("Extracting Voxelwise BOLD signals by ROI :"), crayon::bgMagenta(ith_Sub),"\n")
    return(ith_Voxels_Coordinates)
  })

  names(Voxels_Coordinate) = RID

  return(Voxels_Coordinate)
}
