RS.fMRI_4_Moving.Files.in.Original.EPI.Folders = function(path_Preprocessing.Completed){
  move_files(path=fs::dir_ls(path_Preprocessing.Completed),
             recursive_folder = sapply(fs::dir_ls(path_Preprocessing.Completed), list.files), destination = fs::dir_ls(path_Preprocessing.Completed))
}
