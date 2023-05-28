RS.fMRI_4_Finding.Raw.Zip.Files = function(path_Preprocessing.Completed){



  path_Sub.Folders = fs::dir_ls(path_Preprocessing.Completed)


  #=============================================================================
  # path Not Having zip file
  #=============================================================================
  path_Not.Having.Zip.Files = lapply(path_Sub.Folders, function(y){
    if(! grep("\\.zip", list.files(y)) %>% length > 0){
      return(y)
    }
  }) %>% rm_list_null() %>% unlist() %>% rm_vec_names()




  #=============================================================================
  # Extracting Raw folder's path for each Sub folder
  #=============================================================================
  path_Each.Raw.Folder = sapply(path_Not.Having.Zip.Files, function(x){
    # x = path_Not.Having.Zip.Files[1]
    list.files(x, pattern="Raw", full.names=T)
  })







  #=============================================================================
  # Moving zip files for path of 1 Raw folder
  #=============================================================================
  n_Raw.Folders = sapply(path_Each.Raw.Folder, length) %>% rm_vec_names
  path_Having.1.Raw.Folders = path_Not.Having.Zip.Files[which(n_Raw.Folders==1)]
  sapply(path_Having.1.Raw.Folders[2:length(path_Having.1.Raw.Folders)], FUN=function(ith_path){
    ith_Raw_path = list.files(ith_path, pattern="Raw", full.names = T)
    move_files(path = ith_Raw_path, destination = ith_path)
  })







  #=============================================================================
  # Having 2 Raw folders?
  #=============================================================================
  path_Having.2.Raw.Folders = path_Not.Having.Zip.Files[which(n_Raw.Folders==2)]
  # 압축 코드


}
