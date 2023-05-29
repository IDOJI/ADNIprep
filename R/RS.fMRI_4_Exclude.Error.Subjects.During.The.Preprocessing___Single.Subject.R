RS.fMRI_4_Exclude.Error.Subjects.During.The.Preprocessing___Single.Subject = function(ith_Folder, Sub_Num){
  ith_Folder_Selected_Files_path = list.files(ith_Folder, pattern = Sub_Num, full.names=T)
  ith_Folder_Selected_Files = list.files(ith_Folder, pattern = Sub_Num, full.names=F)

  if(length(ith_Folder_Selected_Files_path)>0){
    Results = sapply(seq_along(ith_Folder_Selected_Files_path), function(k, ...){
      # 에러 발생 스킵
      try(fs::file_delete(ith_Folder_Selected_Files_path[k]), silent = T)


      # 파일인 경우
      if(fs::is_file(ith_Folder_Selected_Files_path[k])){
        cat("\n", crayon::yellow("Excluding Error Subjects :"), crayon::red(ith_Folder_Selected_Files[k]),"\n")
        # 폴더인 경우
      }else{
        kth_Splitted_Path = strsplit(ith_Folder_Selected_Files_path[k], split = "/")[[1]]
        kth_File = paste(kth_Splitted_Path[length(kth_Splitted_Path)-1], kth_Splitted_Path[length(kth_Splitted_Path)], sep="___")

        cat("\n", crayon::yellow("Excluding Error Subjects :"), crayon::red(kth_File),"\n")
      }
    })
  }
}
