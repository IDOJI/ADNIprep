RS.fMRI_2.2_Finding.Zip.Files = function(path_ADNI.Unzipped.Folders,
                                         path_Export.Folders.List = paste0(path_OS, "Dropbox/Github/Rpkgs/ADNIprep/Subjects_Lists_Checking_Before_Preprocessing")){
  #=============================================================================
  # path & dir
  #=============================================================================
  dir.create(path_Export.Folders.List, showWarnings = F)
  path_Export.Folders.List = path_Export.Folders.List %>% path_tail_slash()




  #=============================================================================
  # ADNI folders
  #=============================================================================
  ADNI_Unzipped_Folders_List = list.files(path_ADNI.Unzipped.Folders)
  path_ADNI_Unzipped_Folders_List = list.files(path_ADNI.Unzipped.Folders, full.names = T)





  #=============================================================================
  # Finding zip
  #=============================================================================
  Folders.list = list()
  path_Folders.list = list()
  for(i in 1:length(path_ADNI_Unzipped_Folders_List)){
    ith_path = path_ADNI_Unzipped_Folders_List[i]
    ith_zip_file = list.files(ith_path, pattern = "\\.zip")
    if(length(ith_zip_file) > 0){
      Folders.list[[i]] = ADNI_Unzipped_Folders_List[i]
      path_Folders.list[[i]] = ith_path
    }
  }
  zip_files.df = data.frame(Folder = unlist(Folders.list), path = unlist(path_Folders.list)) %>% as_tibble




  #=============================================================================
  # path 리스트에 따라 raw 폴더가 있으면, raw zip 파일 삭제
  #=============================================================================
  for(r in 1:nrow(zip_files)){
    rth_path = zip_files.df[r, 2] %>% unlist
    rth_zip.file.path = list.files(rth_path, pattern = "\\.zip", full.names = T)
    rth_Raw_files = list.files(rth_path, pattern = "Raw")
    if(length(rth_Raw_files)==2 && length(rth_zip.file) == 1){
      New_zip_files.df = zip_files.df[-r,]
      file.remove(rth_zip.file.path)
    }
  }




  write.csv(x = New_zip_files.df, file = paste0(path_Export.Folders.List, "Folders_Having_Zip_Files.csv"))
}
