RS.fMRI_4_Exclude.Error.Subjects.During.The.Preprocessing = function(path, Subjects_Num){
  # path = Clipboard_to_path()
  # Subjects_Num = c(62)
  #=============================================================================
  # Files list
  #=============================================================================
  path_dir = fs::dir_ls(path)

  path_Folders = path_dir[path_dir %>% fs::is_dir()]
  path_Files = path_dir[path_dir %>% fs::is_file()]




  #=============================================================================
  # Remove TRinfo
  #=============================================================================
  Results = sapply(path_Files, function(y){fs::file_delete(y)})
  cat("\n", crayon::yellow("Excluding Error Subjects :"), crayon::red("TRInfo.tsv"),"\n")



  #=============================================================================
  # Number
  #=============================================================================
  Subjects_Num = Subjects_Num %>% as.numeric() %>% fit_length(3)
  Subjects_Num = paste0("Sub_", Subjects_Num)



  #=============================================================================
  # Removing
  #=============================================================================
  Results = sapply(path_Folders, function(ith_Folder,...){
    have_Sub_Files = list.files(ith_Folder, "Sub_") %>% length > 0

    # Sub_Num 이 포함된 파일을 갖고 있으면
    if(have_Sub_Files){
      for(n in seq_along(Subjects_Num)){
        RS.fMRI_4_Exclude.Error.Subjects.During.The.Preprocessing___Single.Subject(ith_Folder, Sub_Num = Subjects_Num[n])
      }
    }else{
      # Mask인 경우
      is_Mask = grep("Masks", ith_Folder) %>% length > 0
      RS.fMRI_4_Exclude.Error.Subjects.During.The.Preprocessing___Masks(is_Mask, ith_Folder, Subjects_Num)
    }
  })


  cat("\n", crayon::blue("Removing the specific subjects files is done!"),"\n")
}
