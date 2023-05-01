RS.fMRI_2.8_Creating.Slice.Order.Info.for.Philips = function(path_ADNI.Unzipped.Folders){
  #=============================================================================
  # list folders
  #=============================================================================
  folders = list.files(path_ADNI.Unzipped.Folders, pattern = "Philips")
  folders_path = list.files(path_ADNI.Unzipped.Folders, pattern = "Philips", full.names = T)



  #=============================================================================
  # Extract Sub.Num
  #=============================================================================
  Sub_Num = sapply(folders, FUN=function(ith_folder){
    # ith_folder = folders[1]
    strsplit(ith_folder, split = "___")[[1]][2]
  })
  names(Sub_Num) = NULL



  #=============================================================================
  # Extract Sub.Num
  #=============================================================================
  sapply(folders_path, FUN=function(ith_folder_path, ...){
    ind = which(folders_path == ith_folder_path)
    RS.fMRI_1.3_Exporting.Lists___SUB_Export.SliceOrderInfo(path = ith_folder_path, Sub_Num = Sub_Num[ind])
  })

  cat("\n", crayon::bgMagenta("Step 2.8"), crayon::red("Creating SliceOrderInfo.tsv for Philips"), crayon::blue("is done!"),"\n")
}
