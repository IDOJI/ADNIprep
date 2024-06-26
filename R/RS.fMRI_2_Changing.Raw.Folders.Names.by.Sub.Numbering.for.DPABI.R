RS.fMRI_2_Changing.Raw.Folders.Names.by.Sub.Numbering.for.DPABI = function(path_ADNI.Unzipped.Folders){
  #===========================================================================================
  # path & folders
  #===========================================================================================
  Unzipped.Folders = list.files(path_ADNI.Unzipped.Folders)
  path_Unzipped.Folders = list.files(path_ADNI.Unzipped.Folders, full.names = T)



  #===========================================================================================
  # Extracting Sub Numbering
  #===========================================================================================
  Sub_Num = sapply(Unzipped.Folders, FUN=function(ith_folder_name){
    stringr::str_extract(ith_folder_name, "Sub_\\d+")
  }) %>% unname



  #===========================================================================================
  # Change folders names to FunRaw & T1Raw
  #===========================================================================================
  Results = sapply(seq_along(path_Unzipped.Folders), FUN=function(i, ...){
    # ith_path = path_Unzipped.Folders[1]
    ith_path = path_Unzipped.Folders[i]
    ith_folders = list.files(ith_path)

    Have_FunRaw = grep("FunRaw", ith_folders) %>% length > 0
    Have_FunImg = grep("FunImg", ith_folders) %>% length > 0

    if(!Have_FunRaw & !Have_FunImg){
      ith_folders_path = list.files(ith_path, full.names = T)

      # EPI, MT1 folders path
      ith_EPI_folder_path = ith_folders_path[grep("Axial", ith_folders)]
      ith_MT1_folder_path = ith_folders_path[-grep("Axial", ith_folders)]

      # Fining Image Folders for each Series_Type
      ith_EPI_date_path = list.files(ith_EPI_folder_path, full.names = T)
      ith_MT1_date_path = list.files(ith_MT1_folder_path, full.names = T)

      ith_EPI_Image_path = list.files(ith_EPI_date_path, full.names = T)
      ith_MT1_Image_path = list.files(ith_MT1_date_path, full.names = T)


      # Changing folders Names
      dir.create(paste0(ith_path, "/", "FunRaw"), T)
      dir.create(paste0(ith_path, "/", "T1Raw"), T)
      file.rename(from = ith_EPI_Image_path, to = paste0(ith_path, "/", "FunRaw", "/", Sub_Num[i])) %>% invisible
      file.rename(from = ith_MT1_Image_path, to = paste0(ith_path, "/", "T1Raw", "/", Sub_Num[i])) %>% invisible


      # deleting the former folders
      unlink(ith_EPI_folder_path, recursive = T)
      unlink(ith_MT1_folder_path, recursive = T)
    }

    cat("\n", crayon::green("Renaming FunRaw and T1Raw is done : "), crayon::bgRed(Unzipped.Folders[i]), "\n")
  })


  cat("\n", crayon::red("Step 2.6"), crayon::blue("Changing Folder's names for DPABI"), "\n")
}
