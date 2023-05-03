RS.fMRI_3.3.After.Preprocessing___Check.The.Number.Of.Subjects = function(path_completed.folder){
  # path_completed.folder =
  path_completed.folder = path_completed.folder %>% path_tail_slash()

  path_folders_FunRaw = list.files(path_completed.folder, full.names = T) %>% paste0("/FunRaw/")
  num_sub_folders = lapply(path_folders_FunRaw, FUN=function(ith_path){
    # ith_path = path_folders_FunRaw[1]
    list.files(ith_path) %>% length
  }) %>% unlist %>% sum
  cat(crayon::green("The number of completed subjects is "), crayon::red(num_sub_folders))
}
