RS.fMRI_4.1_Pre.Steps___Extracting.Each.Folders.Path = function(path_completed.preprocessing, exclude.list, ){
  ### adding Sub
  exclude_added_sub.list = lapply(exclude.list, FUN=function(x){
    # x = exclude.list[[2]]
    if(!is.null(x)){
      return(paste0("Sub_", fit_length(x, 3)))
    }else{
      return(NULL)
    }
  })


  #############################################################################
  ### folders
  folders_list = gsub("list_", "", names(exclude.list))
  new_folders_list = paste0("[Prep_SelectEx]", folders_list)

  ### folders' path
  new_folders_path_list = paste0(path_ADNI_RS.fMRI, new_folders_list)


  ### change exclude.list names by each path
  names(exclude_added_sub.list) = new_folders_path_list

  return(exclude_added_sub.list)
}
