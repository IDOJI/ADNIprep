RS.fMRI_5_BOLD.Signals___FDA___Cutting.Data.by.Min.Timepoints = function(path_Import, path_Subjects_List, path_Export=NULL, BAND.TYPE = "SB", Manufacturer = NULL){
  #=============================================================================
  # Export path
  #=============================================================================
  if(!is.null(path_Export)){
    dir.create(path_Export, showWarnings = F)
  }




  #=============================================================================
  # Select RID
  #=============================================================================
  Subjects_List.df = read.csv(path_Subjects_List)
  if(!is.null(Manufacturer)){
    RID_Selected = Subjects_List.df %>% filter(MANUFACTURER_NEW == paste(Manufacturer, BAND.TYPE, sep="_")) %>% dplyr::select(RID) %>% unlist %>% unname %>% sort
  }else{
    RID_Selected = Subjects_List.df %>% filter(NFQ___BAND.TYPE == BAND.TYPE) %>% dplyr::select(RID) %>% unlist %>% unname %>% sort
  }





  #=============================================================================
  # Loading RDS files & check the number of timepoints
  #=============================================================================
  Files_RID = list.files(path_Import) %>% str_extract("(?<=RID_)\\d+") %>% as.numeric
  path_Files = list.files(path_Import, full.names=T)
  path_Selected_Files = path_Files[which(Files_RID %in% RID_Selected)]
  min_timepoint = sapply(path_Selected_Files, function(y){
    readRDS(y) %>% nrow
  }) %>% min





  #===============================================================================
  # Cutting timepoints by the smallest one
  #===============================================================================
  # cutting
  Cut_Data.list = lapply(seq_along(path_Selected_Files), function(i, ...){
    # Loading Data
    ith_Cut_ith_Data = readRDS(path_Selected_Files[i])[1:min_timepoint, ]

    # Exporting Data
    if(!is.null(path_Export)){
      ith_File_Name = basename(path_Selected_Files[i]) %>% tools:::file_path_sans_ext()
      saveRDS(ith_Cut_ith_Data, paste0(path_Export, "/", ith_File_Name, "___", "Cut.for.FDA.rds"))
      cat("\n",crayon::yellow("The Cut for FDA file is done :"), crayon::red(paste0("RID_", Files_RID[i])),"\n")
    }
    return(ith_Cut_ith_Data)
  })


  names(Cut_Data.list) = paste0("RID_", fit_length(RID_Selected, 4))

  return(Cut_Data.list)
}
