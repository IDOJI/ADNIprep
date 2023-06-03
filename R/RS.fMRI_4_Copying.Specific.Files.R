RS.fMRI_4_Copying.Specific.Files = function(path, destination, Files = NULL, Folders=NULL){
  # path = Clipboard_to_path()
  # destination = Clipboard_to_path()
  # Folders = c("FunImgAR", "T1ImgCoreg")
  #=============================================================================
  # list each RID folders
  #=============================================================================
  Folders = Folders %>% sort
  path_RID_folders = fs::dir_ls(path, type = "dir") %>% sort
  RID_folders = basename(path_RID_folders) %>% sort






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
      ith_RID = RID_folders[i]
      ith_RID_folder_path = path_RID_folders[i]
      ith_folders_index = list.files(ith_RID_folder_path) %>% filter_by(include=Folders, any_include = T, exact_include = T, as.ind = T) %>% sort
      ith_selected_path = list.files(ith_RID_folder_path, full.names=T)[ith_folders_index] %>% sort
      ith_destination = paste(destination, Folders, sep="/") %>% sort



      # Folders don't exist
      ith_Dont.Exist.Folder = Folders[! Folders %in% basename(ith_selected_path)]
      if(length(ith_Dont.Exist.Folder)>0){
        stop(paste(ith_RID, "don't have some folders : ", ith_Dont.Exist.Folder))
      }


      # Moving
      for(k in seq_along(ith_selected_path)){
        if(basename(ith_selected_path[k])==basename(ith_destination[k])){
          copy_files(path = ith_selected_path[k], is.path.dir = T, destination = ith_destination[k], overwrite = T, message = F)
        }else{
          stop(paste("The foder's name of selected folder and destination is different! : ", ith_RID))
        }
      }
      cat("\n",  crayon::yellow("Copying files for preprocessing is done ! :"),  crayon::red(RID_folders[i]),"\n")
    })

  }

  cat("\n",  crayon::blue("Copying files for"),  crayon::bgRed("DPABI preprocessing"), crayon::blue("is done") ,"\n")
}





















