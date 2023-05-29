RS.fMRI_4_Exclude.Error.Subjects.During.The.Preprocessing___Masks = function(is_Mask, ith_Folder, Subjects_Num){
  if(is_Mask){
    ith_Masks_path = list.files(ith_Folder, full.names=T)
    # Mask 내의 폴더
    Results = sapply(ith_Masks_path, function(y, ...){
      y = ith_Masks_path[1]
      # 각 Subjects 숫자 만큼
      for(nth_NUm in Subjects_Num){
        nth_files = list.files(ith_Masks_path, pattern = nth_Num, full.names = T)
        # 각 폴더 내의 파일들 제거
        nth_Results = sapply(nth_files, function(x, ...){
          # x = nth_files[1]
          try(fs::file_delete(x), silent = T)
          cat("\n", crayon::yellow("Excluding Error Subjects :"), crayon::red(basename(x)),"\n")
        })
      }
    })
  }
}
