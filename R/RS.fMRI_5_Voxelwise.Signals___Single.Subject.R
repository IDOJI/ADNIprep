RS.fMRI_5_Voxelwise.Signals___Single.Subject = function(path_Preprocessed,
                                                        result.folder.name,
                                                        Atlas,
                                                        Standardization.Method,
                                                        path_save,
                                                        Include.Raw){
  #=============================================================================
  # Extracting volumes path
  #=============================================================================
  RID = strsplit(stringr::str_extract(path_Preprocessed, pattern="RID_\\d+"), "_")[[1]][2]
  path_Subject = fs::dir_ls(paste0(path_Preprocessed, "/", result.folder.name), type = "dir") %>% sort
  path_Volume = sapply(path_Subject, function(y){list.files(y, full.names=T) }) %>% unname



  #=============================================================================
  # Extracting FC ROI path
  #=============================================================================
  path_FCROI = list.files(paste0(path_Preprocessed, "/Masks"), pattern = "FCROI", full.names=T) %>% sort




  #=============================================================================
  # Extracting BOLD signals
  #=============================================================================
  path_BOLD_Signals = list.files(paste0(path_Preprocessed, "/Results", "/ROISignals_", result.folder.name), pattern = "ROISignals_Sub_", full.names=T) %>% sort %>% filter_by(include = "\\.txt", any_include = T, exact_include = F, exclude = "\\.mat", any_exclude = T, exact_exclude = F)




  #=============================================================================
  # Extracting ROI Order keys
  #=============================================================================
  path_ROI_Order_Keys = list.files(paste0(path_Preprocessed, "/Results", "/ROISignals_", result.folder.name), pattern = "ROI_OrderKey_Sub", full.names=T) %>% sort





  #=============================================================================
  # Extracting volumes & Exporting
  #=============================================================================
  Voxels_Coordinates.list = RS.fMRI_5_Voxelwise.Signals___Single.Subject___Extractor(RID, Atlas, Standardization.Method,
                                                                                      path_Volume, path_FCROI, path_BOLD_Signals, path_ROI_Order_Keys, path_save, Include.Raw)




}
