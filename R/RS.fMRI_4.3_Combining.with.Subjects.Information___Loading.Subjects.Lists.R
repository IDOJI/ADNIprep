RS.fMRI_4.3_Combining.with.Subjects.Information___Loading.Subjects.Lists = function(path_Subjects, folders){
  ##############################################################################
  # path
  ##############################################################################
  folders_selected = filter_by(x=list.files(path_Subjects), including.words = folders, any_including.words = T)
  path_folders_selected = filter_by(list.files(path_Subjects, full.names = T), including.words = folders, any_including.words = T)




  ##############################################################################
  # Loading subjecsts list
  ##############################################################################
  subjects_lists.list = lapply(path_folders_selected, FUN=function(ith_path_folders){
    # ith_path_folders = path_folders_selected[1]
    cbind(read.csv(list.files(ith_path_folders, pattern = "EPB", full.names = T)), read.csv(list.files(ith_path_folders, pattern = "MT1", full.names = T)))
  })
  names(subjects_lists.list) = folders




  ##############################################################################
  # Adding "Sub"
  ##############################################################################
  subjects_lists_with_sub.list = lapply(subjects_lists.list, FUN=function(ith_subjects_list){
    # ith_subjects_list = subjects_lists.list[[1]]
    data.frame(Sub_folder = paste0("Sub_", fit_length(1:nrow(ith_subjects_list), 3)), ith_subjects_list)
  })


  return(subjects_lists_with_sub.list)
}







