RS.fMRI_3.2.During.Preprocessing___Excludinig.Folders = function(manu_path, folder_name, ex_sub_folders){
  # manu_path
  manu_path = manu_path %>% path_tail_slash()
  if(!is.null(ex_sub_folders)){
    ### creating path to move to -----------------------------------------------
    splitted_path = strsplit(x = manu_path, split = "/")[[1]]
    path_ex = paste0(manu_path, splitted_path[length(splitted_path)], "_", folder_name) %>% path_tail_slash()
    dir.create(path_ex, showWarnings = F)


    ### defining preprocessing folders -----------------------------------------------
    folders = list("FunRaw", "FunImg", "FunImgA", "FunImgAR",
                   "T1Raw", "T1Img", "T1ImgBet", "T1ImgCoreg",
                   "RealignParameter")


    ### moving folders -----------------------------------------------
    lapply(ex_sub_folders, FUN=function(kth_sub,...){
      # kth_sub = ex_sub_folders[1]
      lapply(folders, FUN=function(ith_folder){
        # ith_folder = folders[[1]]
        from_path = paste0(manu_path, ith_folder, "/", kth_sub)
        to_path = paste0(path_ex, ith_folder, "/", kth_sub)
        copy_files_fast(from_path, to_path, move = T, overwrite = T)
        cat("\n", crayon::yellow("Moving"), crayon::red(ith_folder), crayon::yellow("of"), crayon::red(kth_sub), crayon::yellow("is done!"), "\n")
      })
    })
  }
}

