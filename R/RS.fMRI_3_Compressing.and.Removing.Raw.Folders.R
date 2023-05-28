RS.fMRI_3_Compressing.and.Removing.Raw.Folders = function(path_Preprocessing.Completed,
                                                            hide.zip.file = T){
  # path_Preprocessing.Completed = Clipboard_to_path()
  # ith_path = "C:/Users/lleii/Desktop/Test"
  # which.Folders = c("FunImg")
  folders = list.files(path_Preprocessing.Completed)
  folders_path = list.files(path_Preprocessing.Completed, full.names = T)



  lapply(seq_along(folders), function(i, ...){
    ith_folder_name = folders[i]
    ith_path = folders_path[i]
    #===========================================================================
    # FunRaw & T1Raw path
    #===========================================================================
    ith_FunRaw_path = list.files(ith_path, full.names = T, pattern = "FunRaw")[list.files(ith_path, full.names = F, pattern = "FunRaw") == "FunRaw"]
    ith_MT1Raw_path = list.files(ith_path, full.names = T, pattern = "T1Raw")[list.files(ith_path, full.names = F, pattern = "T1Raw") == "T1Raw"]

    #===========================================================================
    # Check folder's existence : 어느 한 쪽만 있는 경우 에러, 둘 다 없으면 생략
    #===========================================================================
    if(length(ith_FunRaw_path) == 0 & length(ith_MT1Raw_path) != 0){
      stop(paste("There is no FunRaw files for", ith_folder_name))
    }else if(length(ith_FunRaw_path) != 0 & length(ith_MT1Raw_path) == 0){
      stop(paste("There is no T1Raw files for", ith_folder_name))
    }else if(length(ith_FunRaw_path)==0 & length(ith_MT1Raw_path) == 0){
      cat("\n", crayon::green("Compressing Raw folders is done :"), crayon::red(ith_folder_name), "\n")
    }else{
      RS.fMRI_3_Compressing.and.Removing.Raw.Folders___Having.Raw.Folders(ith_path, ith_folder_name, ith_FunRaw_path, ith_MT1Raw_path, hide.zip.file)
    }
  })

  cat("\n", crayon::bgMagenta("Step 3.7"), crayon::blue("Compressing and Removing Raw folders is done!"), "\n")
}







