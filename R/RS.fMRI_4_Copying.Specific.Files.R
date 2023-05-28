RS.fMRI_4_Copying.Specific.Files = function(path, destination, Files = NULL, Folders=NULL){
  # path = Clipboard_to_path()
  # destination = Clipboard_to_path()
  # Folders = c("FunImgAR", "T1ImgCoreg")
  #=============================================================================
  # list each RID folders
  #=============================================================================
  RID_folders = list.files(path)
  path_RID_folders = list.files(path, full.names=T)






  #=============================================================================
  # 1) Specified Files path
  #=============================================================================
  # if(!is.null(Files)){
  #   path_Specified.Files = lapply(path_RID_folders, FUN=function(y,...){
  #     index = list.files(y) %>% filter_by(include=Files, any_include = T, exact_include = F, as.ind = T)
  #     list.files(y, full.names=T)[index]
  #   })
  #   copy_files(path = list.files(path_Each_Specified_Folders[[1]][1], full.names=T), recursive_folder = NULL, copy.dir = F, destination = path_Modified_destination[1], overwrite = T)
  # }







  #=============================================================================
  # 2) Specified Folders path
  #=============================================================================
  if(!is.null(Folders)){
    path_Specified.Folders = lapply(seq_along(path_RID_folders), FUN=function(i,...){
      # Folders에 해당하는 폴더들의 path 추출
      index = list.files(path_RID_folders[i]) %>% filter_by(include=Folders, any_include = T, exact_include = F, as.ind = T)
      selected_path = list.files(path_RID_folders[i], full.names=T)[index]

      for(k in seq_along(selected_path)){
        copy_files(path = selected_path[k], is.path.dir = T, destination = file.path(destination, Folders)[k], overwrite = T, message = F)
      }

      cat("\n",  crayon::yellow("Copying files for preprocessing is done ! :"),  crayon::red(RID_folders[i]),"\n")
    })
  }

  cat("\n",  crayon::blue("Copying files for"),  crayon::bgRed("DPABI preprocessing"), crayon::blue("is done") ,"\n")
}
