RS.fMRI_3.1.Check.NIFTI.Converting___Excludinig.Folders = function(manu_path, ex_sub_folders){
  # manu_path
  manu_path = manu_path %>% path_tail_slash()
  # EPB_csv = list.files(manu_path, "EPB", full.names = T)[2]
  # MT1_csv = list.files(manu_path, "MT1", full.names = T)[2]
  #
  # if(!is.na(EPB_csv)){
  #   EPB.df = read.csv(EPB_csv)
  # }
  #
  # if(!is.na(MT1_csv)){
  #   MT1.df = read.csv(MT1_csv)
  # }


  # ex_sub = union(EPB.df$Sub_folders, MT1.df$Sub_folders)


  if(!is.null(ex_sub_folders)){
    ### creating path to move to
    path_ex = paste0(manu_path, "_excluded_sub_folders")
    dir.create(path_ex, showWarnings = F)


    ### moving folders
    lapply(ex_sub_folders, FUN=function(x,...){
      # x = ex_sub_folders[1]
      main_name = c("Fun", "T1")
      sub_names = c("Raw", "Img")

      for(i in 1:2){
        for(j in 1:2){
          from_path = paste0(manu_path, main_name[i], sub_names[j], "/", x)
          to_path = paste0(path_ex, "/", main_name[i], sub_names[j], "/", x)
          copy_files_fast(from_path, to_path, move = T, overwrite = F)
        }
      }
    })
  }
}
