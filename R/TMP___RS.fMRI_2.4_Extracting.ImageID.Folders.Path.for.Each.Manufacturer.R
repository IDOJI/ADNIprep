RS.fMRI_2.4_Extracting.ImageID.Folders.Path.for.Each.Manufacturer = function(path_Subjects, path_Subjects_RS.fMRI){

  #=============================================================================
  # ID folders : Subject ID, Image ID
  #=============================================================================
  Manu_folders = c(list.files(path_Subjects_RS.fMRI, pattern = "_MB"), list.files(path_Subjects_RS.fMRI, pattern = "_SB")) %>% sort
  IDs_for_each_manu.list = lapply(Manu_folders, FUN=function(ith_folder){
    # ith_folder = Manu_folders[2]
    ### extract image ID
    ith_Subjects_path  = paste0(path_Subjects, ith_folder, "/")
    ith_RS.fMRI_path   = paste0(path_Subjects_RS.fMRI, ith_folder, "/")

    ith_EPB = read.csv(list.files(ith_Subjects_path, pattern = "EPB", full.names = T)) %>% dplyr::select("SUBJECT.ID", "RID", "IMAGE_ID", "SERIES_DESCRIPTION")
    ith_MT1 = read.csv(list.files(ith_Subjects_path, pattern = "MT1", full.names = T)) %>% dplyr::select("SUBJECT.ID", "RID", "IMAGE_ID", "SERIES_DESCRIPTION")


    ### is SUBJECT.ID unique?
    have_same_RID = ith_EPB$RID %in% ith_MT1$RID
    have_same_Sub = ith_EPB$SUBJECT.ID %in% ith_MT1$SUBJECT.ID

    if(sum(have_same_RID) == nrow(ith_EPB) && sum(have_same_Sub) == nrow(ith_EPB)){
      ith_ID.list = list(Subjects_ID  = ith_EPB$SUBJECT.ID,
                         Image_ID_EPB = ith_EPB$IMAGE_ID,
                         Image_ID_MT1 = ith_MT1$IMAGE_ID)
      return(ith_ID.list)
    }else{
      stop("There are different SUBJECT.ID in EPB & MT1")
    }
  })
  names(IDs_for_each_manu.list) = Manu_folders



  #=============================================================================
  # Extract ImageID folders path for each manu
  #=============================================================================
  Downloaded_ADNI_path = paste0(path_Subjects_RS.fMRI, "ADNI/")
  # lapply =====================================================================
  ImageID_folder_path.list = lapply(Manu_folders, FUN=function(ith_Manu, ...){
    # ith_Manu = Manu_folders[3]
    ind_Manu = which(Manu_folders==ith_Manu)
    ith_Manu_ID.list = IDs_for_each_manu.list[[ind_Manu]]

    Sub.ID = ith_Manu_ID.list$Subjects_ID
    EPB.ID = ith_Manu_ID.list$Image_ID_EPB
    MT1.ID = ith_Manu_ID.list$Image_ID_MT1

    # lapply ===================================================================
    ith_Manu_ImageID_path.list = lapply(Sub.ID, FUN=function(ith_Sub.ID, ...){
      # ith_Sub.ID = Sub.ID[1]
      text0 = crayon::yellow(ith_Manu)
      text1 = crayon::green(":")
      text2 = crayon::red(ith_Sub.ID)
      text3 = crayon::green("DCM folder's path are extracted.")
      cat("\n", text0, text1, text2, text3, "\n")

      ### ith path
      ind = which(Sub.ID == ith_Sub.ID)

      ith_subject_path = paste0(Downloaded_ADNI_path, ith_Sub.ID, "/")

      return(list(EPB_ImageID = path_until_pattern(ith_subject_path, EPB.ID[ind]),
                  MT1_ImageID = path_until_pattern(ith_subject_path, MT1.ID[ind])))
    })
    numbering = 1:length(Sub.ID)
    if(numbering %>% nchar %>% max > 2){
      numbering_fitted = fit_length(numbering, numbering %>% nchar %>% max)
    }else{
      numbering_fitted = fit_length(numbering, 3)
    }
    return(ith_Manu_ImageID_path.list)
  })
  names(ImageID_folder_path.list) = Manu_folders






  #=============================================================================
  # Combining each MT1, EPB path for each Manufacturer
  #=============================================================================
  ImageID_folders_path_for_each_Manufacturer = lapply(ImageID_folder_path.list, FUN=function(ith_manu,...){
    # ith_manu = ImageID_folder_path.list[[1]]
    ith_manu_EPB_path = sapply(ith_manu, FUN=function(jth_sub){
      # jth_sub = ith_manu[[1]]
      return(jth_sub[[1]])
    })
    ith_manu_MT1_path = sapply(ith_manu, FUN=function(jth_sub){
      # jth_sub = ith_manu[[1]]
      return(jth_sub[[2]])
    })
    return(list(EPB=ith_manu_EPB_path, MT1=ith_manu_MT1_path))
  })
  names(ImageID_folders_path_for_each_Manufacturer) = Manu_folders
  return(ImageID_folders_path_for_each_Manufacturer)
}


