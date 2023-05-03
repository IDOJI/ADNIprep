RS.fMRI_3.1_Moving.Specific.Folders = function(path_ADNI.Unzipped.Folders, destination, keywords = c("PicturesForChkNormalization", "EPI")){
  # destination = "E:/ADNI/ADNI_RS.fMRI_2/@완료"
  #=============================================================================
  # folders list
  #=============================================================================
  destination = destination %>% path_tail_slash()
  path_folders = list.files(path_ADNI.Unzipped.Folders, full.names = T)
  folders = list.files(path_ADNI.Unzipped.Folders, full.names = F)

  sapply(path_folders, FUN=function(ith_folder_path, ...){
    # ith_folder_path = path_folders[2]
    ind = which(path_folders == ith_folder_path)



    ### Do the path have the keywords?
    have_keywords = sapply(keywords, FUN=function(ith_keyword, ...){
      list.files(ith_folder_path, pattern = ith_keyword) %>% length > 0
    }) %>% sum


    if(have_keywords > 0){
      ith_destination = paste0(destination, folders[ind])
      # fs::file_move(path = ith_folder_path, new_path = ith_destination)
      file.rename(from = ith_folder_path, to = ith_destination)
      cat("\n", crayon::green("Moving folders is done : "), crayon::red(folders[ind]), "\n")
    }


  })

  cat("\n", crayon::bgMagenta("Step 3.1."), crayon::red("Moving specific folders"), crayon::blue("is done!"),"\n")

}
