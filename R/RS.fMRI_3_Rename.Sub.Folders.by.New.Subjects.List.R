RS.fMRI_3_Rename.Sub.Folders.by.New.Subjects.List = function(path_New.EPI.Subjects.Lists,
                                                             path_Sub.Folders,
                                                             filename_col_name){
  # path_Sub.Folders = "E:/ADNI/ADNI_RS.fMRI___SB/Error/_완전제외"
  #=============================================================================
  # Changing Sub folders' names
  #=============================================================================
  RS.fMRI_2_Changing.Folders.Names.By.Scanner.RID(path_New.EPI.Subjects.Lists,
                                                  path_Sub.Folders,
                                                  filename_col_name)





  #===============================================================================
  # Extract files list
  #===============================================================================
  path_Each.Sub.Folders = list.files(path_Sub.Folders, full.names=T)
  Sub.Folders = list.files(path_Sub.Folders)




  #===============================================================================
  # Extract Sub num
  #===============================================================================
  Sub_Num_New = sapply(Sub.Folders, function(y){
    stringr::str_extract(y, pattern = "Sub_\\d+")
  }) %>% unname



  #===============================================================================
  # FunImg Folder path
  #===============================================================================
  path_FunImg = paste0(path_Each.Sub.Folders,"/FunImg")




  #===============================================================================
  # Changing files' names
  #===============================================================================
  is_same_with_Old = sapply(seq_along(path_FunImg), function(i, ...){
    ith_Sub_Num_Old = list.files(path_FunImg[i], pattern="Sub_")
    ith_Sub_Num_New = Sub_Num_New[i]
    ith_Sub_path = path_Each.Sub.Folders[i]


    if(length(ith_Sub_Num_Old)==0){
      stop(paste0("There is no FunImg folder in ", ith_Sub_path))
    }


    if(ith_Sub_Num_Old != ith_Sub_Num_New){
      ### Change Directory First
      ith_dir_path = fs::dir_ls(ith_Sub_path, recurse = T, type = "dir")
      ith_dir_path_rearranged = ith_dir_path[order(stringr::str_length(ith_dir_path))]

      Results = sapply(ith_dir_path_rearranged, function(y, ...){
        if(grep("Sub_", basename(y)) %>% length > 0){
          new_path = gsub(pattern = ith_Sub_Num_Old, replacement = ith_Sub_Num_New, x = y)
          if(new_path != y){
            fs::file_move(path = y, new_path)
          }
          cat("\n", crayon::yellow("Directory's Name is being changed :"), crayon::red(basename(y)), "\n")
        }
      })


      ### Change Files Names
      ith_files_path = fs::dir_ls(ith_Sub_path, recurse = T, type = "file")
      Results = sapply(ith_files_path, function(y, ...){
        if(grep(ith_Sub_Num_Old, basename(y)) %>% length > 0){
          new_path = gsub(pattern = ith_Sub_Num_Old, replacement = ith_Sub_Num_New, x = y)
          if(new_path != y){
            fs::file_move(path = y, new_path)
          }
          cat("\n", crayon::yellow("File's Name is being changed :"), crayon::red(basename(y)), "\n")
        }
      })

    }
  })

  cat("\n", crayon::red("Chainging Sub numbering"), crayon::blue("is done!"), "\n")
}
