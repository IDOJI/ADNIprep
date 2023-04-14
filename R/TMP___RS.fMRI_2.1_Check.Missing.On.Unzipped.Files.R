RS.fMRI_2.1_Check.Missing.On.Unzipped.Files = function(path_Subjects_RS.fMRI, path_Subjects){
  ### the number of unzipped folders
  unzipped_path = paste0(path_Subjects_RS.fMRI, "ADNI/")
  unzipped_file = list.files(unzipped_path)

  unzipped_folders = sapply(unzipped_file, FUN=function(x,...){
    # x = unzipped_file[1]
    list.files(paste0(unzipped_path, x)) %>% length
  })
  n_unzipped_folders = unique(unzipped_folders)

  ### Don't they have both fMRI & MRI?
  if(length(n_unzipped_folders)!=1  || sum(n_unzipped_folders==2)!=1){
    stop("There are subjects folders which don't have either fMRI or MRI !")
  }


  ### nrow
  All.Subjects_path = paste0(path_Subjects, list.files(path_Subjects, pattern = "All")) %>% list.files(pattern = "EPB",full.names = T)
  EPB_list = read.csv(All.Subjects_path)
  if(nrow(EPB_list) != length(unzipped_folders)){
    stop("There are some data which have not been unzipped !!")
  }
}
