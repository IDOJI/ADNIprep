RS.fMRI_3.2.During.Preprocessing___Excludinig.Folders = function(manu_path, folder_name, ex_sub_folders){
  # manu_path
  manu_path = manu_path %>% path_tail_slash()
  if(!is.null(ex_sub_folders)){
    ### creating path to move to -----------------------------------------------
    splitted_path = strsplit(x = manu_path, split = "/")[[1]]
    path_ex = paste0(manu_path, splitted_path[length(splitted_path)], "_", folder_name) %>% path_tail_slash()
    dir.create(path_ex, showWarnings = F)


    ### defining preprocessing folders -----------------------------------------------
    folders = list(# sub_xxx folder
                   "FunRaw", "FunImg", "FunImgA", "FunImgAR",
                   "T1Raw", "T1Img", "T1ImgBet", "T1ImgCoreg",
                    "RealignParameter",
                   # Sub_xxx.tif
                   "PicturesForChkNormalization",
                   "Results")



    ### moving folders -----------------------------------------------
    lapply(ex_sub_folders, FUN=function(kth_sub,...){
      # kth_sub = ex_sub_folders[7]
      lapply(folders, FUN=function(ith_folder){
        # ith_folder = folders[[10]]
        from_path = paste0(manu_path, ith_folder, "/", kth_sub)
        to_path = paste0(path_ex, ith_folder, "/", kth_sub)

        if(ith_folder == "PicturesForChkNormalization"){
          dir.create(paste0(path_ex, ith_folder), showWarnings = F)
          file = list.files(paste0(manu_path, ith_folder), pattern = kth_sub, full.names = T)
          if(length(file)>0){
            filesstrings::file.move(files = paste0(from_path, ".tif"), destinations = paste0(path_ex, ith_folder), overwrite = T)
          }
        }else if(ith_folder == "Results"){
          from_path_1 = paste0(manu_path, ith_folder, "/FC_FunImgARCWSF")
          from_path_2 = paste0(manu_path, ith_folder, "/ROISignals_FunImgARCWSF")

          from_path_1_files = list.files(from_path_1, pattern = kth_sub, full.names = T)
          from_path_2_files = list.files(from_path_2, pattern = kth_sub, full.names = T)

          to_path_1 = paste0(path_ex, ith_folder, "/FC_FunImgARCWSF")
          to_path_2 = paste0(path_ex, ith_folder, "/ROISignals_FunImgARCWSF")

          dir.create(paste0(path_ex, ith_folder), showWarnings = F)
          dir.create(to_path_1, showWarnings = F)
          dir.create(to_path_2, showWarnings = F)

          filesstrings::file.move(files = from_path_1_files, destinations = to_path_1, overwrite = T)
          filesstrings::file.move(files = from_path_2_files, destinations = to_path_2, overwrite = T)

        }else{
          copy_files_fast(from_path, to_path, move = T, overwrite = T)
        }
        cat("\n", crayon::yellow("Moving"), crayon::red(ith_folder), crayon::yellow("of"), crayon::red(kth_sub), crayon::yellow("is done!"), "\n")
      })
    })
  }
}
























