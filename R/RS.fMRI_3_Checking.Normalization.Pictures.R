RS.fMRI_3_Checking.Normalization.Pictures = function(path_Preprocessing.Completed, path_Normalization.Pictures, preprocessing.template=NULL){
  # @Original_EPI 등의 템플릿 폴더에 옮겨놓았으면 preprocessing.template에 "EPI" 등의 키워드로 해당 폴더 지정하기
  #=============================================================================
  # create norm dir
  #=============================================================================
  dir.create(path = path_Normalization.Pictures, showWarnings = F)



  #=============================================================================
  # folders list
  #=============================================================================
  path_folders = list.files(path_Preprocessing.Completed, full.names = T)
  folders = list.files(path_Preprocessing.Completed, full.names = F)




  #=============================================================================
  # Moving images
  #=============================================================================
  sapply(path_folders, FUN=function(ith_folder_path, ...){
    # ith_folder_path = path_folders[2]
    ind = which(path_folders == ith_folder_path)


    # finding Pictures path

    if(!is.null(preprocessing.template)){
      have_preprocessing.template.folder = grep(pattern = preprocessing.template, x = list.files(ith_folder_path)) %>% length > 0
      if(have_preprocessing.template.folder){
        ith_folder_path = list.files(ith_folder_path, pattern = preprocessing.template, full.names = T)
      }
    }
    ith_Norm.Pictures.Folder_path = list.files(ith_folder_path, pattern = "PicturesForChkNormalization", full.names = T)
    ith_Norm.Pictures.File_path = list.files(ith_Norm.Pictures.Folder_path, pattern = "\\.tif$", full.names = T)
    ith_Norm.Pictures.File = list.files(ith_Norm.Pictures.Folder_path, pattern = "\\.tif$", full.names = F)


    # Extract Manufacturer
    ith_manu =  strsplit(x = folders[ind], split = "___")[[1]][1]
    ith_Norm.Pictures_Destination_path = paste0(path_Normalization.Pictures, "/", ith_manu)
    dir.create(ith_Norm.Pictures_Destination_path , showWarnings = F)


    # moving files
    fs::file_copy(path = ith_Norm.Pictures.File_path,
                  new_path = paste0(ith_Norm.Pictures_Destination_path, "/", ith_Norm.Pictures.File),
                  overwrite = T)
    # file.copy(from = ith_Norm.Pictures.File_path,
    #           to = )
    cat("\n", crayon::green("Copying Normalization Pictures is done : "), crayon::red(folders[ind]), "\n")
  })

  cat("\n", crayon::bgMagenta("Step 3"), crayon::red("Copying Normalization Pictures"), crayon::blue("is done!"),"\n")
}



















