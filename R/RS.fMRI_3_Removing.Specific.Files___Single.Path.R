RS.fMRI_3_Removing.Specific.Files___Single.Path = function(path,
                                                             recursive_folder=NULL,
                                                             files_list,
                                                             remove){
  #=============================================================================
  # files list
  #=============================================================================
  path = path %>% path_tail_slash() %>% paste0(recursive_folder)
  files = list.files(path)
  path_files = list.files(path, full.names = T)


  index = list.files(path) %>% filter_by(include = files_list, any_include = T, exact_include = T, as.ind = T)
  if(remove){
    path_files_new = path_files[index]
    files_to_remove = files[index]
  }else{
    path_files_new = path_files[-index]
    files_to_remove = files[-index]
  }



  #=============================================================================
  # Reselect files
  #=============================================================================
  sapply(path_files_new, FUN=function(k){
    unlink(k, recursive = T) %>% invisible
    cat("\n", crayon::yellow("Removing files : ") ,crayon::red(files_to_remove[which(path_files_new == k)]),"\n")
  })
}
